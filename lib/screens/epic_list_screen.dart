import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/dao/Epic_dao.dart';
import 'package:sqflite_test/models/WorkItemData.dart';
import 'package:sqflite_test/models/Epic.dart';
import 'package:sqflite_test/utils/widget.dart';
import 'add_epic_screen.dart';

class EpicListScreen extends StatefulWidget {
  @override
  _EpicListScreenState createState() => _EpicListScreenState();
}

class _EpicListScreenState extends State<EpicListScreen>
    with SingleTickerProviderStateMixin {
  List<Epic> _epics = [];
  List<WorkItemData> _workItemData = [];
  Status? _selectedSortStatus;
  bool _isFilterExpanded = false;
  late AnimationController _animationController;
  EpicDao _epicDao = EpicDao();

  @override
  void initState() {
    super.initState();
    _loadEpics(); // Call the asynchronous method here
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  // Asynchronous method to load epics from the database
  Future<void> _loadEpics() async {
    List<Epic> epics = await _epicDao.getAllEpics();
    setState(() {
      _epics = epics;
      _workItemData = _epics.map((epic) => epic.toWorkItemData()).toList();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addEpic(Epic epic) {
    setState(() {
      _epics.add(epic);
      _workItemData = _epics.map((epic) => epic.toWorkItemData()).toList();
    });
  }

  void _filterEpicsByStatus(Status? status) {
    setState(() {
      _selectedSortStatus = status;
      if (status == null) {
        _workItemData = _epics.map((epic) => epic.toWorkItemData()).toList();
      } else {
        _workItemData = _epics
            .where((epic) => epic.status == status)
            .map((epic) => epic.toWorkItemData())
            .toList();
      }
    });
  }

  void _toggleFilterVisibility() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
      if (_isFilterExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListDisplayWidget(context, _workItemData, setState),
              ),
            ],
          ),
          // Filter FAB
          Positioned(
            bottom: 80.0,
            right: 16.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizeTransition(
                  sizeFactor: _animationController,
                  axisAlignment: -1.0,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: DropdownButton<Status?>(
                      value: _selectedSortStatus,
                      hint: Text('Filter by Status'),
                      onChanged: (Status? newValue) {
                        _filterEpicsByStatus(newValue);
                        _toggleFilterVisibility();
                      },
                      items: [
                        DropdownMenuItem<Status?>(
                          value: null,
                          child: Text('All'),
                        ),
                        ...Status.values
                            .map<DropdownMenuItem<Status>>((Status value) {
                          return DropdownMenuItem<Status>(
                            value: value,
                            child: Text(value
                                .toString()
                                .split('.')
                                .last),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: "filterButton", // Add a unique heroTag here
                  onPressed: _toggleFilterVisibility,
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _animationController,
                  ),
                ),
              ],
            ),
          ),
          // Add Epic FAB
          Positioned(
            bottom: 16.0, // Adjust position as needed
            right: 16.0,
            child: FloatingActionButton(
              heroTag: "addEpicButton", // Add a unique heroTag here
              onPressed: () {
                // In the EpicListScreen, where you navigate to AddEpicScreen:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEpicScreen()),
                ).then((result) {
                  if (result != null && result is int) {
                    // Epic was added successfully, and 'result' is the new epicId
                    int newEpicId = result;
                    print('New epic added with ID: $newEpicId');
                    // Do something with the new epic ID, e.g., update the UI
                    _loadEpics();
                  } else {
                    // There was an error adding the epic
                    print('Error adding epic');
                    // Handle the error, e.g., show an error message to the user
                  }
                });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}