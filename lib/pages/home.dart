import 'package:aulerta_final/constant.dart';
import 'package:aulerta_final/pages/login_&_signup/Login/login.dart';
import 'package:aulerta_final/pages/onboarding_&_home/default_widget.dart';
import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:aulerta_final/pages/pills/pages/home.dart';
import 'package:aulerta_final/pages/task/controllers/task_controller.dart';
import 'package:aulerta_final/pages/task/models/task.dart';
import 'package:aulerta_final/pages/task/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // Lista de telas que serão exibidas no BottomNavigationBar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              title: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bem-Vindo(a)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                ),
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                    ))
              ]),
          sliverList(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              margin: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primaryColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(0, 10),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/community-bg.png'),
                  alignment: Alignment.centerRight,
                ),
              ),
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Os melhores produtos \nestão aqui!',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Confira já',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          sliverList(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categorias',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sliverList(
            child: SizedBox(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                shrinkWrap: true,
                primary: false,
                // physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.horizontal,
                children: [
                  GridOption(
                    image: 'assets/vet.png',
                    title: 'Saúde',
                    isSelected: true,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const PillsPage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                  GridOption(
                    image: 'assets/Grooming.png',
                    title: 'Banho/Tosa',
                    isSelected: false,
                    onTap: () {},
                  ),
                  GridOption(
                    image: 'assets/food.png',
                    title: 'Alimentação',
                    isSelected: false,
                    onTap: () {},
                  ),
                  GridOption(
                    image: 'assets/playing.png',
                    title: 'Atividades',
                    isSelected: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          sliverList(
            child: Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: 5,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suas atividades',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const TasksPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: const Icon(
                          Icons.add,
                          size: 30.0,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sliverList(
              child: ListView(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(0),
            children: const [
              DrListContainer(),
              DrListContainer(),
              DrListContainer(),
            ],
          ))
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
}

class DrListContainer extends StatelessWidget {
  const DrListContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image:
                    AssetImage('assets/aulerta-logo.png'), // change in future
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dr. Ariyo Hartono',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Consulta',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '16h50 - XX/YY',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '2.1 KM',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
                onPressed: () {
                  print('on click');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridOption extends StatelessWidget {
  const GridOption({
    Key? key,
    required this.image,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 4.3,
              height: 85,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : secondaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Image.asset(
                image,
                // fit: BoxFit.scaleDown,
                height: 50,
              ),
            ),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_showTasks() {
  final taskController = Get.put(TaskController());
  return Expanded(
    child: Obx(
      () {
        return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = taskController.taskList[index];
          },
        );
      },
    ),
  );
}
