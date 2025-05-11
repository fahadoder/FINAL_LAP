import 'package:flutter/material.dart';
import 'homepage.dart';
import 'json1/sqldb.dart';
import 'json1/users.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreateState();
}

class _CreateState extends State<CreatePage> {
  final NumberController = TextEditingController();
  final CodeController = TextEditingController();

  Future<void> insertUser() async {
    if (NumberController.text.isNotEmpty) {
      var response = await MyCodeOperation.instance.createUser(
        MyCode(Number: NumberController.text, Code: CodeController.text),
      );
      if (response > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(title: Text("Empty or Missing Fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Create Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 109, 5),
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: NumberController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Username'),
              ),
            ),
            Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: TextField(
                controller: CodeController,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(hintText: 'Code'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () async {
                      await insertUser();
                    },
                    child: const Text("Insert User", style: TextStyle(fontSize: 22)),
                  ),
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel", style: TextStyle(fontSize: 22)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}