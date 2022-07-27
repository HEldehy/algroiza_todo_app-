import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/blocs/app/cubit.dart';
import '../../../../core/util/blocs/app/states.dart';
import '../../../../core/util/widget/build_allpage_item.dart';
import '../../../../core/util/widget/build_user_item.dart';
class CompletedTaskWidget extends StatelessWidget {
  const CompletedTaskWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: cubit.completed.isEmpty ?
          const Center(child: CircularProgressIndicator(
            color: Colors.teal,
          )):ListView.separated(
              itemBuilder: (context,index)=>UserItem(
                item: cubit.completed[index],
              ),
              separatorBuilder:(context,index)=>
              const SizedBox(height: 10,),
              itemCount: cubit.completed.length),
        );
      },
    );
  }
}
