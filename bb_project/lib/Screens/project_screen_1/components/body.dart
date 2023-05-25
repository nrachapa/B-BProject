import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:bb_project/Screens/project_screen_2/project_screen_2.dart';
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
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        appBar: AppBar(
            title: const Text('Your Projects'),
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Hello, ${snapshot.data!.username}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ])),
                        // Datatable call
                        const DataTableColumn(tableCount: 1, rowCount: 100),
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

  const DataTableColumn({
    Key? key,
    required this.tableCount,
    required this.rowCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650, // Adjust this to fit your needs
      child: ListView.builder(
        itemCount: tableCount,
        itemBuilder: (context, tableIndex) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List>(
              future: fetchData(), // Call the fetchData method asynchronously
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while waiting for the data
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Show an error message if an error occurs
                } else {
                  final dataList = snapshot.data;
                  return DataTable(
                    columnSpacing: 80,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Name',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          '',
                          // style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                    rows: dataList!
                        .map(
                          (data) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(data.get<String>('Name'))),
                              const DataCell(Text("Working")),
                              DataCell(
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffe56666),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: () => const ProjectScreen2(),
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Future<List<ParseObject>> fetchData() async {
    final QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('Projects'));

    final response = await query.query();
    if (response.success && response.results != null) {
      final resultList = response.results as List<ParseObject>;
      return resultList;
    } else {
      return []; // Ensure the error is non-null
    }
  }
}
