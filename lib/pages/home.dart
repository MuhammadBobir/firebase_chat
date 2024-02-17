import 'package:firebase_chat/config/import.dart';
import 'package:firebase_chat/pages/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.put(LoginController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Bosh sahifa"), actions: [
          IconButton(
              onPressed: () {
                loginController.logOut();
              },
              icon: const Icon(Icons.logout))
        ]),
        body: userList());
  }

  Widget userList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children:
                snapshot.data!.docs.map((doc) => userBuildItem(doc)).toList(),
          );
        });
  }

  Widget userBuildItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Get.to(() => ChatPage(
                reciverUserEmail: data['email'],
                reciverUserID: data['uid'],
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
