import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/core/util/blocs/app/cubit.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import 'package:new_todo_app/core/util/widget/build_allpage_item.dart';
import 'package:new_todo_app/core/util/widget/text_button_module.dart';
import 'package:new_todo_app/core/util/widget/build_user_item.dart';

import '../pages/add_task_page.dart';
class AllTaskWidget extends StatelessWidget {
   const AllTaskWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Stack(
          alignment:AlignmentDirectional.bottomCenter ,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: cubit.users.isEmpty ?
              const Center(child: CircularProgressIndicator(
                color: Colors.teal,
              )):ListView.separated(
                  itemBuilder: (context,index)=>AllUserItemPage(
                    item: cubit.users[index],
                  ),
                  separatorBuilder:(context,index)=>
                      const SizedBox(height: 10,),
                  itemCount: cubit.users.length),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonOfText(text: 'Add Task',
                  onClick: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                        const AddTaskPage()));
                  },
                  color: Colors.white,
                  buttonColor: Colors.green),
            )

          ],
        );
      },
    );
  }

}
