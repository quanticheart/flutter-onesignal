// Platform messages are asynchronous, so we initialize in an async method.
import 'package:flutter/foundation.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalNotification {
  static init(String appID, {bool requireConsent = false}) async {
    if (kDebugMode) {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }

    await OneSignal.shared.setRequiresUserPrivacyConsent(requireConsent);

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print('NOTIFICATION OPENED HANDLER CALLED WITH: ${result}');
      // setState(() {
      //   _debugLabelString =
      //       "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent? event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');

      /// Display Notification, send null to not display
      // event?.complete(null);
      return event?.complete(event.notification);
      // this.setState(() {
      //   _debugLabelString =
      //       "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });

    OneSignal.shared
        .setInAppMessageClickedHandler((OSInAppMessageAction action) {
      // this.setState(() {
      //   _debugLabelString =
      //       "In App Message Clicked: \n${action.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("SUBSCRIPTION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("PERMISSION STATE CHANGED: ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges changes) {
      print("EMAIL SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    OneSignal.shared
        .setSMSSubscriptionObserver((OSSMSSubscriptionStateChanges changes) {
      print("SMS SUBSCRIPTION STATE CHANGED ${changes.jsonRepresentation()}");
    });

    OneSignal.shared.setOnWillDisplayInAppMessageHandler((message) {
      print("ON WILL DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDisplayInAppMessageHandler((message) {
      print("ON DID DISPLAY IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnWillDismissInAppMessageHandler((message) {
      print("ON WILL DISMISS IN APP MESSAGE ${message.messageId}");
    });

    OneSignal.shared.setOnDidDismissInAppMessageHandler((message) {
      print("ON DID DISMISS IN APP MESSAGE ${message.messageId}");
    });

    // NOTE: Replace with your own app ID from https://www.onesignal.com
    await OneSignal.shared.setAppId(appID);

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

  static getDeviceState() async {
    print("Getting DeviceState");
    OneSignal.shared.getDeviceState().then((deviceState) {
      print("DeviceState: ${deviceState?.jsonRepresentation()}");
    });
  }

  static handlePromptForPushPermission() {
    print("Prompting for Permission");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  static sendTags(Map<String, dynamic> tags) {
    // print("Sending tags");
    // OneSignal.shared.sendTag("test2", "val2").then((response) {
    //   print("Successfully sent tags with response: $response");
    // }).catchError((error) {
    //   print("Encountered an error sending tags: $error");
    // });

    print("Sending tags array");
    OneSignal.shared.sendTags(tags).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static sendTag(String tag, dynamic value) {
    print("Sending tags array");
    OneSignal.shared.sendTags({tag: value}).then((response) {
      print("Successfully sent tags with response: $response");
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
    OneSignal.shared.deleteTags(tags).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static deleteTag(String tag) {
    print("Deleting tags array");
    OneSignal.shared.deleteTag(tag).then((response) {
      print("Successfully sent tags with response: $response");
    }).catchError((error) {
      print("Encountered an error sending tags: $error");
    });
  }

  static getTags(Function(Map<String, dynamic> tags) callback) {
    OneSignal.shared.getTags().then((tags) {
      callback(tags);
    }).catchError((error) {
      // setState(() {
      //   _debugLabelString = "$error";
      // });
    });
  }

  static setEmail(String email) {
    print("Setting email");
    OneSignal.shared.setEmail(email: email).whenComplete(() {
      print("Successfully set email");
    }).catchError((error) {
      print("Failed to set email with error: $error");
    });
  }

  static removeEmail() {
    print("Logging out of email");
    OneSignal.shared.logoutEmail().then((v) {
      print("Successfully logged out of email");
    }).catchError((error) {
      print("Failed to log out of email: $error");
    });
  }

  static setSMSNumber(String number) {
    print("Setting SMS Number");
    OneSignal.shared.setSMSNumber(smsNumber: number).then((response) {
      print("Successfully set SMSNumber with response $response");
    }).catchError((error) {
      print("Failed to set SMS Number with error: $error");
    });
  }

  static removeSMSNumber() {
    print("Logging out of smsNumber");
    OneSignal.shared.logoutSMSNumber().then((response) {
      print("Successfully logoutEmail with response $response");
    }).catchError((error) {
      print("Failed to log out of SMSNumber: $error");
    });
  }

  static setLanguage(String language) {
    print("Setting language");
    OneSignal.shared.setLanguage(language).then((response) {
      print("Successfully set language with response: $response");
    }).catchError((error) {
      print("Failed to set language with error: $error");
    });
  }

  static setExternalUserId(String customUserID) {
    print("Setting external user ID");
    OneSignal.shared.setExternalUserId(customUserID).then((results) {
      // setState(() {
      //   _debugLabelString = "External user id set: $results";
      // });
    });
  }

  static Future<String?> getPlayerID() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState == null || deviceState.userId == null) return null;
    var playerId = deviceState.userId!;
    return playerId;
  }

  static removeExternalUserId() {
    OneSignal.shared.removeExternalUserId().then((results) {
      // setState(() {
      //   _debugLabelString = "External user id removed: $results";
      // });
    });
  }

  static cleanAllNotification() {
    OneSignal.shared.clearOneSignalNotifications();
  }

  static blockAllNotifications() async {
    await OneSignal.shared.disablePush(true);
  }

  static enableAllNotifications() async {
    await OneSignal.shared.disablePush(false);
  }

  ///Provide GDPR Consent
  static consentGranted(Function(bool consented) callback) {
    print("Setting consent to true");
    OneSignal.shared.consentGranted(true);
    print("Setting state");
    callback(true);
  }

  static consentRevoke(Function(bool consented) callback) {
    print("Setting consent to false");
    OneSignal.shared.consentGranted(false);
    print("Setting state");
    callback(false);
  }

  static consentLocationShared() {
    print("Setting location shared to true");
    OneSignal.shared.setLocationShared(true);
  }

  static revokeLocationShared() {
    print("Setting location shared to false");
    OneSignal.shared.setLocationShared(false);
  }

  static debugTestNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState == null || deviceState.userId == null) return;

    var playerId = deviceState.userId!;

    var imgUrlString =
        "https://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

    var notification = OSCreateNotification(
        playerIds: [playerId],
        content: "this is a test from OneSignal's Flutter SDK",
        heading: "Test Notification",
        iosAttachments: {"id1": imgUrlString},
        bigPicture: imgUrlString,
        buttons: [
          OSActionButton(text: "test1", id: "id1"),
          OSActionButton(text: "test2", id: "id2")
        ]);

    var response = await OneSignal.shared.postNotification(notification);
    print("debugTestNotification : $response");
  }

  static debugTestSilentNotification() async {
    var deviceState = await OneSignal.shared.getDeviceState();

    if (deviceState == null || deviceState.userId == null) return;

    var playerId = deviceState.userId!;

    var notification = OSCreateNotification.silentNotification(
        playerIds: [playerId], additionalData: {'test': 'value'});

    var response = await OneSignal.shared.postNotification(notification);
    print("debugTestNotification : $response");
  }
}

_registerOneSignalTriggers() {
  // CHANGE THIS parameter to true if you want to test GDPR privacy consent

  // Some examples of how to use In App Messaging public methods with OneSignal SDK
  // oneSignalInAppMessagingTriggerExamples();
  // // Some examples of how to use Outcome Events public methods with OneSignal SDK
  // oneSignalOutcomeEventsExamples();
}

oneSignalInAppMessagingTriggerExamples() async {
  /// Example addTrigger call for IAM
  /// This will add 1 trigger so if there are any IAM satisfying it, it
  /// will be shown to the user
  OneSignal.shared.addTrigger("trigger_1", "one");

  /// Example addTriggers call for IAM
  /// This will add 2 triggers so if there are any IAM satisfying these, they
  /// will be shown to the user
  Map<String, Object> triggers = Map<String, Object>();
  triggers["trigger_2"] = "two";
  triggers["trigger_3"] = "three";
  OneSignal.shared.addTriggers(triggers);

  // Removes a trigger by its key so if any future IAM are pulled with
  // these triggers they will not be shown until the trigger is added back
  OneSignal.shared.removeTriggerForKey("trigger_2");

  // Get the value for a trigger by its key
  Object? triggerValue =
      await OneSignal.shared.getTriggerValueForKey("trigger_3");
  print("'trigger_3' key trigger value: ${triggerValue?.toString()}");

  // Create a list and bulk remove triggers based on keys supplied
  List<String> keys = ["trigger_1", "trigger_3"];
  OneSignal.shared.removeTriggersForKeys(keys);

  // Toggle pausing (displaying or not) of IAMs
  OneSignal.shared.pauseInAppMessages(false);
}

oneSignalOutcomeEventsExamples() async {
  // Await example for sending outcomes
  outcomeAwaitExample();

  // Send a normal outcome and get a reply with the name of the outcome
  OneSignal.shared.sendOutcome("normal_1");
  OneSignal.shared.sendOutcome("normal_2").then((outcomeEvent) {
    print(outcomeEvent.jsonRepresentation());
  });

  // Send a unique outcome and get a reply with the name of the outcome
  OneSignal.shared.sendUniqueOutcome("unique_1");
  OneSignal.shared.sendUniqueOutcome("unique_2").then((outcomeEvent) {
    print(outcomeEvent.jsonRepresentation());
  });

  // Send an outcome with a value and get a reply with the name of the outcome
  OneSignal.shared.sendOutcomeWithValue("value_1", 3.2);
  OneSignal.shared.sendOutcomeWithValue("value_2", 3.9).then((outcomeEvent) {
    print(outcomeEvent.jsonRepresentation());
  });
}

Future<void> outcomeAwaitExample() async {
  var outcomeEvent = await OneSignal.shared.sendOutcome("await_normal_1");
  print(outcomeEvent.jsonRepresentation());
}
