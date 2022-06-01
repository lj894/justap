import 'package:flutter/material.dart';

class MediaDialog extends StatefulWidget {
  @override
  _MediaDialog createState() => _MediaDialog();
}

class _MediaDialog extends State<MediaDialog> {
  String mediaType = "Instagram";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          title: Text('Create Link'),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Instagram',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black),
                  ),
                  leading: Radio(
                    value: "Instagram",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        mediaType = value.toString();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Facebook',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black38),
                  ),
                  leading: Radio(
                    value: "Facebook",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: null,
                    // onChanged: (value) {
                    //   print(value);
                    //   setState(() {
                    //     mediaType = value.toString();
                    //   });
                    // },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Twitter',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black38),
                  ),
                  leading: Radio(
                    value: "Twitter",
                    groupValue: mediaType,
                    activeColor: Color(0xFF6200EE),
                    onChanged: null,
                    // onChanged: (value) {
                    //   print(value);
                    //   setState(() {
                    //     mediaType = value.toString();
                    //   });
                    // },
                  ),
                ),
                TextFormField(
                  cursorColor: Theme.of(context).cursorColor,
                  initialValue: '',
                  //maxLength: 50,
                  decoration: InputDecoration(
                    //icon: Icon(Icons.favorite),
                    labelText: 'URL',
                    labelStyle: TextStyle(
                      color: Color(0xFF6200EE),
                    ),
                    helperText: 'Your personal link',
                    border: OutlineInputBorder(),
                    // enabledBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                    // ),
                  ),
                ),
                Container(
                  height: 50,
                  //color: Colors.amber[100],
                  child: Center(
                      child: ElevatedButton(
                    child: Text("Save"),
                    onPressed: () {
                      //context.read<AuthenticationService>().signOut();
                      setState(() {});
                    },
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
