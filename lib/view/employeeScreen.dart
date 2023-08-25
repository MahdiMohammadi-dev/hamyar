import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hamyar/Arguments/widgets.dart';
import 'package:hamyar/model/SignUpPageModel.dart';
import 'package:hamyar/model/calenderModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeScreen extends StatefulWidget {
  EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  CalenderModel calenderModel = Get.put<CalenderModel>(CalenderModel());
  SignUpPageModel signUpPageModel = Get.put<SignUpPageModel>(SignUpPageModel());

  Future<Map?> getdatafordashboardnamefamily() async {
    try {
      final dashboard = await Supabase.instance.client
          .from('person_info')
          .select('name , family , field')
          .eq('personcode', signUpPageModel.idPersonField.text);
      print("dashboard data is $dashboard");
      final list = (dashboard as List<dynamic>);
      return list.isEmpty ? null : list.first;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    getdatafordashboardnamefamily();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var datemorkhasi;
    return Scaffold(
      appBar: appBarSection(size),
      body: Column(
        children: [
          //TODO:Person Dashboard...
          Padding(
            padding: EdgeInsets.all(size.height / 140),
            child: Container(
                height: size.height / 9,
                width: size.width / 1,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Soft black shadow color with opacity
                        spreadRadius: 2, // How far the shadow spreads
                        blurRadius: 5, // The intensity of the shadow blur
                        offset: const Offset(
                            0, 3), // Offset of the shadow from the container
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height / 90)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 4, 14, 151),
                          Color.fromARGB(255, 8, 5, 189),
                        ])),
                child: FutureBuilder<Map?>(
                  future: getdatafordashboardnamefamily(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitCircle(
                        color: Colors.blueAccent,
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.hasError}');
                    } else {
                      final data = snapshot.data;
                      if (data == null) {
                        print('Data Is Null');
                      }
                      return Column(
                        children: [
                          //TODO:Person Information Section
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    right: size.width / 50,
                                    top: size.height / 100),
                                child: Container(
                                  height: size.height / 12,
                                  width: size.width / 6,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(size.height / 100))),
                                  child: Image.asset(
                                    fit: BoxFit.cover,
                                    'assets/images/woman.jpeg',
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: size.width / 50,
                                    ),
                                    child: Text(
                                      "${data?['name']} ${data?['family']}",
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          fontFamily: 'sansreg',
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'نام دانشکده:' + 'سما جنت آباد',
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontFamily: 'sansreg',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: size.width / 15,
                                ),
                                child: Text(
                                  'موقعیت: ${data?['field']}',
                                  style: const TextStyle(
                                      fontFamily: 'sansreg',
                                      color: Colors.white),
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                ),
                              )
                            ],
                          ),
                        ],
                      );
                    }
                  },
                )),
          ),
          SizedBox(
            height: size.height / 100,
          ),
          //TODO:Set Date Section
          Padding(
              padding: EdgeInsets.all(size.height / 140),
              child: Container(
                width: size.width / 1,
                height: size.height / 15,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Soft black shadow color with opacity
                        spreadRadius: 2, // How far the shadow spreads
                        blurRadius: 5, // The intensity of the shadow blur
                        offset: const Offset(
                            0, 3), // Offset of the shadow from the container
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height / 90)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 27, 8, 202),
                          Color.fromARGB(255, 18, 72, 252),
                        ])),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      calenderModel.calenderpicker(context);
                      print(calenderModel.datemorkhasi.value);
                    },
                    child: Text(
                      'وضعیت حضور یا غیابت رو مشخص کن',
                      style: TextStyle(
                          fontFamily: 'sansbold',
                          color: const Color.fromARGB(255, 212, 212, 212),
                          fontSize: size.height / 40),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: size.height / 20,
          ),
          Padding(
              padding: EdgeInsets.all(size.height / 140),
              child: Container(
                width: size.width / 1,
                height: size.height / 15,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.5), // Soft black shadow color with opacity
                        spreadRadius: 2, // How far the shadow spreads
                        blurRadius: 5, // The intensity of the shadow blur
                        offset: const Offset(
                            0, 3), // Offset of the shadow from the container
                      ),
                    ],
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height / 90)),
                    gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [
                          Color.fromARGB(255, 20, 8, 240),
                          Color.fromARGB(255, 2, 2, 94),
                          Color.fromARGB(255, 20, 8, 240),
                        ])),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      calenderModel.calenderpicker(context);
                      print(calenderModel.datemorkhasi.value);
                    },
                    child: Obx(
                      () => Text(
                        calenderModel.datemorkhasi.value,
                        style: TextStyle(
                            fontFamily: 'sansbold',
                            color: const Color.fromARGB(255, 212, 212, 212),
                            fontSize: size.height / 40),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
