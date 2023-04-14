import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:path_provider/path_provider.dart';

class CustomImagePicker {
  static Future<XFile?> pickImagefromBoth({required ImageSource source}) async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source, imageQuality: 5);
    return file;
  }

  static Future<File?> pickVideoFromBoth({required ImageSource source}) async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickVideo(
      source: source,
    );
   Directory? _dir=await getExternalStorageDirectory();
    // Directory directory = Directory('/storage/emulated/0/Android/data/com.example.chat_app/files');
    if (_dir!=null && !(await _dir.exists())) {
      await _dir.create(recursive: true);
    }
    final path = "/storage/emulated/0/Android/data/com.example.chat_app/files/demo.mp4";

    // if(Directory())

    if (file != null) {
      final LightCompressor _lightCompressor = LightCompressor();
      final dynamic response = await _lightCompressor.compressVideo(
        path: file.path,
        destinationPath: path,
        videoQuality: VideoQuality.very_low,
        isMinBitrateCheckEnabled: false,
      );

      log('video response ${(response as OnSuccess).destinationPath}');
      return File((response as OnSuccess).destinationPath);
    }

    // if (file != null) {
    //   log('file88888 $file');
    //   MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    //     file.path,
    //     quality: VideoQuality.DefaultQuality,
    //     deleteOrigin: false,
    //     includeAudio: true,
    //   );
    //   log('jjjj ${mediaInfo}');
    //   if (mediaInfo?.path != null) {
    //     // log('hdhdh88 ${mediaInfo!.path!}');

    //     log('jjjj1');

    //     return File(mediaInfo!.path!);
    //   }
    // }
    // return File(file!.path);
  }
}
