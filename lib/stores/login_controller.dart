import 'package:firebase_chat/config/import.dart';

class LoginController extends GetxController {
  bool loading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  login_() async {
    try {
      if (loading) return;
      loading = true;

      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.text, password: password.text);

      firestore.collection('users').doc(userCredential.user!.uid).set(
          {"uid": userCredential.user!.uid, "email": email.text},
          SetOptions(merge: true));
    } catch (err) {
      Get.rawSnackbar(message: err.toString());
    } finally {
      loading = false;
      update();
    }
  }

  createAccount() async {
    try {
      if (loading) return;
      loading = true;

      if (password.text != confirmPassword.text) {
        Get.rawSnackbar(
            message: "Parolni tasdiqlashda xato",
            snackPosition: SnackPosition.TOP);
        return;
      }

      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: email.text, password: password.text);

      firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({"uid": userCredential.user!.uid, "email": email.text});
    } catch (err) {
      Get.rawSnackbar(message: err.toString());
    } finally {
      loading = false;
      update();
    }
  }

  logOut() async {
    return await firebaseAuth.signOut();
  }
}
