import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/util/blocs/app/cubit.dart';

import 'features/todo_app/presentation/pages/user_layot_Page.dart';
void main() {


  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc()..initDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
            primarySwatch: Colors.teal

        ),
        home: const UserLayoutPage(),
        //UserLayoutPage(),
      ),
    );
  }
}
