class ImagePath {
  final _BG_PATH = {
    'LOGO': ImageController.addFile('LOGO.png'),
    'BG1': ImageController.addFile('BG1.png'),
    'BG2': ImageController.addFile('BG2.png'),
    'BG3': ImageController.addFile('BG3.png'),
    'BG4': ImageController.addFile('BG4.png'),
  };

  Map get images => _BG_PATH;
}

class ImageController {
  static String addFile(file) {
    const basePath = 'assets/images/';
    return basePath + file;
  }

  static String get(String pathName) {
    Map images = ImagePath().images;
    if (images[pathName] == null) {
      return throw Exception('Path name does not found!');
    } else {
      return images[pathName]!;
    }
  }
}
