import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOService {
  static IO.Socket socket = IO.io('http://linkfysocket.linkfy.org:3434',  <String, dynamic>{
    'transports': ['websocket']
  });
  

  static void initSocket(){
    socket.onConnect((_) {
    Logger().i('Socket Connection Established Success');
    socket.emit('msg', 'test');
  });

  socket.onConnectError((error) => Logger().e(error));
  socket.onError((error) => Logger().e(error));
  socket.onConnecting((data) => Logger().i(data));
  socket.onPing((data) => Logger().i(data));
  socket.onPong((data) => Logger().i(data));
  socket.onReconnect((data) => Logger().i(data));
  socket.onDisconnect((data) => Logger().i(data));
  socket.onConnectTimeout((data) => Logger().i(data));
  socket.onReconnecting((data) => Logger().i(data));
  socket.onReconnectFailed((data) => Logger().i(data));
  }
}