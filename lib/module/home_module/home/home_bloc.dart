import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  XFile? image;
  XFile? compresImage;
  String imageSize = "0kb";
  String compressSize = "0kb";
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<SelectImageEvent>((event, emit) async {
      image = event.file;
      imageSize = await getFileSize(event.file!.path, 1);
      emit(SelectImageState());
    });

    on<CompressImageEvent>((event, emit) async {
      if (image != null) {
        try {
          String directory =
              "${(await getExternalStorageDirectory())?.path}/${DateTime.now().millisecondsSinceEpoch.toString()}_${image?.name}";
          await FlutterImageCompress.compressAndGetFile(
            image!.path,
            directory,
            quality: 88,
            rotate: 180,
          ).then((value) => {
                if (value == null)
                  {compresImage = image}
                else
                  {compresImage = value}
              });
        } catch (e) {
          //print(e.toString());
        }

        compressSize = await getFileSize(compresImage!.path, 1);
        emit(SelectImageState());
      }
    });
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
