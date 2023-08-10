// Platform messages are asynchronous, so we initialize in an async method.
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotification {
  static init(String appID, {bool requireConsent = false}) async {
    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    OneSignal.User.pushSubscription.addObserver((state) {
      print(state.current.jsonRepresentation());
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });

    OneSignal.Notifications.addClickListener((event) {
      print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      /// preventDefault to not display the notification
      event.preventDefault();

      /// Do async work

      /// notification.display() to display after preventing default
      event.notification.display();
    });

    OneSignal.InAppMessages.addClickListener((event) {
      print(
          "In App Message Clicked: \n${event.result.jsonRepresentation().replaceAll("\\n", "\n")}");
    });
    OneSignal.InAppMessages.addWillDisplayListener((event) {
      print("ON WILL DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDisplayListener((event) {
      print("ON DID DISPLAY IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addWillDismissListener((event) {
      print("ON WILL DISMISS IN APP MESSAGE ${event.message.messageId}");
    });
    OneSignal.InAppMessages.addDidDismissListener((event) {
      print("ON DID DISMISS IN APP MESSAGE ${event.message.messageId}");
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    OneSignal.initialize(appID);

    // iOS-only method to open launch URLs in Safari when set to false
    // OneSignal.shared.setLaunchURLsInApp(false);

    // bool requiresConsent = await OneSignal.shared.requiresUserPrivacyConsent();

    // this.setState(() {
    //   _enableConsentButton = requiresConsent;
    // });

    // OneSignal.shared.disablePush(false);
    //
    // bool userProvidedPrivacyConsent =
    //     await OneSignal.shared.userProvidedPrivacyConsent();
    // print("USER PROVIDED PRIVACY CONSENT: $userProvidedPrivacyConsent");
  }

  ///The unique OneSignal id of this subscription
  ///var playerId = deviceState?.userId;

  ///Get device's push token identifier
  ///var pushToken = deviceState?.pushToken;

  ///The device's push subscription status
  ///var pushState = deviceState?.subscribed;

  static handlePromptForPushPermission() {
    print("Prompting for Permission");
    OneSignal.Notifications.requestPermission(true);
  }

  static sendTags(Map<String, dynamic> tags) {
    // print("Sending tags");
    // OneSignal.shared.sendTag("test2", "val2").then((response) {
    //   print("Successfully sent tags with response: $response");
    // }).catchError((error) {
    //   print("Encountered an error sending tags: $error");
    // });

    print("Sending tags array");
    OneSignal.User.addTags(tags).whenComplete(() {
      print("Successfully sent tags with response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static sendTag(String tag, dynamic value) {
    print("Sending tags array");
    OneSignal.User.addTagWithKey(tag, value).whenComplete(() {
      print("Successfully sent tags with response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static deleteTags(List<String> tags) {
    // print("Deleting tag");
    // OneSignal.shared.deleteTag("test2").then((response) {
    //   print("Successfully deleted tags with response $response");
    // }).catchError((error) {
    //   print("Encountered error deleting tag: $error");
    // });

    print("Deleting tags array");
    OneSignal.User.removeTags(tags).whenComplete(() {
      print("Successfully sent tags with response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static deleteTag(String tag) {
    print("Deleting tags array");
    OneSignal.User.removeTag(tag).whenComplete(() {
      print("Successfully sent tags with response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static setEmail(String email) {
    print("Setting email");
    OneSignal.User.addEmail(email).whenComplete(() {
      print("Successfully set email");
    }).catchError((error) {
      print("Failed to set email with error: $error");
    });
  }

  static removeEmail(String email) {
    print("Logging out of email");
    OneSignal.User.removeEmail(email).then((v) {
      print("Successfully logged out of email");
    }).catchError((error) {
      print("Failed to log out of email: $error");
    });
  }

  static setSMSNumber(String number) {
    print("Setting SMS Number");
    OneSignal.User.addSms(number).whenComplete(() {
      print("Successfully set SMSNumber with response");
    }).catchError((error) {
      print("Failed to set SMS Number with error: $error");
    });
  }

  static removeSMSNumber(String number) {
    print("Logging out of smsNumber");
    OneSignal.User.removeSms(number).whenComplete(() {
      print("Successfully logoutEmail with response");
    }).catchError((error) {
      print("Failed to log out of SMSNumber: $error");
    });
  }

  static setLanguage(String language) {
    print("Setting language");
    OneSignal.User.setLanguage(language).whenComplete(() {
      print("Successfully set language with response");
    }).catchError((error) {
      print("Failed to set language with error: $error");
    });
  }

  static setExternalUserId(String customUserID) {
    print("Setting external user ID");
    OneSignal.login(customUserID);
  }

  static removeExternalUserId() {
    OneSignal.logout();
  }

  static cleanAllNotification() {
    OneSignal.Notifications.clearAll();
  }

  static blockAllNotifications() {
    OneSignal.User.pushSubscription.optOut();
  }

  static enableAllNotifications() {
    OneSignal.User.pushSubscription.optIn();
  }

  ///Provide GDPR Consent
  static consentGranted(Function(bool consented) callback) {
    print("Setting consent to true");
    OneSignal.consentGiven(true);
    print("Setting state");
    callback(true);
  }

  static consentRevoke(Function(bool consented) callback) {
    print("Setting consent to false");
    OneSignal.consentGiven(false);
    print("Setting state");
    callback(false);
  }

  static consentLocationShared() {
    print("Setting location shared to true");
    OneSignal.Location.setShared(true);
  }

  static revokeLocationShared() {
    print("Setting location shared to false");
    OneSignal.Location.setShared(false);
  }
}
