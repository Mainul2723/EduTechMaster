// main_view.dart

import 'package:edutechmaster/screens/dashboard.dart';
import 'package:edutechmaster/screens/login.dart';
import 'package:edutechmaster/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          final MainController mainController = Get.find();
          return PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            controller: PageController(initialPage: mainController.currentIndex.value),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Login();
              } else if (index == 1) {
                return SignUpScreen();
              } else if (index == 2) {
                return DashBoard(name: '', email: '', imageUrl: '',);
              }

              // Return an empty container by default
              return Container();
            },
          );
        },
      ),
    );
  }
}
