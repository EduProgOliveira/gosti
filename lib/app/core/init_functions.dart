import 'package:geolocator/geolocator.dart';

class InitFunctions {
  static Future<Position> getLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }
}
