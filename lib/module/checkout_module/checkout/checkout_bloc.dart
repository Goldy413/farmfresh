import 'package:farmfresh/module/bag_module/model/bag_model.dart';
import 'package:farmfresh/module/checkout_module/checkout_repository.dart';
import 'package:farmfresh/module/checkout_module/model/delivery_area.dart';
import 'package:farmfresh/module/checkout_module/model/payment_method_model.dart';
import 'package:farmfresh/module/checkout_module/model/place_order.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/device_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:place_picker/place_picker.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final BagModel bagModel;
  CheckoutRepository repo;
  List<PaymentMethod> paymentMethodItems = [];
  List<Address> addressItem = [];
  List<DeliveryArea> deliveryAreaItems = [];
  Address? selectedAddress;
  PaymentMethod? selectedPaymentMethod;

  double getDeliveryCharge(Address first) {
    deliveryAreaItems.sort(((a, b) => a.price.compareTo(b.price)));
    for (var delievryArea in deliveryAreaItems) {
      if (checkInPolyGon(
          LatLng(first.latitude, first.logitude), delievryArea.area)) {
        return delievryArea.price;
      }
    }

    return -1.0;
  }

  CheckoutBloc(this.bagModel, this.repo) : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) {});
    on<ChangeStateEvent>((event, emit) => emit(ChangeState()));
    on<ChangeAddressEvent>((event, emit) => {
          selectedAddress = event.selectedAddress,
          //emit(ChangeState()),
          add(AddDelievryCharge(selectedAddress!)),
        });
    on<GetAddressEvent>((event, emit) async {
      await repo.getAddress(
        bagModel.userId,
        addressCallback: (addresss) {
          addressItem = addresss;
          if (addressItem.isNotEmpty) {
            selectedAddress = addressItem.first;
          }
          add((GetDeliveryAreaEvent()));
        },
      );
    });
    on<AddDeliveryAddressEvent>((event, emit) async {
      emit(AddAddressLoadingState());
      Position userLocation = await Device().userPosition();
      emit(AddAddressState(userLocation));
    });
    on<GetPaymentMethodEvent>((event, emit) async {
      await repo.getPaymentMethod(paymentMethodCallBack: (items) {
        paymentMethodItems = items;
        if (paymentMethodItems.isNotEmpty) {
          selectedPaymentMethod = paymentMethodItems.first;
          add(ChangeStateEvent());
        }
      });
    });
    on<ChangePaymentMethodEvent>((event, emit) => {
          selectedPaymentMethod = event.selectedPaymentMethod,
          emit(ChangeState())
        });
    on<GetDeliveryAreaEvent>((event, emit) async {
      await repo.getDeliveryArea(delilveryAreaCallBack: (items) {
        deliveryAreaItems = items;
        if (selectedAddress != null) {
          add(AddDelievryCharge(selectedAddress!));
        }

        add(ChangeStateEvent());
      });
    });
    on<AddDelievryCharge>((event, emit) {
      bagModel.deliveryCharge = getDeliveryCharge(event.selectedAddress);
      add(ChangeStateEvent());
    });
    on<DeleteBagEvent>((event, emit) async {
      await repo.deleteBag(bagModel.id);
      AppStorage().userBag = null;
    });
    on<OnPlaceOrderEvent>((event, emit) async {
      if (selectedAddress == null) {
        emit(CheckoutErrorState("Please Add or Choose delivery address."));
      } else if (selectedPaymentMethod == null) {
        emit(CheckoutErrorState(
            "Please choose a method of payment before place order."));
      } else if (bagModel.deliveryCharge < 0) {
        emit(CheckoutErrorState(
            "Sorry, Delivery is not possible for us on your selected address."));
      } else {
        var placeorder = PlaceOrder(
            id: "",
            userId: bagModel.userId,
            userName: bagModel.userName,
            items: bagModel.items,
            deliveryCharge: bagModel.deliveryCharge,
            address: selectedAddress!,
            paymentMethod: selectedPaymentMethod!,
            placeAt: "",
            createdAt: "",
            updateAt: "",
            status: 1,
            itemsTotal: calculateItemTotal(),
            total: calTotal(),
            transactionId: '');

        if (selectedPaymentMethod?.type == "upi") {
          var transactionId =
              "TXN_${DateTime.now().millisecondsSinceEpoch.toString()}";

          try {
            final upiPaymentHandler = UpiPaymentHandler();
            bool success = await upiPaymentHandler.initiateTransaction(
              payeeVpa: selectedPaymentMethod?.key ?? "",
              payeeName: selectedPaymentMethod?.marchantName ?? "",
              transactionRefId: transactionId,
              transactionNote: "Farm Fresh Order.",
              amount: placeorder.total,
            );
            if (success) {
              placeorder.transactionId = transactionId;
              //await placeOrder(placeorder, emit);
            } else {
              emit(CheckoutErrorState("Your Transaction is canceled."));
            }
          } on PlatformException catch (e) {
            emit(CheckoutErrorState("Your Transaction is canceled-$e"));
          }
        } else {
          await placeOrder(placeorder, emit);
        }
      }
    });
  }
  Future<void> placeOrder(
    PlaceOrder placeorder,
    Emitter<CheckoutState> emit,
  ) async {
    await repo.placeOrder(placeorder, callback: () {
      AppStorage().userBag = null;
      add(DeleteBagEvent());
      emit(OrderPlacedSucessfully());
    });
  }

  double calculateItemTotal() {
    double amt = 0.0;
    for (CartItems item in bagModel.items) {
      amt = amt + (item.price * item.qty);
    }
    return amt;
  }

  double calTotal() {
    return calculateItemTotal() + bagModel.deliveryCharge;
  }

  int itemCount() {
    int count = 0;
    for (CartItems item in bagModel.items) {
      count = count + item.qty;
    }
    return count;
  }
}

bool checkInPolyGon(LatLng tap, List<Area> vertices) {
  int intersectCount = 0;
  for (int j = 0; j < vertices.length - 1; j++) {
    if (rayCastIntersect(tap, vertices[j], vertices[j + 1])) {
      intersectCount++;
    }
  }

  return ((intersectCount % 2) == 1); // odd = inside, even = outside;
}

bool rayCastIntersect(LatLng tap, Area vertA, Area vertB) {
  double aY = vertA.lat;
  double bY = vertB.lat;
  double aX = vertA.log;
  double bX = vertB.log;
  double pY = tap.latitude;
  double pX = tap.longitude;

  if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
    return false; // a and b can't both be above or below pt.y, and a or
    // b must be east of pt.x
  }

  double m = (aY - bY) / (aX - bX); // Rise over run
  double bee = (-aX) * m + aY; // y = mx + b
  double x = (pY - bee) / m; // algebra is neat!

  return x > pX;
}
