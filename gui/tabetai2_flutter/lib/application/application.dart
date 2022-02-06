import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/application/home_page_widget.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabetai2 Client',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePageWidget(title: 'Tabetai2', backendClient: backendClient),
    );
  }
}
