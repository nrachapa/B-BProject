import 'package:bb_project/Screens/admin_screen_4/admin_screen_4.dart';
import 'package:bb_project/Screens/home/components/user.dart';
import 'package:bb_project/Screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../../Message.dart';
import '../../hours/components/user_preference.dart';
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
        title: const Text('Ongoing Projects'),
        backgroundColor: const Color(0xffe56666),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProjectSearch());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
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
                  child: CircularProgressIndicator(),
                ),
              );
            default:
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Your other UI elements
                    const DataTableColumn(tableCount: 1, rowCount: 100),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: logoutButton(user, context),
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }

  Widget logoutButton(User user, BuildContext context) {
    // Your logout function and button implementation
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

class ProjectSearch extends SearchDelegate<String> {
  final projects = List<String>.generate(100, (index) => 'Project ${index + 1}');

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
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
            builder: (context) => AdminScreen4(),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = projects.where((project) {
      return project.toLowerCase().contains(query.toLowerCase());
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
                builder: (context) => AdminScreen4(),
              ),
            );
          },
        );
      },
    );
  }
}

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
              columnSpacing: 80,
              columns: const <DataColumn>[
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Project Name',
                      // style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                // DataColumn(
                //   label: Expanded(
                //     child: Text(
                //       'Status',
                //       // style: TextStyle(fontStyle: FontStyle.italic),
                //     ),
                //   ),
                // ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      '',
                      // style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                rowCount,
                (int rowIndex) => DataRow(
                  cells: <DataCell>[
                    DataCell(SizedBox(
                      width: 200,
                      child: Text(
                        'Project ${(tableIndex * rowCount) + rowIndex + 1}'),
                    )),
                    // const DataCell(Text("Working")),
                    DataCell(ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xffe56666), // background (button) color
                            foregroundColor:
                                Colors.white, // foreground (text) color
                            padding: const EdgeInsets.all(0.0),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminScreen4(),
                              ),
                            );
                          },
                          child: const Text('View', style: TextStyle(fontSize: 15),),
                        ),),
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
