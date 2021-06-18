import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  final Connectivity _connectivity = Connectivity();

  Future<bool> checkConnectivity() async {
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}