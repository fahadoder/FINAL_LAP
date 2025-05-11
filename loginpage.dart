import 'package:final_lap/showpage.dart';
import 'package:final_lap/showpage.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'json1/sqldb.dart';
import 'json1/users.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NumberController = TextEditingController();
  final CodeController = TextEditingController();

  Future<void> login() async {
    var user = await MyCodeOperation.instance.loginUser(
      MyCode(Number: NumberController.text, Code: CodeController.text),
    );

    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowPage(usr: user)),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Invalid username or password."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Login Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 109, 5),
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextFormField(
                controller: NumberController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Number'),
              ),
            ),
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextFormField(
                controller: CodeController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Code'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      await login();
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      "Home Page",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}