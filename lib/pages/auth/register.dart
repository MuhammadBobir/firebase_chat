import 'package:firebase_chat/config/import.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat, size: 80, color: Colors.grey.shade800),
                    const SizedBox(height: 16),
                    const Text("Ro'yhatdam o'tish",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Input(
                        controller: controller.email,
                        hintText: "Login",
                        obscureText: false),
                    const SizedBox(height: 16),
                    Input(
                        controller: controller.password,
                        hintText: "Parol",
                        obscureText: true),
                    const SizedBox(height: 16),
                    Input(
                        controller: controller.confirmPassword,
                        hintText: "Parolni takrorlash",
                        obscureText: true),
                    const SizedBox(height: 16),
                    Button(
                        onTap: () {
                          controller.createAccount();
                        },
                        text: "Ro'yhatdan o'tish"),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Akkountingiz bormi?"),
                        const SizedBox(width: 5),
                        InkWell(
                            onTap: widget.onTap,
                            child: const Text("Kirish",
                                style: TextStyle(fontWeight: FontWeight.w700))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
