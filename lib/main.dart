import 'package:apicrudoperation/screens/note_list.dart';
import 'package:apicrudoperation/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void getSetup() {
  GetIt.instance.registerLazySingleton(() => NoteService());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteListSceen(),
    );
  }
}
