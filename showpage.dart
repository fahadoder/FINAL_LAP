import 'package:flutter/material.dart';
import 'json1/sqldb.dart';
import 'json1/users.dart';
import 'loginpage.dart';

class ShowPage extends StatefulWidget {
  final MyCode usr;

  const ShowPage({super.key, required this.usr});

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  final userController = TextEditingController();
  List<MyCode> displayedUsers = [];

  @override
  void initState() {
    super.initState();
    _loadAllUsers();
  }

  void _loadAllUsers() async {
    List<MyCode> users = await MyCodeOperation.instance.getAllUsers();
    setState(() {
      displayedUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        title: const Text('Final Page'),
      ),
      body: Container(
        color: const Color.fromARGB(100, 100, 80, 5),
        child: Column(
          children: [
            Container(
              color: const Color.fromRGBO(255, 255, 255, 10),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${widget.usr.id}',
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.usr.Number,
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.usr.Code,
                    style: TextStyle(
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue[900]!,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              color: const Color.fromARGB(100, 100, 19, 5),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: ListView.builder(
                itemCount: displayedUsers.length,
                itemBuilder: (context, index) {
                  MyCode s = displayedUsers[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(14.0),
                            decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('id: ${s.id}'),
                                const Spacer(),
                                Text('Number: ${s.Number}'),
                                const Spacer(),
                                Text('Code: ${s.Code}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}