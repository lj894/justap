import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:justap/controllers/history.dart';
import 'package:justap/models/history.dart';
import 'package:justap/screens/home.dart';
import 'package:justap/services/remote_services.dart';
import 'dart:convert';
import 'package:justap/widgets/alert_dialog.dart';

class EditHistoryDialog extends StatefulWidget {
  History? history;

  EditHistoryDialog({this.history});

  @override
  _EditHistoryDialog createState() => _EditHistoryDialog();
}

class _EditHistoryDialog extends State<EditHistoryDialog> {
  void initState() {
    super.initState();
  }

  String? notes = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title:
                const Text("Edit Notes", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
            elevation: 0.0),
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          cursorColor: Theme.of(context).cursorColor,
                          initialValue: notes,
                          //minLines: 5,
                          maxLines: 4,
                          onChanged: (value) {
                            setState(() {
                              notes = value.toString();
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Notes',
                            labelStyle: TextStyle(
                              color: Colors.black87,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              child: const Text("Save"),
                              onPressed: () async {
                                //String? notes = '';
                                // try {
                                //   await RemoteServices.updateHistory(
                                //       widget.history?.id, notes);
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => HomeScreen(),
                                //         settings:
                                //             const RouteSettings(name: '/')),
                                //   );
                                // } catch (e) {
                                //   showAlertDialog(context, "Error", "$e");
                                // }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
