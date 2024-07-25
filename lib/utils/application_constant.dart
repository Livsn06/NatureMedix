import 'package:naturemedix/utils/image_paths.dart';

class AppName {
  final String _name = 'NATUREMEDIX';
}

class Logo {
  final String _logo = ImageController.get('LOGO');
}

class BackgroundImage {
  String get BG1 => ImageController.get('BG1');
  String get BG2 => ImageController.get('BG2');
  String get BG3 => ImageController.get('BG3');
  String get BG4 => ImageController.get('BG4');
}

class Application {
  static final name = AppName()._name;
  static final logo = Logo()._logo;
  static final image = BackgroundImage();
}
