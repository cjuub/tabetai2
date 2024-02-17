import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_web.dart';

class GrpcChannelFactory {
  static ClientChannelBase create(String host, int port) {
    return GrpcWebClientChannel.xhr(Uri.parse("http://$host:$port"));
  }
}
