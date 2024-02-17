import 'package:firebase_chat/config/import.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool login = true;
  void toggle() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return LoginPage(onTap: toggle);
    } else {
      return RegisterPage(onTap: toggle);
    }
  }
}
