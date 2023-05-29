import 'dart:io';

import 'package:farmfresh/module/login_module/model/login_model.dart';
import 'package:farmfresh/module/profile_module/profile_repository.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:farmfresh/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  XFile? image;
  final ProfileRepository repo;
  ProfileBloc(this.repo) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<SelectImageEvent>(
        (event, emit) => {image = event.file, emit(SelectImageState())});
    on<AddProfileEvent>((event, emit) async {
      if (image == null) {
        emit(ProfileErrorState("Please upload your profile photo"));
      } else {
        String directory =
            "${(await getExternalStorageDirectory())?.path}/${DateTime.now().millisecondsSinceEpoch.toString()}_${image?.name}";

        image = await FlutterImageCompress.compressAndGetFile(
          image!.path,
          directory,
          quality: 88,
        );
      }

      if (event.name.isEmpty) {
        emit(ProfileErrorState("Please enter valid name"));
      } else if (!event.email.isValidEmail()) {
        emit(ProfileErrorState("Please enter valid email"));
      } else if (event.bio.isEmpty) {
        emit(ProfileErrorState("Please enter few world about you."));
      } else if (image == null) {
        emit(ProfileErrorState("Please upload your profile photo"));
      } else {
        try {
          emit(ProfileLoadingState());
          await repo.updateProfile(
              event.uid,
              event.name,
              event.email,
              event.bio,
              event.phone,
              File(image!.path), onComplete: (UserModel userModel) {
            AppStorage().userDetail = userModel;
            emit(MovetoHomeState());
          });
        } catch (err) {
          emit(ProfileErrorState(err.toString()));
        }
      }
    });
  }
}
