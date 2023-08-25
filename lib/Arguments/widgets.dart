import 'package:flutter/material.dart';

Padding iDcodeTextFiled(Size size, TextEditingController idPersonField) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.height / 75),
    child: TextField(
      controller: idPersonField,
      textAlign: TextAlign.right,
      style: TextStyle(fontFamily: 'sansbold', fontSize: size.height / 50),
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(size.height / 50))),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: size.height / 50),
          child: Icon(
            Icons.person,
            size: size.height / 25,
            color: Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'کد پرسنلی یا شماره دانشجویی',
        hintStyle: TextStyle(
          fontFamily: 'sansbold',
          fontSize: size.height / 50,
        ),
      ),
    ),
  );
}

Padding codeMelliTextField(Size size) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.height / 75),
    child: TextField(
      textAlign: TextAlign.right,
      style: TextStyle(fontFamily: 'sansbold', fontSize: size.height / 50),
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(size.height / 50))),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: size.height / 50),
          child: Icon(
            Icons.info,
            size: size.height / 25,
            color: Colors.grey,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: 'کدملی',
        hintStyle: TextStyle(
          fontFamily: 'sansbold',
          fontSize: size.height / 50,
        ),
      ),
    ),
  );
}

AppBar appBarSection(Size size) {
  return AppBar(
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
  );
}
