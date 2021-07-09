import 'package:flutter/material.dart';
import 'package:portfolio_site/utilities/common.dart';

class ContactForum extends StatefulWidget {
  const ContactForum({Key key}) : super(key: key);

  @override
  _ContactForumState createState() => _ContactForumState();
}

class _ContactForumState extends State<ContactForum> {
  final _formKey = GlobalKey<FormState>();
  final _data = Map<String, String>();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 575,
        width: MediaQuery.of(context).size.width < 500 ? 280 : 550,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please fill out this field';
                          else
                            return null;
                        },
                        onSaved: (val) => setState(() => _data['name'] = val),
                        maxLength: 80,
                        maxLines: 1,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "E-mail"),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please fill out this field';
                          else
                            return null;
                        },
                        onSaved: (val) => setState(() => _data['email'] = val),
                        maxLength: 80,
                        maxLines: 1,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Subject"),
                        initialValue: "Greetings",
                        onSaved: (val) =>
                            setState(() => _data['subject'] = val),
                        maxLength: 80,
                        maxLines: 1,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Message"),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please fill out this field';
                          else
                            return null;
                        },
                        onSaved: (val) => setState(() => _data['msg'] = val),
                        maxLength: 1024,
                        maxLines: 10,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      CommonUtility.sendContact(_data).then((resp) {
                        debugPrint(resp.body);
                        if (resp.statusCode != 200)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Failed to send message")));
                        else
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Message successfully sent")));
                      });
                      Navigator.pop(context, "Thanks");
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ));
  }
}
