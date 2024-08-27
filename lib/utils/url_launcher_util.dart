import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

class UrlLauncherUtil {
  static final Logger _logger = Logger();

  // Handle phone call or SMS action
  static Future<void> handlePhoneAction(String action, String phoneNumber) async {
    Uri uri;
    if (action == 'Call') {
      uri = Uri(scheme: 'tel', path: phoneNumber);
      _logger.i('Attempting to call $phoneNumber');
    } else if (action == 'Message') {
      uri = Uri(scheme: 'sms', path: phoneNumber);
      _logger.i('Attempting to message $phoneNumber');
    } else {
      _logger.w('Unknown action: $action');
      throw 'Unknown action: $action';
    }

    try {
      if (!await launchUrl(uri)) {
        _logger.e('Could not launch $uri');
        throw 'Could not launch $uri';
      }
    } catch (e) {
      _logger.e('Failed to launch $uri: $e');
    }
  }

  // Handle address action (viewing in map)
  static Future<void> handleAddressAction(String address) async {
    final query = Uri.encodeComponent(address);
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
    _logger.i('Attempting to view address: $address');

    try {
      if (!await launchUrl(uri)) {
        _logger.e('Could not launch $uri');
        throw 'Could not launch $uri';
      }
    } catch (e) {
      _logger.e('Failed to launch $uri: $e');
    }
  }
}
