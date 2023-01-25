import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/bloc/cubit/observer.dart';
import 'package:paymob/network/remote/dio_helper.dart';
import 'package:paymob/screens/home.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper().init();

  Bloc.observer = MyBlocObserver();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({this.startWidget,super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

