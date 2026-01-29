import 'package:flutter/foundation.dart';

class PreferencesProvider with ChangeNotifier {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _orderUpdates = true;
  String _language = 'English';
  String _currency = 'USD';

  // Getters
  bool get pushNotifications => _pushNotifications;
  bool get emailNotifications => _emailNotifications;
  bool get orderUpdates => _orderUpdates;
  String get language => _language;
  String get currency => _currency;

  // Setters
  void togglePushNotifications(bool value) {
    _pushNotifications = value;
    notifyListeners();
  }

  void toggleEmailNotifications(bool value) {
    _emailNotifications = value;
    notifyListeners();
  }

  void toggleOrderUpdates(bool value) {
    _orderUpdates = value;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void setCurrency(String curr) {
    _currency = curr;
    notifyListeners();
  }

  // Reset to defaults
  void resetPreferences() {
    _pushNotifications = true;
    _emailNotifications = false;
    _orderUpdates = true;
    _language = 'English';
    _currency = 'USD';
    notifyListeners();
  }
}
