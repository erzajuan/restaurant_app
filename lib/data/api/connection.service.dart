import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DataService {
  bool connected;
  String message;
  DataService({@required this.connected, @required this.message});
}

class ConnectionService {
  Future<DataService> connectionService(BuildContext context) async {
    bool connected;
    String message = '';
    final connection = await DataConnectionChecker().connectionStatus;
    if (connection == DataConnectionStatus.connected) {
      connected = true;
    } else {
      connected = false;
      message = 'Disconnect, please turn on your internet.';
    }
    return DataService(
      connected: connected,
      message: message,
    );
  }
}
