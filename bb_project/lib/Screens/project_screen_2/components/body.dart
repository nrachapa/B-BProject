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

  void showInfo(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Info saved')));
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
                            backgroundColor: const Color(0xffe56666),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(10.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            print('pressed and saved');
                            showInfo(context);
                          },
                          child: const Text('Save',
                              style: TextStyle(fontSize: 18)),
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
                MaterialPageRoute(builder: (context) => const LoginScreen()),
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
// DataTable call
class DataTableColumn extends StatefulWidget {
  final int tableCount;
  final int rowCount;

  const DataTableColumn(
      {Key? key, required this.tableCount, required this.rowCount})
      : super(key: key);

  @override
  _DataTableColumnState createState() => _DataTableColumnState();
}

class _DataTableColumnState extends State<DataTableColumn> {
  late List<bool> checked; // List to hold checkbox states

  @override
  void initState() {
    super.initState();
    checked = List.filled(widget.rowCount * widget.tableCount, false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 650,
      child: ListView.builder(
        itemCount: widget.tableCount,
        itemBuilder: (context, tableIndex) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 190,
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text('Task Name'),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text('Completed'),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                widget.rowCount,
                (int rowIndex) => DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                        'Task ${(tableIndex * widget.rowCount) + rowIndex + 1}')),
                    DataCell(Checkbox(
                      value: checked[(tableIndex * widget.rowCount) + rowIndex],
                      onChanged: (bool? value) {
                        setState(() {
                          checked[(tableIndex * widget.rowCount) + rowIndex] =
                              value!;
                        });
                      },
                    )),
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
