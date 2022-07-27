import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:new_todo_app/core/util/blocs/app/cubit.dart';
import 'package:new_todo_app/core/util/blocs/app/states.dart';
import 'package:new_todo_app/core/util/widget/custom_large_text.dart';
import 'package:new_todo_app/core/util/widget/text_form_field.dart';
import '../../../../core/util/widget/text_button_module.dart';
class AddTaskWidget extends StatefulWidget {
  const AddTaskWidget({Key? key}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  @override

  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();
    TextEditingController repeatController = TextEditingController();
    TextEditingController remindController = TextEditingController();




    return BlocConsumer<AppBloc,AppStates>(
            listener: (context,state){},
            builder: (context,state){
              var cubit =AppBloc.get(context);
              List<Color> containerColor = [
                Color(0xFFc41c00),
                Color(0xFF000063),
                Color(0xFFfdd835),
              ];
              int selectedColors=0;

              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  title: const LargeText(
                    largeText: 'Add Task',
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LargeText(largeText: 'Title'),
                        const SizedBox(
                          height: 15,
                        ),
                        MyFormField(
                          label: 'Design Team Meeting',
                          controller: usernameController,
                          type: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const LargeText(largeText: 'Date'),
                        const SizedBox(
                          height: 15,
                        ),
                        MyFormField(label:DateFormat.yMMMd().format(DateTime.now()),
                        controller: dateController,
                          type: TextInputType.datetime,
                          suffixIcon: IconButton(onPressed: (){
                            showDatePicker(context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('2022-12-17'))
                                .then((value){
                                  dateController.text=
                                      DateFormat.yMMMd().format(value!);

                                  debugPrint(DateFormat.yMMMd().format(value));
                            });
                          },
                            icon:const Icon(Icons.calendar_today_outlined) ,),

                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:  CrossAxisAlignment.start,
                                children: const [
                                  LargeText(largeText: 'Start Time')
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [LargeText(largeText: 'End Time')],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyFormField(
                                    label: '11:00 Am',
                                    controller: startTimeController,
                                    type: TextInputType.datetime,
                                    suffixIcon: IconButton(onPressed: () {
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).
                                      then((value){
                                        startTimeController.text=value!.format(context);
                                        debugPrint(value.toString());

                                      });


                                    }, icon: const Icon(Icons.access_time_outlined),),

                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyFormField(
                                    label: '11:00 Am',
                                    controller: endTimeController,
                                    type: TextInputType.datetime,
                                    suffixIcon: IconButton(onPressed: (){
                                      showTimePicker(context: context,
                                          initialTime: TimeOfDay.now()).
                                      then((value){
                                        endTimeController.text=value!.format(context);
                                        debugPrint(value.toString());

                                      });

                                    },
                                      icon:const Icon(Icons.access_time_outlined) ,),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        const LargeText(largeText: 'Remind'),
                        const SizedBox(
                          height: 15,
                        ),
                        MyFormField(label: '${cubit.selectRemind} Minute Early',
                         controller: remindController,

                          type: TextInputType.text,
                          suffixIcon: DropdownButton(
                            icon:  const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey,

                            ),
                            iconSize: 32,
                            underline: Container(height: 0,),

                            elevation: 4,
                            items: cubit.remindList.map<DropdownMenuItem<String>>
                              ((int value){
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(value.toString())
                                );
                            }).toList(),
                            onChanged: (String?value){
                            setState((){
                              cubit.selectRemind=int.parse(value!);
                            });

                            },

                          )

                        ),
                        const SizedBox(height: 15,),
                        const LargeText(largeText: 'Repeat'),
                        const SizedBox(height: 15,),
                        MyFormField(label: cubit.selectRepeat,
                            controller: repeatController,

                            type: TextInputType.text,
                            suffixIcon: DropdownButton(
                              icon:  const Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey,

                              ),
                              iconSize: 32,
                              underline: Container(height: 0,),

                              elevation: 4,
                              items: cubit.repeatList.map<DropdownMenuItem<String>>
                                ((String value){
                                return DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(value.toString())
                                );
                              }).toList(),
                              onChanged: (String?value){
                                setState((){
                                  cubit.selectRepeat=value!;
                                });

                              },

                            )

                        ),
                        const SizedBox(
                          height: 50),
                        // ),
                        // // Row(children: [
                        // //   Column(
                        // //     crossAxisAlignment: CrossAxisAlignment.start,
                        // //     children: [
                        // //     const LargeText(largeText: 'Colors'),
                        // //     SizedBox(height: 5,),
                        // //     Wrap(children:
                        // //       List<Widget>.generate(3, (index){
                        // //
                        // //         return GestureDetector(
                        // //           onTap: (){
                        // //             setState((){
                        // //               selectedColors=index;
                        // //             });
                        // //           },
                        // //           child: Padding(
                        // //             padding: const EdgeInsets.only( right: 8.0),
                        // //             child: CircleAvatar(
                        // //               child:selectedColors==index? const Icon(Icons.done,
                        // //               color: Colors.white,
                        // //                 size: 25,
                        // //               ):Container(),
                        // //               radius: 14,
                        // //               backgroundColor:
                        // //               index==0?containerColor[index]
                        // //                   :containerColor[index++],
                        // //
                        // //             ),
                        // //           ),
                        // //         );
                        // //
                        // //
                        // //       }),
                        // //     )
                        // //
                        // //   ],),
                        // //
                        // // ],),
                        // const SizedBox(height: 15,),
                        ButtonOfText(text: 'Create Task',
                          onClick: () {
                            AppBloc.get(context).insertUserData(
                                text: usernameController.text,
                                date: dateController.text,
                                startTime: startTimeController.text,
                                endTime: endTimeController.text,
                              repeat: repeatController.text,
                              remind: remindController.text


                            );


                          },
                          color: Colors.white,
                          buttonColor: Colors.green,)


                      ],
                    ),
                  ),
                ),
              );
            },
          );


  }
}
