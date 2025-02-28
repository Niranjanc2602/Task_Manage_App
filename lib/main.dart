import 'package:flutter/material.dart';
import 'package:sqflite_test/screens/epic_list_screen.dart';
import 'package:sqflite_test/screens/home_screen.dart';
import 'database/database_helper.dart'; // Import your database helper
import 'models/dog.dart'; // Import your dog model

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async calls before runApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final dbHelper = DatabaseHelper(); // Create an instance of the helper

  @override
  void initState() {
    super.initState();
    // _testDatabase();
  }

  // Future<void> _testDatabase() async {
  //   // Create a dog
  //   final dog = Dog(id: 0, name: 'Fido', age: 3);
  //
  //   // Insert the dog into the database
  //   await dbHelper.insertDog(dog);
  //
  //   // Get all dogs from the database
  //   final dogs = await dbHelper.dogs();
  //
  //   // Print the dogs
  //   print(dogs);
  //
  //   // Update the dog's age
  //   final updatedDog = Dog(id: 0, name: 'Fido', age: 4);
  //   await dbHelper.updateDog(updatedDog);
  //
  //   // Get all dogs again
  //   final updatedDogs = await dbHelper.dogs();
  //
  //   // Print the updated dogs
  //   print(updatedDogs);
  //
  //   // Delete the dog
  //   await dbHelper.deleteDog(0);
  //
  //   // Get all dogs again
  //   final deletedDogs = await dbHelper.dogs();
  //
  //   // Print the deleted dogs
  //   print(deletedDogs);
  // }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}