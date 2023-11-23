// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aulerta_final/controller/Medicine/createMedicineController.dart';
import 'package:aulerta_final/controller/Medicine/showMedicineController.dart';
import 'package:aulerta_final/controller/login/login_controller.dart';
import 'package:aulerta_final/pages/pills/commom/convert_time.dart';
import 'package:aulerta_final/pages/pills/constants.dart';
import 'package:aulerta_final/pages/pills/models/medicine_type.dart';
import 'package:aulerta_final/pages/pills/pages/cadastro/new_entry_bloc.dart';
import 'package:aulerta_final/pages/pills/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController nameController;
  late TextEditingController dosageController;

  // late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  final _intervals = [4, 6, 8, 12, 24];
  var _selected = 0;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    // _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    // _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer4<CreateMedicineController, NewEntryBloc, LoginController, ShowMedicineController>(
      builder: (context, createMedicineController, _newEntryBloc , loginController,showMedicineController ,child) {
        return Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Nova Medicação",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PanelTitle(
                    title: "Nome da Medicação",
                    isRequired: true,
                  ),
                  TextFormField(
                    maxLength: 36,
                    controller: nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: pkOtherColor),
                  ),
                  const PanelTitle(
                    title: "Dosagem (mg)",
                    isRequired: false,
                  ),
                  TextFormField(
                    maxLength: 12,
                    controller: dosageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: pkOtherColor),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const PanelTitle(title: 'Tipo do Medicamento', isRequired: true),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: StreamBuilder<MedicineType>(
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MedicineTypeColumn(
                              medicineType: MedicineType.syringe,
                              name: 'Vacina',
                              iconValue: 'assets/icons/syringe.svg',
                              isSelected: snapshot.data == MedicineType.syringe
                                  ? true
                                  : false,
                            ),
                            MedicineTypeColumn(
                              medicineType: MedicineType.tablet,
                              name: 'Pílula',
                              iconValue: 'assets/icons/tablet.svg',
                              isSelected: snapshot.data == MedicineType.tablet
                                  ? true
                                  : false,
                            ),
                            MedicineTypeColumn(
                              medicineType: MedicineType.pill,
                              name: 'Cápsula',
                              iconValue: 'assets/icons/pill.svg',
                              isSelected:
                                  snapshot.data == MedicineType.pill ? true : false,
                            ),
                            MedicineTypeColumn(
                              medicineType: MedicineType.bottle,
                              name: 'Xarope',
                              iconValue: 'assets/icons/bottle.svg',
                              isSelected: snapshot.data == MedicineType.bottle
                                  ? true
                                  : false,
                            ),
                          ],
                        );
                      },
                      stream: _newEntryBloc.selectedModicineType,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const PanelTitle(title: 'Intervalo', isRequired: true),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Me lembre a cada',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        DropdownButton(
                          iconEnabledColor: pkOtherColor,
                          dropdownColor: pkScaffordColor,
                          itemHeight: 8.h,
                          hint: _selected == 0
                              ? Text(
                                  'Selecione',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              : null,
                          elevation: 4,
                          value: _selected == 0 ? null : _selected,
                          items: _intervals.map(
                            (int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: pkSecondaryColor),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (newVal) {
                            setState(
                              () {
                                _selected = newVal!;
                              },
                            );
                          },
                        ),
                        Text(
                          _selected == 1 ? " hora" : " horas",
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                  const PanelTitle(title: 'Horario Inicial', isRequired: true),
                  const SelectTime(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: SizedBox(
                      width: 80.w,
                      height: 8.h,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: pkPrimaryColor,
                            shape: const StadiumBorder()),
                        child: Center(
                          child: Text(
                            "Confirmar",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: pkScaffordColor),
                          ),
                        ),
                        onPressed: () async{
                          var type = '';
                          switch (_newEntryBloc.selectedModicineType?.value.toString()) {
                            case 'MedicineType.syringe':
                              type = "vacina";
                              break;
                            case 'MedicineType.tablet':
                              type= "cápsula";
                              break;
                            case 'MedicineType.pill':
                              type= "pílula";
                              break;
                            default:
                              type= "xarope";
                              break;
                          };

                          await createMedicineController.createMedicine(nameController.text, dosageController.text, _selected.toString(), type,'1', loginController.token.toString());

                          var result = createMedicineController.response;

                          if(result != false){
                            Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const PillsPage()),
                            (Route<dynamic> route) => false);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime() async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _time);

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: pkPrimaryColor, shape: const StadiumBorder()),
          onPressed: () {
            _selectTime();
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Selecionar Hora"
                  : "${convertTime(_time.hour.toString())} : ${convertTime(_time.minute.toString())}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: pkScaffordColor),
            ),
          ),
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn({
    Key? key,
    required this.medicineType,
    required this.name,
    required this.iconValue,
    required this.isSelected,
  }) : super(key: key);
  final MedicineType medicineType;

  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.h),
              color: isSelected ? pkOtherColor : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
                child: SvgPicture.asset(
                  iconValue,
                  height: 7.h,
                  color: isSelected ? Colors.white : pkOtherColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? pkOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: isSelected ? Colors.white : pkOtherColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: pkPrimaryColor),
            )
          ],
        ),
      ),
    );
  }
}
