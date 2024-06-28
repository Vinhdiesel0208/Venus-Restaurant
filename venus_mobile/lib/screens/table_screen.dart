import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/restaurant_table.dart';
import '../apis/table_api.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late Future<List<RestaurantTable>> futureTables;
  int? selectedTableId;
  String filterStatus = 'All';
  String searchQuery = '';
  int? filterSeats;

  @override
  void initState() {
    super.initState();
    futureTables = TableApi().fetchTables();
  }

  void _showCheckInConfirmation(int tableId) async {
    bool? confirmCheckIn = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Check-In"),
          content: Text("Do you want to check in table $tableId?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmCheckIn == true) {
      try {
        await TableApi().checkInTable(tableId);
        setState(() {
          futureTables = TableApi().fetchTables();
        });
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Failed to check in table: $error',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  void _showCheckInRequiredMessage() {
    Fluttertoast.showToast(
      msg: 'Please check in the table first.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _showTableInUseMessage() {
    Fluttertoast.showToast(
      msg: 'This table is currently in use.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _handleCheckIn(int tableId, bool status) {
    if (status) {
      _showCheckInConfirmation(tableId);
    } else {
      _showTableInUseMessage();
    }
  }

  void _checkOutTable(int tableId) async {
    try {
      await TableApi().checkOutTable(tableId);
      setState(() {
        futureTables = TableApi().fetchTables();
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'Failed to check out table: $error',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  void _navigateToMenu(BuildContext context, int tableId, bool status) {
    if (!status) {
      context.go('/ingredients/$tableId');
    } else {
      _showCheckInRequiredMessage();
    }
  }

  void _navigateToCart(BuildContext context, int tableId, bool status) {
    if (!status) {
      context.go('/cart/$tableId');
    } else {
      _showCheckInRequiredMessage();
    }
  }

  List<RestaurantTable> _filterTables(List<RestaurantTable> tables) {
    List<RestaurantTable> filteredTables = tables;

    if (filterStatus != 'All') {
      filteredTables = filteredTables.where((table) {
        return filterStatus == 'Serving' ? !table.status : table.status;
      }).toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredTables = filteredTables.where((table) {
        return table.tableNumber
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (filterSeats != null && filterSeats != -1) {
      filteredTables = filteredTables.where((table) {
        return filterSeats == 10
            ? table.seatCount > 10
            : table.seatCount == filterSeats;
      }).toList();
    }

    return filteredTables;
  }

  void _onTabSelected(String status) {
    setState(() {
      filterStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tables'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  futureTables = TableApi().fetchTables();
                });
              },
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.blue,
            onTap: (index) {
              switch (index) {
                case 0:
                  _onTabSelected('All');
                  break;
                case 1:
                  _onTabSelected('Serving');
                  break;
                case 2:
                  _onTabSelected('Empty');
                  break;
              }
            },
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Serving'),
              Tab(text: 'Empty'),
            ],
          ),
        ),
        drawer: _buildDrawer(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search Table',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<int>(
                    hint: Text('Seats'),
                    value: filterSeats,
                    items: [
                      DropdownMenuItem(value: -1, child: Text('All Seats')),
                      DropdownMenuItem(value: 2, child: Text('2 Seats')),
                      DropdownMenuItem(value: 4, child: Text('4 Seats')),
                      DropdownMenuItem(value: 6, child: Text('6 Seats')),
                      DropdownMenuItem(value: 8, child: Text('8 Seats')),
                      DropdownMenuItem(value: 10, child: Text('>10 Seats')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        filterSeats = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<RestaurantTable>>(
                future: futureTables,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No tables found'));
                  } else {
                    List<RestaurantTable> filteredTables =
                        _filterTables(snapshot.data!);
                    return GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 5,
                        childAspectRatio: 2 / 2,
                      ),
                      itemCount: filteredTables.length,
                      itemBuilder: (context, index) {
                        var table = filteredTables[index];
                        bool isSelected = selectedTableId == table.id;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTableId = isSelected ? null : table.id;
                            });
                          },
                          child: Card(
                            color: table.status
                                ? Colors.white
                                : Color.fromARGB(255, 249, 147, 140),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/imgs/dining_tab.png',
                                    width: 90,
                                    height: 73,
                                  ),
                                  SizedBox(height: 1),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${table.tableNumber}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${table.seatCount} seats',
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                  AnimatedOpacity(
                                    opacity: isSelected ? 1.0 : 0.0,
                                    duration: Duration(milliseconds: 200),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: isSelected
                                              ? () {
                                                  _handleCheckIn(
                                                      table.id, table.status);
                                                }
                                              : null,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.menu_book),
                                          onPressed: isSelected
                                              ? () => _navigateToMenu(context,
                                                  table.id, table.status)
                                              : null,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.payment),
                                          onPressed: isSelected
                                              ? () => _navigateToCart(context,
                                                  table.id, table.status)
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Order Status'),
            onTap: () {
              Navigator.pop(context);
              context.push('/staff-order-status');
            },
          ),
          ListTile(
            leading: Icon(Icons.table_restaurant),
            title: Text('Tables'),
            onTap: () {
              Navigator.pop(context);
              context.push('/tables');
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.push('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              context.push('/contact');
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Blog'),
            onTap: () {
              Navigator.pop(context);
              context.push('/blog');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.pop(context);
              context.go('/signin');
            },
          ),
        ],
      ),
    );
  }
}
