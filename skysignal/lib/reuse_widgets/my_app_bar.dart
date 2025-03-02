import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skysignal/screens/setting.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        actions: [
          IconButton(onPressed: (){
            Get.to(const Profile());
          }, icon: const Icon(Icons.settings)),
        ],
      ),

      extendBodyBehindAppBar: true,



    );
  }
}
