class AppDirectory {
  static const String _IMG = 'assets/images/';
  static const String _ICON = 'assets/icons/';
  static const String _GIF = 'assets/gifs/';
  static const String _PLANT = 'assets/herbal/plant/';
  static const String _REMEDY = 'assets/herbal/remedy/';

  static img(String file) {
    return _IMG + file;
  }

  static icon(String file) {
    return _ICON + file;
  }

  static gif(String file) {
    return _GIF + file;
  }

  static plant(String file) {
    return _PLANT + file;
  }

  static remedy(String file) {
    return _REMEDY + file;
  }
}
