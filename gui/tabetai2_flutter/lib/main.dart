import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:tabetai2_flutter/backend/backend_client.dart';
import 'package:tabetai2_flutter/backend/backend_communicator.dart';

import 'application/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("app_settings");
  BackendCommunicator backendCommunicator = BackendCommunicator();
  BackendClient backendClient = BackendClient(backendCommunicator);
  backendClient.handleSubscription();
  runApp(MyApp(backendClient: backendClient));
}
