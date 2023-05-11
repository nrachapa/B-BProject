import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:bb_project/components/scrollable_widget.dart';
import 'package:bb_project/data/user.dart';
import 'package:bb_project/model/user.dart';
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
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

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
                        // Datatable call
                        SortablePage(),
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

// DataTable call
class SortablePage extends StatefulWidget {
  @override
  _SortablePageState createState() => _SortablePageState();
}

class _SortablePageState extends State<SortablePage> {
  late List<SampleUser> sampleusers;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.sampleusers = List.of(allSampleUsers);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ScrollableWidget(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['First Name', 'Last Name', 'Age'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(sampleusers),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<SampleUser> sampleusers) =>
      sampleusers.map((SampleUser sampleusers) {
        final cells = [
          sampleusers.firstName,
          sampleusers.lastName,
          sampleusers.age
        ];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((data) => DataCell(Text('$data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      sampleusers.sort((user1, user2) =>
          compareString(ascending, user1.firstName, user2.firstName));
    } else if (columnIndex == 1) {
      sampleusers.sort((user1, user2) =>
          compareString(ascending, user1.lastName, user2.lastName));
    } else if (columnIndex == 2) {
      sampleusers.sort((user1, user2) =>
          compareString(ascending, '${user1.age}', '${user2.age}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
