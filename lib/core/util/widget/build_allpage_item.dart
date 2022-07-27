
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import '../blocs/app/cubit.dart';
import 'check_status.dart';
class AllUserItemPage extends StatefulWidget {
  final Map item;

  AllUserItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<AllUserItemPage> createState() => _AllUserItemPageState();
}

class _AllUserItemPageState extends State<AllUserItemPage> {
  int index = 0;

  List<Color> containerColor = [
    Color(0xFFfdd835),
    Color(0xFFc41c00),
    Color(0xFF009624),
    Color(0xFF000063),
    Color(0xFF6a0080)
  ];
  @override
  Widget build(BuildContext context) {
    bool isClickable=true;
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=AppBloc.get(context);
        List<Widget>taskWidget=[
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'completed', id:widget.item['id']);
              },
              child: const Text('Completed')),
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'uncompleted', id:widget.item['id']);
              },
              child: const Text('UnCompleted')),
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'favourite', id:widget.item['id']);              },
              child: const Text('Favourite')),
        ];
        return Dismissible(
          key:  Key(widget.item['id'].toString()),
          onDismissed: (direction){
           cubit.deleteData(id:widget.item['id']);
          },
          child: Row(
            children: [
              GestureDetector(
                onTap: (){
                  cubit.updateUserData(status: 'completed', id:widget.item['id']);
                },
                child: CustomCheckStatus(
                  borderColor: cubit.myColor()
                  ,taskDescription: '${widget.item['name']}',),
              ),
              Spacer(),
              DropdownButton(
                icon:  const Icon(Icons.menu_outlined,
                  color: Colors.black,
                ),
                iconSize: 32,
                underline: Container(height: 0,),
                elevation: 4,
                items: taskWidget.map<DropdownMenuItem<Widget>>
                  ((Widget value){
                  return DropdownMenuItem<Widget>(
                      value: value,
                      child: value
                  );
                }).toList(),
                onChanged: (Widget?value){
                },

              )


            ],
          ),
        );
        
      },
    );
  }
}
