import 'package:firebase_chat/config/import.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return SafeArea(
            child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: controller.loading
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat, size: 80, color: Colors.grey.shade800),
                        const SizedBox(height: 16),
                        const Text(
                          "Hush kelibsiz! Tizimga kirish",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Input(
                            controller: controller.email,
                            hintText: "Login",
                            obscureText: false),
                        const SizedBox(height: 16),
                        Input(
                            controller: controller.password,
                            hintText: "Password",
                            obscureText: true),
                        const SizedBox(height: 16),
                        Button(
                            onTap: () {
                              controller.login_();
                            },
                            text: "Login"),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Akkountingiz yo'qmi?"),
                            const SizedBox(width: 5),
                            InkWell(
                                onTap: widget.onTap,
                                child: const Text(
                                  "Ro'yhatdan o'tish",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )),
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ));
      },
    );
  }
}
