import 'package:flutter/material.dart';
import 'package:new_todo_app/features/todo_app/presentation/pages/schedulig_page.dart';

import '../../../../core/util/widget/text_button_module.dart';
import '../pages/add_task_page.dart';
import '../pages/all_task_page.dart';
import '../pages/completed_task_page.dart';
import '../pages/favourite_page.dart';
import '../pages/un_completed_page.dart';
class UserWidget extends StatelessWidget {
  const UserWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
          return DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: AppBar(
                  elevation: 2,
                  backgroundColor: Colors.white,
                  title: (const Text('Board',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ))),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=>  SchedulingPage()));

                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black,

                        )),

                  ],
                  bottom: TabBar(
                    labelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                    labelColor: Colors.black,
                    isScrollable: true,
                    indicatorColor: Colors.grey[600],
                    tabs: const <Widget>[
                      Tab(
                        text: 'ALL',
                      ),
                      Tab(text: 'Completed'),
                      Tab(text: ' Un Completed'),
                      Tab(text: 'Favourites'),
                    ],
                  ),
                ),
                body: const TabBarView(
                  children: [
                    AllTaskPage(),
                    CompletedTaskPage(),
                    UnCompletedPage(),
                    FavouritePage(),
                  ],
                )),
          );


  }
}
