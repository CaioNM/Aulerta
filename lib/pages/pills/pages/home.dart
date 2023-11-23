import 'package:aulerta_final/constant.dart';
import 'package:aulerta_final/controller/Medicine/showMedicineController.dart';
import 'package:aulerta_final/controller/login/login_controller.dart';
import 'package:aulerta_final/models/medicines/showMedicine_model.dart';
import 'package:aulerta_final/pages/home.dart';
import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:aulerta_final/pages/pills/pages/cadastro/new_entry.dart';
import 'package:aulerta_final/pages/pills/pages/medicine_detais.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PillsPage extends StatefulWidget {
  const PillsPage({super.key});

  @override
  State<PillsPage> createState() => _PillsPageState();
}

class _PillsPageState extends State<PillsPage> {
  int _currentIndex = 1;



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 10), () {
      String token = context.read<LoginController>().token!;
      context.read<ShowMedicineController>().showMedicine("1", token);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginController, ShowMedicineController>(
      builder: (context, loginController , showMedicineController, child) {
        return Scaffold(
          appBar: AppBar(
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
          ),
          body: Padding(
            padding: EdgeInsets.all(2.h),
            child: Column(
              children: [
                const TopContainer(),
                SizedBox(
                  height: 2.h,
                ),
                Flexible(
                  child: BottomContainer(listaMedicamentos: showMedicineController.medicines!,),
                ),
              ],
            ),
          ),
          floatingActionButton: InkResponse(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewEntryPage(),
                ),
              );
            },
            child: SizedBox(
              width: 18.w,
              height: 9.h,
              child: Card(
                color: pkPrimaryColor,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3.h),
                ),
                child: Icon(
                  Icons.add_outlined,
                  color: pkScaffordColor,
                  size: 50.sp,
                ),
              ),
            ),
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
            },
          ),
        );
      }
    );
  }
}


class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Minhas \nMedicações',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
          child: Text(
            'Para viver forte e saudável!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            bottom: 1.h,
          ),
        ),
      ],
    );
  }
}

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key, required this.listaMedicamentos});
  final List<Medicines> listaMedicamentos;

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 1.h),
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4),
      children: [
        ...widget.listaMedicamentos.map((e) => Card( 
          child: InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MedicineDetails(id: e.id!, name: e.name!, dose: e.dose!, frequency: e.frequency!, type: e.type!, pet_id: e.petId!)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              e.type == "pílula" ? 'assets/icons/pill.svg' : e.type == "vacina" ? "assets/icons/syringe.svg" : e.type == "cápsula" ? "assets/icons/tablet.svg" : e.type == "xarope" ? "assets/icons/bottle.svg" : 'assets/icons/pill.svg',
              height: 7.h,
              color: pkPrimaryColor,
            ),
            const Spacer(),
            Text(
              e.name.toString(),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              'A cada ' + e.frequency.toString() + ' horas',
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    ),
        )
    ),
      ],
      
      
      
      
    );
  }
}

class MedicineCard extends StatefulWidget {
  const MedicineCard({super.key, required this.listaMedicamentos});
  final List<Medicines> listaMedicamentos;



  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  HomePage()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.h),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/bottle.svg',
              height: 7.h,
              color: pkPrimaryColor,
            ),
            const Spacer(),
            Text(
              'Calpol',
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 0.3.h,
            ),
            Text(
              'A cada 8 horas',
              overflow: TextOverflow.fade,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
