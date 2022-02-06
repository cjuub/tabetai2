import 'package:flutter/material.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_communicator.dart';

import 'application/application.dart';


void main() async {
  BackendCommunicator backendCommunicator = BackendCommunicator();
  BackendClient backendClient = BackendClient(backendCommunicator);
  runApp(MyApp(backendClient: backendClient));
}
