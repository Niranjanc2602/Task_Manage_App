import 'package:flutter/material.dart';
import '../models/UserStory.dart';
import '../utils/dummy_data.dart';
import 'add_user_story_screen.dart';
import 'user_story_detail_screen.dart';

class UserStoryListScreen extends StatefulWidget {
  final int epicId;

  UserStoryListScreen({required this.epicId});

  @override
  _UserStoryListScreenState createState() => _UserStoryListScreenState();
}

class _UserStoryListScreenState extends State<UserStoryListScreen> {
  List<UserStory> _userStories = [];

  @override
  void initState() {
    super.initState();
    _userStories = DummyData.getDummyUserStories(widget.epicId);
  }

  void _addUserStory(UserStory userStory) {
    setState(() {
      _userStories.add(userStory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height/1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _userStories.isEmpty
                ? Center(child: Text('No user stories found.'))
                : Expanded(
                  child: ListView.builder(
                      itemCount: _userStories.length,
                      itemBuilder: (context, index) {
                        final userStory = _userStories[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(userStory.name),
                            subtitle: Text(userStory.description!),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UserStoryDetailScreen(userStory: userStory),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                ),
          ],
        ),
      ),
    );
  }
}
