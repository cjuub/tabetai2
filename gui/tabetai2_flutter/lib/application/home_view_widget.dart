import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';

class HomeViewWidget extends StatefulWidget {
  const HomeViewWidget({Key? key, required this.backendClient}) : super(key: key);

  final BackendClient backendClient;

  @override
  State<StatefulWidget> createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("Home");
  }
}
