import 'dart:async';

import 'package:flutter/material.dart';
import 'pages/myhomepage.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
// import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await SendbirdChat.init(appId: 'BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF');
      await SendbirdChat.connect("f93b05ff359245af400aa805bafd2a091a173064");
      // FlutterError.onError = (errorDetails) {
      //   debugPrint('[FlutterError] ${errorDetails.stack}');
      //   Fluttertoast.showToast(
      //     msg: '[FlutterError] ${errorDetails.stack}',
      //     gravity: ToastGravity.CENTER,
      //     toastLength: Toast.LENGTH_SHORT,
      //   );
      // };
      print(
          "${SendbirdChat.currentUser?.nickname} ${SendbirdChat.currentUser?.friendName}  ${SendbirdChat.currentUser?.metaData}");
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      debugPrint('[Error] $error\n$stackTrace');
      // Fluttertoast.showToast(
      //   msg: '[Error] $error',
      //   gravity: ToastGravity.CENTER,
      //   toastLength: Toast.LENGTH_SHORT,
      // );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '강남스팟',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}
