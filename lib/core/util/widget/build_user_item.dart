import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import 'package:new_todo_app/core/util/widget/text_button_module.dart';
import '../blocs/app/cubit.dart';
class UserItem extends StatefulWidget {
  final Map item;
  const UserItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppBloc.get(context);
        //Widget selectWidget=Icon(Icons.menu_outlined);
        List<Widget>taskWidget=[
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'completed', id:widget.item['id']);
              },
              child: Text('Completed')),
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'uncompleted', id:widget.item['id']);
              },
              child: Text('UnCompleted')),
          InkWell(
              onTap: (){
                cubit.updateUserData(status: 'favourite', id:widget.item['id']);              },
              child: Text('favourite')),
        ];
        return Dismissible(
          key:  Key(widget.item['id'].toString()),
          onDismissed: (direction){
            cubit.deleteData(id:widget.item['id']);
          },
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
            color: cubit.myColor(),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${widget.item['start']}',
                          style: const TextStyle(color: Colors.white, fontSize: 19,
                          fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.item['name']}',
                        style: const TextStyle(color: Colors.white, fontSize: 19,
                        fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  DropdownButton(
                    icon:  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.watch_later_rounded,
                        color: Colors.white,
                      ),
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
            ),
          ),
        );

      },
    );
  }
}
