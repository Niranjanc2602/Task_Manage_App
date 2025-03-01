import 'package:flutter/material.dart';
import 'package:sqflite_test/constants/Status.dart';
import 'package:sqflite_test/models/WorkItemData.dart';
import 'package:sqflite_test/models/Epic.dart';
import 'package:sqflite_test/utils/widget.dart';
import 'add_epic_screen.dart';
import '../utils/dummy_data.dart'; // Import the dummy data

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

  @override
  void initState() {
    super.initState();
    _epics = DummyData.getDummyEpics();
    _workItemData = _epics.map((epic) => epic.toWorkItemData()).toList();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
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
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                FloatingActionButton(
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEpicScreen()),
                ).then((newEpic) {
                  if (newEpic != null && newEpic is Epic) {
                    _addEpic(newEpic);
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