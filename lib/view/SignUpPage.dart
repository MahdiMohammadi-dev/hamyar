import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamyar/model/SignUpPageModel.dart';
import 'package:hamyar/view/employeeScreen.dart';
import 'package:hamyar/view/studentScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Arguments/widgets.dart';

class SignUpPage extends StatefulWidget {
  final SupabaseClient client;
  const SignUpPage({super.key, required this.client});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpPageModel signUpPageModel = Get.put<SignUpPageModel>(SignUpPageModel());
  var idPersonField = TextEditingController();

  final supabaseClient = SupabaseClient(
    'https://sauzexiguejrtjahrkda.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhdXpleGlndWVqcnRqYWhya2RhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI0NzY2MjEsImV4cCI6MjAwODA1MjYyMX0.Lrgeo3xpUhuCSDVkd_c228Wl5dXtTt5x1XXacGYb6Fk',
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //TODO:Logo Section
              Padding(
                padding: EdgeInsets.only(top: size.height / 6.5),
                child: Center(
                  child: Image.asset(
                    'assets/images/unilogo.png',
                    height: size.height / 4,
                    width: size.width / 4,
                  ),
                ),
              ),
              //TODO:Welcom Section
              Text(
                'به سیستم هوشمند اعلام وضعیت همیار خوش آمدید',
                style: TextStyle(
                    fontFamily: 'nastaliq',
                    fontSize: size.height / 25,
                    overflow: TextOverflow.ellipsis),
              ),
              //TODO:TextField Section
              iDcodeTextFiled(size, signUpPageModel.idPersonField),
              SizedBox(
                height: size.height / 40,
              ),
              //CheckBox Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'کارمند',
                    style: TextStyle(
                        fontFamily: 'sansreg', fontSize: size.height / 40),
                  ),
                  //TODO: Employee CheckBox
                  Obx(
                    () => Checkbox(
                      value: signUpPageModel.employeecheck.value,
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        signUpPageModel.employeeupdatevalue(value!);
                      },
                    ),
                  ),

                  Text(
                    'دانشجو',
                    style: TextStyle(
                        fontFamily: 'sansreg', fontSize: size.height / 40),
                  ),
                  //TODO: Student CheckBox
                  Obx(() => Checkbox(
                        value: signUpPageModel.studentcheck.value,
                        checkColor: Colors.white,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          signUpPageModel.studentupdatevalue(value!);
                        },
                      ))
                ],
              ),
              SizedBox(
                height: size.height / 50,
              ),
              //TODO:Submit Button
              ElevatedButton(
                style:
                    const ButtonStyle(animationDuration: Duration(seconds: 3)),
                onPressed: () async {
                  List response = await Supabase.instance.client
                      .from('person_info')
                      .select('name , family')
                      .eq('personcode', signUpPageModel.idPersonField.text);
                  print(response.toString());

                  if (response.isNotEmpty &&
                      signUpPageModel.studentcheck.value) {
                    studentScreenRouteMethod(context);
                    print('StudentScreen');
                  } else if (response.isNotEmpty &&
                      signUpPageModel.employeecheck.value) {
                    employeeScreenRouteMethod(context);
                    print('EmployeeScreen');
                  } else if (response.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'خطا',
                              style: TextStyle(fontFamily: 'sansreg'),
                            ),
                            content: const Text(
                              'کاربری با اطلاعات وارد شده یافت نشد',
                              style: TextStyle(fontFamily: 'sansbold'),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'باشه',
                                  style: TextStyle(fontFamily: 'sansbold'),
                                ),
                              ),
                            ],
                          );
                        });
                  }
                },
                child: Text(
                  'ورود به سامانه',
                  style: TextStyle(
                      fontFamily: 'sansbold', fontSize: size.height / 30),
                ),
              )
            ],
          ),
        ));
  }

//TODO:Route To The Student Screen Page
  void studentScreenRouteMethod(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => StudentScreen(
              client: supabaseClient,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.decelerate;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }));
  }

  //TODO:Route To The Employee Screen Page
  void employeeScreenRouteMethod(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            EmployeeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.decelerate;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }));
  }
}
