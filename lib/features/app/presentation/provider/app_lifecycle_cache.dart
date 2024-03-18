import 'package:crop_image/crop_image.dart';


class LoginLifeCycleCache  {
  final Map<String, CropController> _cropControllers = {};

  CropController? getCropController(String imageLink) {
    if (_cropControllers.containsKey(imageLink)) {
      return _cropControllers[imageLink];
    }
    return null;
  }

  void addCropController(String imageLink, CropController controller) {
    _cropControllers[imageLink] = controller;
  }

  void removeCropController(String imageLink) {
    _cropControllers[imageLink]?.dispose();
    _cropControllers.remove(imageLink);
  }

  void dispose() {
    _cropControllers.forEach((key, value) {
      value.dispose();
    });
  }

}