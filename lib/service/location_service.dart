import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class LocationService {
  Future<bool> requestPermission() async {
    final result = await Geolocator.requestPermission();
    return result == LocationPermission.always ||
        result == LocationPermission.whileInUse;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}
