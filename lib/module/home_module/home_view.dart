import 'package:farmfresh/module/home_module/home/home_bloc.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/ui/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatelessWidget {
  final picker = ImagePicker();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            var bloc = context.read<HomeBloc>();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 1.sw,
                ),
                Text(
                  "User Name : ${AppStorage().userDetail!.name}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Mobile no : ${AppStorage().userDetail!.phoneNumber}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Email no : ${AppStorage().userDetail!.email}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Path : ${bloc.image?.path}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                bloc.image != null
                    ? Text(
                        //"${bloc.image?.readAsBytes()}",
                        "Size : ${bloc.imageSize}",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : const SizedBox(),
                CustomButton(
                    text: "Select Image",
                    onPressed: () async => {
                          await picker
                              .pickImage(source: ImageSource.gallery)
                              .then((value) =>
                                  {bloc.add(SelectImageEvent(value))})
                        }),
                CustomButton(
                    text: "Compress",
                    onPressed: () => {bloc.add(CompressImageEvent())}),
                Text(
                  "Compress Path : ${bloc.compresImage?.path}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                bloc.compresImage != null
                    ? Text(
                        "Compress Size : ${bloc.compressSize}",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
