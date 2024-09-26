import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logoutAccount() async {
    await _auth.signOut();
    update();
  }
}
