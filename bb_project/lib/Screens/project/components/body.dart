import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../Message.dart';
import '../../hours/components/user_preference.dart';
import '../../hours/hours_screen.dart';
import 'button_widget.dart';

class Body extends StatelessWidget {
  ParseUser? currentUser;
  User user = UserPreferences.myUser;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: const Color(0xffe56666),
        ),
        body: FutureBuilder<ParseUser?>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Hello, ${snapshot.data!.username}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ])),
                        Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Email: ${snapshot.data!.emailAddress}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ])),
                        Center(
                            child: Column(children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(0),
                            child: Table(
                              defaultColumnWidth: FixedColumnWidth(100.0),
                              border: TableBorder.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 2),
                              children: [
                                TableRow(children: [
                                  Column(children: const [
                                    Text('NAME',
                                        style: TextStyle(fontSize: 20.0))
                                  ]),
                                  Column(children: const [
                                    Text('START',
                                        style: TextStyle(fontSize: 20.0))
                                  ]),
                                  Column(children: const [
                                    Text('STATUS',
                                        style: TextStyle(fontSize: 20.0))
                                  ]),
                                  Column(children: const [
                                    Text('STATUS',
                                        style: TextStyle(fontSize: 20.0))
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [Text('Javatpoint')]),
                                  Column(children: [Text('Flutter')]),
                                  Column(children: [Text('5*')]),
                                  Column(children: [Text('5*')]),
                                ]),
                                TableRow(children: [
                                  Column(children: [Text('Javatpoint')]),
                                  Column(children: [Text('MySQL')]),
                                  Column(children: [Text('5*')]),
                                  Column(children: [Text('5*')]),
                                ]),
                                TableRow(children: [
                                  Column(children: [Text('Javatpoint')]),
                                  Column(children: [Text('ReactJS')]),
                                  Column(children: [Text('5*')]),
                                  Column(children: [Text('5*')]),
                                ]),
                                TableRow(children: [
                                  Column(children: [Text('Javatpoint')]),
                                  Column(children: [Text('ReactJS')]),
                                  Column(children: [Text('5*')]),
                                  Column(children: [Text('5*')]),
                                ]),
                              ],
                            ),
                          ),
                        ])),
                        // Task table
                        Container(
                          padding: const EdgeInsets.all(0),
                          // height: 24,
                          // width: 24,
                          child: projectButton(user, context),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          // height: 24,
                          // width: 24,
                          child: logoutButton(user, context),
                        ),
                      ],
                    ),
                  );
              }
            }));
  }

  Widget projectButton(User user, BuildContext context) {
    return ButtonWidget(
        text: "Submit Hours",
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const SubmitHoursScreen();
              },
            ),
          );
        });
  }

  Widget logoutButton(User user, BuildContext context) {
    void doUserLogout() async {
      var response = await currentUser!.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'User was successfully logout!',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
              );
            });
      } else {
        Message.showError(context: context, message: response.error!.message);
      }
    }

    return ButtonWidget(text: "Logout", onClicked: () => doUserLogout());
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        // 1: FlexColumnWidth(),
        //2: FixedColumnWidth(40),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              //color: Colors.green,
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,

                //color: Colors.red,
              ),
            ),
            Container(
              height: 64,
              //color: Colors.blue,
            ),
          ],
        ),
        TableRow(
          decoration: const BoxDecoration(
              //color: Colors.grey,
              ),
          children: <Widget>[
            Container(
              height: 64,
              width: 128,
              //color: Colors.purple,
            ),
            Container(
              height: 32,
              //color: Colors.yellow,
            ),
            Center(
              child: Container(
                height: 32,
                width: 32,
                //color: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
