import 'package:bb_project/Screens/home/components/background.dart';
import 'package:bb_project/Screens/home/components/button_widget.dart';
import 'package:bb_project/Screens/home/components/profile_widget.dart';
import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/home/components/user_preference.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:bb_project/Screens/hours/hours_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../Message.dart';
import 'appbar_widget.dart';

class Body extends StatelessWidget {
  ParseUser? currentUser;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.myUser;
    // final textController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // SizedBox(height: 40, width: 80),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Sun',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      // const Text(
                      //   'Sun',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w800,
                      //     fontFamily: 'Roboto',
                      //     letterSpacing: 0.5,
                      //     fontSize: 20,
                      //   ),
                      // ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Mon',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Tues',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Wed',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Thurs',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Fri',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 70,
                        child: Text(
                          'Sat',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Roboto',
                            letterSpacing: 0.5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Hours',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: TextEditingController(),
                          decoration: const InputDecoration(
                            hintText: 'Mins',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffe56666),
                                width: 1),
                            ),
                          ),
                        ),
                      ),
                    ])),
            //buildName(user),
            Center(child:projectButton(user, context)),
            const SizedBox(height: 24),
            // const SizedBox(width: 24),
            // buildName(user),
            // const SizedBox(width: 24),
            // buildName(user),
            FutureBuilder<ParseUser?>(
                future: getUser(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator()),
                      );
                    default:
                      return Center(child: logoutButton(user, context));
                  }
                })
          ],
        )
        // body: FutureBuilder<ParseUser?>(
        //     future: getUser(),
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.none:
        //         case ConnectionState.waiting:
        //           return Center(
        //             child: Container(
        //                 width: 100,
        //                 height: 100,
        //                 child: CircularProgressIndicator()),
        //           );
        //         default:
        //           return Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.stretch,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Center(
        //                     child: Text('Hello, ${snapshot.data!.username}')),
        //                 SizedBox(
        //                   height: 16,
        //                 ),
        //                 Center(
        //                     child: Text('Email, ${snapshot.data!.emailAddress}')),
        //                 SizedBox(
        //                   height: 16,
        //                 ),
        //                 Container(
        //                   height: 50,
        //                   child: ElevatedButton(
        //                     child: const Text('Logout'),
        //                     onPressed: () => doUserLogout(),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //       }
        //     }
        );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(user.name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          Text(user.email, style: const TextStyle(fontSize: 24))
        ],
      );

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
