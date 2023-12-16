import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtils {
  /// Pick Image from gallery and returns the cropped image
  static Future<String?> pickFromGallery(
      {CropAspectRatioPreset? ratio, CropAspectRatio? customRatio, bool isCircleCrop = false}) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String? croppedImage =
          await _cropImage(pickedFile.path, ratio: ratio, customRatio: customRatio, isCircleCrop: isCircleCrop);
      return croppedImage;
    } else {
      return null;
    }
  }

  /// Pick Image from camera and returns the cropped image
  static Future<String?> pickFromCamera(
      {CropAspectRatioPreset? ratio, CropAspectRatio? customRatio, bool isCircleCrop = false}) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String? croppedImage =
          await _cropImage(pickedFile.path, ratio: ratio, customRatio: customRatio, isCircleCrop: isCircleCrop);
      return croppedImage;
    } else {
      return null;
    }
  }

  ///Image cropper via uCrop
  static Future<String?> _cropImage(String filePath,
      {CropAspectRatioPreset? ratio, CropAspectRatio? customRatio, bool isCircleCrop = false}) async {
    CroppedFile? croppedImage;
    if (ratio == null) {
      croppedImage = await ImageCropper().cropImage(
          sourcePath: filePath,
          uiSettings: [
            AndroidUiSettings(initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: true),
            IOSUiSettings(
              aspectRatioLockEnabled: true,
              aspectRatioPickerButtonHidden: true,
              aspectRatioLockDimensionSwapEnabled: false,
              rotateButtonsHidden: false,
              rotateClockwiseButtonHidden: false,
              resetAspectRatioEnabled: false,
              resetButtonHidden: true,
            )
          ],
          aspectRatio: customRatio);
    } else {
      if (isCircleCrop) {
        croppedImage = await ImageCropper().cropImage(
            sourcePath: filePath,
            uiSettings: [
              AndroidUiSettings(initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
              IOSUiSettings(
                aspectRatioLockEnabled: true,
                aspectRatioPickerButtonHidden: true,
                aspectRatioLockDimensionSwapEnabled: false,
                rotateButtonsHidden: false,
                rotateClockwiseButtonHidden: false,
                resetAspectRatioEnabled: false,
                resetButtonHidden: true,
              )
            ],
            aspectRatioPresets: [
              ratio,
            ],
            cropStyle: CropStyle.circle);
      } else {
        croppedImage = await ImageCropper().cropImage(sourcePath: filePath, uiSettings: [
          AndroidUiSettings(initAspectRatio: CropAspectRatioPreset.original, lockAspectRatio: false),
          IOSUiSettings(aspectRatioLockEnabled: true, rectWidth: 1080, rectHeight: 1080, rectX: 1080, rectY: 1080)
        ], aspectRatioPresets: [
          ratio,
        ]);
      }
    }
    if (croppedImage != null) {
      return croppedImage.path;
    } else {
      return null;
    }
  }
}
