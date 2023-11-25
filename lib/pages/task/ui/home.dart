import 'package:aulerta_final/pages/home.dart';
import 'package:aulerta_final/pages/pills/pages/home.dart';
import 'package:aulerta_final/pages/task/controllers/task_controller.dart';
import 'package:aulerta_final/pages/task/models/task.dart';
import 'package:aulerta_final/pages/task/ui/add_taskbar.dart';
import 'package:aulerta_final/pages/task/ui/theme.dart';
import 'package:aulerta_final/pages/task/ui/widgets/buttom.dart';
import 'package:aulerta_final/pages/task/ui/widgets/task_tile.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _HomePageState();
  
}

class _HomePageState extends State<TasksPage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _addTaskBar(),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryColor,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              dayTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              monthTextStyle: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey)),
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _showTasks(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Saúde',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          print('selected index $index');
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navegue para a tela Home
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const HomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const PillsPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const TasksPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          }
        },
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == "Diariamente") {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(_selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}

_showBottomSheet(BuildContext context, Task task) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? darkGreyClr : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
          ),
          const Spacer(),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Finalizar Atividade",
                  onTap: () {
                    final taskController = Get.put(TaskController());
                    taskController.markTaskCompleted(task.id!);
                    Get.back();
                  },
                  clr: primaryColor,
                  context: context,
                ),
          _bottomSheetButton(
            label: "Deletar",
            onTap: () {
              final taskController = Get.put(TaskController());
              taskController.delete(task);
              taskController.getTasks();
              Get.back();
            },
            clr: Colors.red,
            context: context,
          ),
          const SizedBox(height: 20),
          _bottomSheetButton(
            label: "Fechar",
            onTap: () {
              Get.back();
            },
            clr: Colors.red[300]!,
            isClosed: true,
            context: context,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

_bottomSheetButton(
    {required String label,
    required Function()? onTap,
    required Color clr,
    bool isClosed = false,
    required BuildContext context}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color:
                isClosed == true ? const Color.fromARGB(85, 244, 67, 54) : clr),
        borderRadius: BorderRadius.circular(20),
        color: isClosed == true ? Colors.transparent : clr,
      ),
      child: Center(
        child: Text(
          label,
          style:
              isClosed ? titleStyle : titleStyle.copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}

_addTaskBar() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 5, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: subHeadingStyle,
            ),
            Text(
              "Hoje",
              style: headingStyle,
            )
          ],
        ),
        MyButtom(
            label: "+ Atividade",
            onTap: () async {
              await Get.to(const AddTaskPage());
              final taskController = Get.put(TaskController());
              taskController.getTasks();
            })
      ],
    ),
  );
}

_appBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFFF7934A),
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false);
      },
      child: const Icon(Icons.keyboard_arrow_left,
          size: 30, color: Color.fromARGB(255, 255, 255, 255)),
    ),
    actions: const [
      SizedBox(
        width: 20,
      ),
    ],
  );
}
