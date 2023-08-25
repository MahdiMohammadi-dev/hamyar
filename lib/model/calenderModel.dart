import 'package:get/get.dart';
import 'package:hamyar/model/SignUpPageModel.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalenderModel extends GetxController {
  Rx<String> datemorkhasi = Rx<String>('روزی ثبت نشده است');
  SignUpPageModel signUpPageModel = Get.put<SignUpPageModel>(SignUpPageModel());
  calenderpicker(context) async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );
    if (picked == null) {
      return;
    }
    datemorkhasi.value = picked.formatFullDate();

    //TODO: update supabase
    final response = Supabase.instance.client
        .from('person_info')
        .update({'date': datemorkhasi.value})
        .eq('personcode', signUpPageModel.idPersonField.text)
        .then((value) {
          print("value is ${value}");
        });

    print("Response is ${response}");
    update();
    print(datemorkhasi.value);
  }
}
