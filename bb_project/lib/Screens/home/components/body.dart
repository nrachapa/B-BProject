import 'package:bb_project/Screens/home/components/background.dart';
import 'package:bb_project/Screens/home/components/profile_widget.dart';
import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/home/components/user_preference.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
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
    // void doUserLogout() async {
    //   var response = await currentUser!.logout();
    //   if (response.success) {
    //     Message.showSuccess(
    //         context: context,
    //         message: 'User was successfully logout!',
    //         onPressed: () {
    //           Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(builder: (context) => LoginScreen()),
    //                 (Route<dynamic> route) => false,
    //           );
    //         });
    //   } else {
    //     Message.showError(context: context, message: response.error!.message);
    //   }
    // }

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
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
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
      ),
      Text(
        user.employeeID,
          style: const TextStyle(fontSize: 24)
      )
    ],
  );
}