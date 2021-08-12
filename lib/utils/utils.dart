import 'dart:ui';
import 'package:get/get.dart';


/// check enable dark mode or not
bool darkModeEnabled() {
  final brightness = Get.theme.brightness;
  if (brightness == Brightness.dark) return true;
  return false;
}

double castWeiToEth(BigInt amount) => amount.toDouble() / 10e17;

BigInt castEthToWei(double amount) => BigInt.from(amount * 10e17);

bool isNumeric(String value) => double.tryParse(value) != null;