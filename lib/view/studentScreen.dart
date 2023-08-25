import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:hamyar/model/calenderModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/SignUpPageModel.dart';

class StudentScreen extends StatefulWidget {
  final SupabaseClient client;
  StudentScreen({super.key, required this.client});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 6),
          child: Text(
            'سیستم هوشمند همیار',
            style: TextStyle(
              fontFamily: 'nastaliq',
              fontSize: size.height / 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 3));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TODO:Person Dashboard...
              Padding(
                padding: EdgeInsets.all(size.height / 140),
                child: Container(
                    height: size.height / 9,
                    width: size.width / 1,
                    decoration: BoxDecoration(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitCircle(
                            color: Colors.blueAccent,
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          final data = snapshot.data;

                          if (data == null) {
                            return Text("data is null");
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
                                              Radius.circular(
                                                  size.height / 100))),
                                      child: Image.asset(
                                        fit: BoxFit.cover,
                                        'assets/images/avatar.jpg',
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
                                          "${data['name']} ${data['family']}",
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                              fontFamily: 'sansreg',
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
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
                                      'موقعیت: ${data['field']}',
                                      style: TextStyle(
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
              Padding(
                  padding: EdgeInsets.all(size.height / 140),
                  child: Container(
                    width: size.width / 1,
                    height: size.height / 15,
                    decoration: BoxDecoration(
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
                      child: Text(
                        'شرح وضعیت حضور کارمندان دانشگاه',
                        style: TextStyle(
                            fontFamily: 'sansbold',
                            color: Color.fromARGB(255, 212, 212, 212),
                            fontSize: size.height / 40),
                      ),
                    ),
                  )),
              //Status of Employee Section
              FutureBuilder<List>(
                future: fetchDataFromSupabase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error:${snapshot.hasError}');
                  } else {
                    final list = snapshot.data!;
                    return SizedBox(
                      width: double.infinity,
                      height: size.height / 1.5,
                      child: RefreshIndicator(
                        onRefresh: () {
                          return Future.delayed(
                            Duration(seconds: 3),
                            () => getdatafordashboardnamefamily(),
                          );
                        },
                        child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final item = list[index];
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Container(
                                width: size.width / 4,
                                height: size.height / 8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(size.height / 100)),
                                    color: Colors.blueGrey[700]),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: size.width / 40,
                                              top: size.height / 150),
                                          child: Text(
                                            '${item['name']}${" "}${item['family']}',
                                            style: TextStyle(
                                                fontFamily: 'sansreg',
                                                fontSize: size.height / 45,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height / 70,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: size.width / 40),
                                          child: Text(
                                            item['field'],
                                            style: TextStyle(
                                                fontFamily: 'sansreg',
                                                fontSize: size.height / 45,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width / 7),
                                      child: Text(
                                        'روز غیبت: '
                                        '${item['date'] ?? ""}',
                                        style: TextStyle(
                                            fontFamily: 'sansreg',
                                            color: Colors.white,
                                            fontSize: size.height / 60),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> fetchDataFromSupabase() async {
    try {
      final response = await Supabase.instance.client
          .from('person_info')
          .select('name , family , field , date')
          .eq('fieldcheck', 'TRUE');
      return response as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> fetchDataForDashBoard() async {
    try {
      final dashboardresponse = await Supabase.instance.client
          .from('person_info')
          .select('name , family , field')
          .eq('personcode', signUpPageModel.idPersonField);
      return dashboardresponse as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}
