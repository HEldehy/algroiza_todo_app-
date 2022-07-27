import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import 'package:new_todo_app/core/util/widget/text_button_module.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  late Database database;
  List<Map> users = [];
  List<Map> completed = [];
  List<Map> uncompleted = [];
  List<Map> favourite = [];
  int index=0;


  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'users.db');

    debugPrint('AppDatabaseInitialized');

    openAppDatabase(
      path: path,
    );

    emit(AppDatabaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY,'
              ' name TEXT,date TEXT,start TEXT,end TEXT,remind INTEGER,'
              'repeat TEXT,status TEXT)',
        );
        debugPrint('Table Created');
      },
      onOpen: (Database db) {
        debugPrint('AppDatabaseOpened');
        database = db;

        getUsersData();
      },
    );
  }

  void insertUserData({
  required String text,
    required String date,
    required String startTime,
    required String endTime,
    required dynamic  remind,
    required String repeat,
}) {
    if(selectedUser.isNotEmpty) {
      return;
    }

    database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO users(name,date,start,'
              'end,remind,repeat,status) VALUES("$text",'
              '"$date","$startTime","$endTime","$remind","$repeat","new")');
    }).then((value) {
      debugPrint('User Data Inserted');

      getUsersData();

      emit(AppDatabaseUserCreated());
    });
  }

  void getUsersData() async {
    users=[];
    completed=[];
    uncompleted=[];
    favourite=[];
    emit(AppDatabaseLoading());
    database.rawQuery('SELECT * FROM users').then((value) {
      debugPrint('Users Data Fetched');
      users = value;
      debugPrint(users.toString());
      users.forEach((element) {
        if(element['status']=='new') {
          users.add(element);
        } else
        if(element['status']=='completed') {
          completed.add(element);
          users=[];
        } else
          if(element['status']=='uncompleted') {
            uncompleted.add(element);
            users=[];
          }
          else{
            favourite.add(element);
            users=[];
          }
      });

      emit(AppDatabaseUsers());
    });
  }

  Map selectedUser = {};

  void selectUserToUpdate({
    required Map user,
  }) {
    selectedUser = user;


    emit(AppSelectUser());
  }

  void updateUserData({
  required String status,
  required int id,


}) async {
    database.rawUpdate(
        'UPDATE users SET status  = ? WHERE id = ? ', [
          status, id

    ]).then((value) {

      selectedUser = {};
      emit(AppDatabaseUpdateUsers());
      debugPrint('User Data Updated');
      getUsersData();
    });
  }
  bool isSelected = false;
 void checkBoxStatus(){
   isSelected=!isSelected;
   emit(CheckStatus());
 }
  Color myColor(){
    return Color.fromARGB(255, Random().nextInt(256),
        Random().nextInt(256), Random().nextInt(256));
  }
  void deleteData({
    required int id,
  })async{

    database.rawDelete(
        'DELETE FROM users WHERE id = ? ',[id]
    ).then((value){
      getUsersData();
      debugPrint('deleted');
      emit(AppDatabaseDeleteUsers());

    });


  }



  int selectRemind=5;
 List<int>remindList=[
   5,10,15,20

 ];

  String selectRepeat='none';
  List<String>repeatList=[
    'none','Daily','Weakly','Monthly'

  ];









}