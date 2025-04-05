import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/base/base_stream_controller.dart';

@singleton
class WifiConnectionService {
  WifiConnectionService();
  final connectivityPlus = Connectivity();
  final isConnect = BaseStreamController(false);

  @PostConstruct(preResolve: true)
  Future<void> onInit() async {
    isConnect.value = await onCheckConnection();
  }

  @disposeMethod
  void dispose() {
    isConnect.dispose();
  }

  Future<bool> onCheckConnection() async {
    final result = await connectivityPlus.checkConnectivity();

    return checkListConnection(result);
  }

  bool checkListConnection(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.ethernet) ||
        result.contains(ConnectivityResult.vpn) ||
        result.contains(ConnectivityResult.bluetooth) ||
        result.contains(ConnectivityResult.other)) {
      return true;
    } else if (result.contains(ConnectivityResult.none)) {
      return false;
    }
    return true;
  }
}
