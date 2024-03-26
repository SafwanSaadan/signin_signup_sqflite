// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class Components {
  void showSuccessDialog(
      BuildContext context, int seconds, String route, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: seconds), () {
          Navigator.of(context).pushReplacementNamed('$route');
        });
        return AlertDialog(content: Text('$text'));
      },
    );
  }

// showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             // title: const Text('ملاحظة'),
//             content: const Text('تم إنشاء الحساب بنجاح'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushReplacementNamed('home');
//                 },
//                 child: const Text('التالي'),
//               ),
//             ],
//           );
//         },
//       );
}
