import 'package:farmfresh/module/delivery_addess_module/add_address_module/add_address_repository.dart';
import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/validateion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:place_picker/entities/location_result.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final LocationResult location;
  final AddAddressRepository repo;
  String name = "";
  String house = "";
  String address = "";
  String mobileNo = "";
  String type = 'Home';
  AddAddressBloc(this.location, this.repo) : super(AddAddressInitial()) {
    UserModel userDetail = AppStorage().userDetail!;
    name = userDetail.name;
    address = location.formattedAddress ?? "";
    mobileNo = userDetail.phoneNumber;
    on<AddAddressEvent>((event, emit) {});

    on<ChangeTypeEvent>((event, emit) {
      type = event.value;
      emit(ChangeTypeState());
    });

    on<MoveBackEvent>((event, emit) => emit(MoveBackState()));

    on<SaveAddressEvent>((event, emit) async {
      if (name.isEmpty) {
        emit(AddAddressErrorState("Please enter name."));
      } else if (house.isEmpty) {
        emit(AddAddressErrorState("Please enter Flat, House no, Apartment."));
      } else if (address.isEmpty) {
        emit(AddAddressErrorState(
            "Please enter Area, Colony, Street, Sector, Village"));
      } else if (mobileNo.isEmpty) {
        emit(AddAddressErrorState("Please enter contact number."));
      } else if (Validation.validatePhoneNumber(mobileNo)) {
        emit(AddAddressErrorState("Please enter valid contact number."));
      } else {
        emit(AddAddressLoading());
        Address addressValue = Address(
            id: "",
            name: name,
            house: house,
            address: address,
            pin: location.postalCode ?? "",
            city: location.city?.name ?? "",
            state: location.locality ?? "",
            latitude: location.latLng?.latitude ?? 0.0,
            logitude: location.latLng?.longitude ?? 0.0,
            contactNo: mobileNo,
            userId: userDetail.uid,
            type: type);

        await repo.addAddress(addressValue, callback: () {
          add(MoveBackEvent());
        });
      }
    });
  }
}
