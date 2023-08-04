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
            title: const Text('Employees'),
            backgroundColor: const Color(0xffe56666),
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: EmployeeSearch());
                  },
                  icon: const Icon(Icons.search))
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
  late List<bool> checked;

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
              columnSpacing: 300,
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text('Employee Name'),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                widget.rowCount,
                (int rowIndex) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      GestureDetector(
                        child: Text('Employee ${(tableIndex * widget.rowCount) + rowIndex + 1}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeDetailScreen(
                                employee: 'Employee ${(tableIndex * widget.rowCount) + rowIndex + 1}',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

class EmployeeSearch extends SearchDelegate<String> {
  final employees = List<String>.generate(100, (index) => 'Employee ${index + 1}');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListTile(
      title: Text(query),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetailScreen(employee: query),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = employees.where((employee) {
      return employee.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeeDetailScreen(
                  employee: suggestions[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class EmployeeDetailScreen extends StatelessWidget {
  final String employee;

  const EmployeeDetailScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee),
        backgroundColor: const Color(0xffe56666),
      ),
      body: Center(
        child: Text('Details for $employee'),
      ),
    );
  }
}
