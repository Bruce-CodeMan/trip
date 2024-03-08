import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Custom imports pages
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/login_page.dart';
// Custom imports utils
import 'package:trip/dao/login_dao.dart';
import 'package:trip/utils/cache_util.dart';
import 'package:trip/utils/screen_adapter.dart';

void main() async{
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Trip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<dynamic>(
        future: Cache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          ScreenAdapter.init(context);
          if(snapshot.connectionState == ConnectionState.done) {
            if(LoginDao.getToken() != null) {
              return const HomePage();
            }else {
              return const LoginPage();
            }
          }else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      )
    );
  }
}