import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/core/util/blocs/app/cubit.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import 'package:new_todo_app/core/util/widget/build_allpage_item.dart';
import 'package:new_todo_app/core/util/widget/custom_large_text.dart';

import '../../../../core/util/widget/build_user_item.dart';
class SchedulingWidget extends StatefulWidget {
  const SchedulingWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  MyHomePageState createState() => MyHomePageState();
}
class MyHomePageState extends State<SchedulingWidget> {
  final DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();
  @override
  void initState() {

    super.initState();
    NotificationListenerProvider().getMessage(context);

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppBloc.get(context);
        return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const LargeText(
                largeText: 'Schedule',
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DatePicker(

                          DateTime.now(),

                          width: 50,
                          height: 80,
                          controller: _controller,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: Colors.green,
                          selectedTextColor: Colors.white,
                          inactiveDates: [
                            DateTime.now().add(const Duration(days: 3)),
                            DateTime.now().add(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 7))
                          ],

                          onDateChange: (date) {
                            setState(() {
                              _selectedValue = date;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Thursday'),
                      Text(DateFormat.yMMMd().format(DateTime.now())),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [

                      ListView.separated(
                        shrinkWrap: true,
                          itemBuilder: (context,index)=>UserItem(
                            item: cubit.completed[index],
                          ),
                          separatorBuilder:(context,index)=>
                          const SizedBox(height: 10,),
                          itemCount: cubit.completed.length)
                    ],
                  )




                ],
              ),
            ));
      },

    );
  }
}
