import 'package:flutter/material.dart';
import 'package:one_signal_test/one_signal.dart';
import 'package:one_signal_test/one_signal_buttom.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String _debugLabelString = "";
  bool _enableConsentButton = false;

  String _emailAddress = "dev.jonny255d@gmail.com";
  String _smsNumber = "+551942032176";
  String _externalUserId = "JONNYZ";
  String _language = "pt_BR";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignalNotification.consentGranted((consented) => {
          setState(() {
            _enableConsentButton = consented;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OneSignal Flutter Demo'),
          backgroundColor: const Color.fromARGB(255, 212, 86, 83),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Table(
              children: [
                TableRow(children: [
                  OneSignalButton("Provide GDPR Consent", () {
                    OneSignalNotification.consentGranted((consented) => {
                          setState(() {
                            _enableConsentButton = consented;
                          })
                        });
                  }, _enableConsentButton),
                ]),
                TableRow(children: [
                  OneSignalButton("Revoke GDPR Consent", () {
                    OneSignalNotification.consentRevoke((p0) {
                      setState(() {
                        _enableConsentButton = p0;
                      });
                    });
                  }, !_enableConsentButton)
                ]),

                TableRow(children: [
                  OneSignalButton("Send Tags", () {
                    OneSignalNotification.sendTags({'test': 'value'});
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  OneSignalButton("Prompt for Push Permission", () {
                    OneSignalNotification.handlePromptForPushPermission;
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Email Address",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 86, 83),
                        )),
                    onChanged: (text) {
                      setState(() {
                        _emailAddress = (text == "" ? null : text)!;
                      });
                    },
                  )
                ]),
                TableRow(children: [
                  Container(
                    height: 8.0,
                  )
                ]),
                TableRow(children: [
                  OneSignalButton("Set Email", () {
                    OneSignalNotification.setEmail(_emailAddress);
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "SMS Number",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 86, 83),
                        )),
                    onChanged: (text) {
                      setState(() {
                        _smsNumber = (text == "" ? null : text)!;
                      });
                    },
                  )
                ]),
                TableRow(children: [
                  Container(
                    height: 8.0,
                  )
                ]),
                TableRow(children: [
                  OneSignalButton("Set SMS Number", () {
                    OneSignalNotification.setSMSNumber(_smsNumber);
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  OneSignalButton("Set Location Shared", () {
                    OneSignalNotification.consentLocationShared();
                  }, _enableConsentButton),
                ]),
                TableRow(children: [
                  OneSignalButton("Revoke Location Shared", () {
                    OneSignalNotification.revokeLocationShared();
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  OneSignalButton("Delete Tags", () {
                    OneSignalNotification.deleteTags(['test']);
                  }, _enableConsentButton),
                ]),
                TableRow(children: [
                  OneSignalButton("Delete Tag", () {
                    OneSignalNotification.deleteTag("test2");
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "External User ID",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 86, 83),
                        )),
                    onChanged: (text) {
                      setState(() {
                        _externalUserId = (text == "" ? null : text)!;
                      });
                    },
                  )
                ]),
                TableRow(children: [
                  Container(
                    height: 8.0,
                  )
                ]),
                TableRow(children: [
                  OneSignalButton("Set External User ID", () {
                    OneSignalNotification.setExternalUserId(_externalUserId);
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  OneSignalButton("Remove External User ID", () {
                    OneSignalNotification.removeExternalUserId();
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "Language",
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 212, 86, 83),
                        )),
                    onChanged: (text) {
                      setState(() {
                        _language = (text == "" ? null : text)!;
                      });
                    },
                  )
                ]),
                TableRow(children: [
                  Container(
                    height: 8.0,
                  )
                ]),
                TableRow(children: [
                  OneSignalButton("Set Language", () {
                    OneSignalNotification.setLanguage(_language);
                  }, _enableConsentButton)
                ]),
                TableRow(children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(_debugLabelString),
                  )
                ]),
              ],
            ),
          ),
        ));
  }
}
