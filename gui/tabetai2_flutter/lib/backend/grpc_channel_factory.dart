import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

class GrpcChannelFactory {
  static ClientChannelBase create(String host, int port) {
    return ClientChannel(host, port: port, options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }
}
