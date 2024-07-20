class Logo {
  static const _LOGO_Path = 'assets/images/LOGO.png';
  static String get path => _LOGO_Path;
}

class BackgroundImage {
  static const _BG_PATH = [
    'assets/images/BG1.png',
    'assets/images/BG2.png',
  ];
  static String path(int pathIndex) {
    int numberOfImage = _BG_PATH.length;

    if (pathIndex >= numberOfImage) {
      return throw Exception('Index is beyond number of background!');
    } else {
      return _BG_PATH[pathIndex];
    }
  }
}
