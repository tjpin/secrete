import 'package:secrete/core.dart';
import 'package:secrete/models/wifi_account.dart';
import 'package:wifi_iot/wifi_iot.dart';

void connectToWifi(WifiAccount wifi) async {
  await WiFiForIoTPlugin.findAndConnect(wifi.name, password: wifi.password)
      .then((connected) {
    connected
        ? successToast('connected to ${wifi.name}')
        : errorToast("could not connect to ${wifi.name}");
  });
}

void enableWifi() async {
  await WiFiForIoTPlugin.setEnabled(true);
}

Future<bool> isRegistered(String ssid) async {
  try {
    return await WiFiForIoTPlugin.isRegisteredWifiNetwork(ssid);
  } on PlatformException catch (_) {
    errorToast("Not supported");
    return false;
  }
}

void registerAndConnect(WifiAccount wifi) async {
  await WiFiForIoTPlugin.registerWifiNetwork(wifi.name).then((registered) {
    if (registered) {
      connectToWifi(wifi);
      return;
    } else {
      errorToast("Could not register network");
      return;
    }
  });
}

void checkAndConnectWifi(WifiAccount wifi) async {
  final isEnabled = await WiFiForIoTPlugin.isWiFiAPEnabled();
  switch (isEnabled) {
    case true:
      validateAndConnect(wifi);
    case false:
      validateAndConnect(wifi);
  }
}

void validateAndConnect(WifiAccount wifi) async {
  enableWifi();
  final status = await isRegistered(wifi.name);
  switch (status) {
    case true:
      connectToWifi(wifi);
      break;
    case false:
      registerAndConnect(wifi);
      break;
  }
}

