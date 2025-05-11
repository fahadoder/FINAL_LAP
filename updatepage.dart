import 'package:flutter/material.dart';
import 'json1/sqldb.dart';
import 'json1/users.dart';
import 'loginpage.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final NumberController = TextEditingController();
  final CodeController = TextEditingController();

  @override
  void dispose() {
    NumberController.dispose();
    CodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Update Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 109, 5),
        child: Column(
          children: <Widget>[
            _buildTextField(NumberController, 'Number'),
            _buildTextField(CodeController, 'Code'),
            _buildButtonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 22),
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }

  Widget _buildButtonRow() {
    return Container(
      margin: const EdgeInsets.all(15),
      color: const Color.fromARGB(100, 100, 19, 5),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(10),
            color: Colors.purple,
            textColor: Colors.white,
            onPressed: () async {
              await _updateUser();
            },
            child: const Text(
              "Update",
              style: TextStyle(fontSize: 22),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(10),
            color: Colors.green,
            textColor: Colors.white,
            onPressed: () {
              _checkAndDeleteUser();
            },
            child: const Text(
              "Delete",
              style: TextStyle(fontSize: 22),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(10),
            color: Colors.limeAccent,
            textColor: Colors.blue,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Back",
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateUser() async {
    final number = NumberController.text;
    final code = CodeController.text;

    if (number.isNotEmpty && code.isNotEmpty) {

      var user = await MyCodeOperation.instance.searchUser(number);
      if (user.isNotEmpty) {
        var updatedUser = MyCode(Number: number, Code: code, id: user.first.id);
        await MyCodeOperation.instance.updateUser(updatedUser);
        _showMessage('User updated successfully!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        _showMessage('User not found.');
      }
    } else {
      _showMessage('Please fill in all fields.');
    }
  }

  void _checkAndDeleteUser() async {
    final number = NumberController.text;
    if (number.isNotEmpty) {
      bool userExists = await MyCodeOperation.instance.checkUserExists(number);
      if (userExists) {
        _showDeleteConfirmation();
      } else {
        _showMessage('User not found.');
      }
    } else {
      _showMessage('Please enter a number.');
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () async {
                await MyCodeOperation.instance.deleteUserByNumber(NumberController.text);
                _showMessage('User deleted successfully!');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}