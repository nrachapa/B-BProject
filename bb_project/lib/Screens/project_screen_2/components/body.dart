import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../Message.dart';
import '../../hours/components/user_preference.dart';
import '../../hours/hours_screen.dart';
import 'package:bb_project/Screens/project_screen_2/components/button_widget.dart';

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
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        appBar: AppBar(
            title: const Text('Tasks'),
            backgroundColor: const Color(0xffe56666),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ]),
        body: FutureBuilder<ParseUser?>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Datatable call
                        const DataTableColumn(tableCount: 1, rowCount: 100),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xffe56666), // background (button) color
                            foregroundColor:
                                Colors.white, // foreground (text) color
                            padding: const EdgeInsets.all(10.0),
                            shape: const StadiumBorder(),
                          ),
                          // prints out in terminal
                          onPressed: () => print('pressed and saved'),
                          child: const Text('Save', style: TextStyle(fontSize: 18),),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
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

// DataTable call
class DataTableColumn extends StatelessWidget {
  final int tableCount;
  final int rowCount;

  const DataTableColumn(
      {super.key, required this.tableCount, required this.rowCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 100,
      height: 650, // Adjust this to fit your needs
      child: ListView.builder(
        itemCount: tableCount,
        itemBuilder: (context, tableIndex) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing:190,
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Task Name',
                      //style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Completed',
                      //style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                rowCount,
                (int rowIndex) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                        Text('Task ${(tableIndex * rowCount) + rowIndex + 1}')),
                    const DataCell(ElevatedButton(
                        onPressed: null,
                        child: Icon(Icons.check_box_outline_blank_rounded))),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
