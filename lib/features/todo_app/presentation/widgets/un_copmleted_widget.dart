import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/core/util/widget/build_user_item.dart';

import '../../../../core/util/blocs/app/cubit.dart';
import '../../../../core/util/blocs/app/states.dart';
import '../../../../core/util/widget/build_allpage_item.dart';
class UnCompletedWidget extends StatelessWidget {
  const UnCompletedWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: cubit.uncompleted.isEmpty ?
          const Center(child: CircularProgressIndicator(
            color: Colors.teal,
          )):ListView.separated(
              itemBuilder: (context,index)=>UserItem(
                item: cubit.uncompleted[index],
              ),
              separatorBuilder:(context,index)=>
              const SizedBox(height: 10,),
              itemCount: cubit.uncompleted.length),
        );
      },
    );
  }
}