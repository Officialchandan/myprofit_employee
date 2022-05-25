import 'dart:developer';

import 'package:employee/model/custome_textfeild.dart';
import 'package:employee/utils/colors.dart';
import 'package:flutter/material.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key? key, required this.user, required this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
      ),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Stack(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: TextFormField(
                    cursorColor: ColorPrimary,
                    initialValue: widget.user.title,
                    maxLength: 20,
                    onChanged: (val) {
                      log("===>${val}");
                      widget.user.title = val;
                      log("===>${widget.user.title}");
                    },
                    validator: (val) => val!.length > 3 ? null : 'Title is invalid',
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter title',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 14, top: 10),
                  child: TextFormField(
                    initialValue: widget.user.description,
                    maxLength: 50,
                    onChanged: (val) {
                      log("===>${val}");
                      widget.user.description = val;
                      log("===>${widget.user.description}");
                    },
                    cursorColor: ColorPrimary,
                    validator: (val) => val!.length > 10 ? null : 'Enter proper description',
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter description',
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPrimary, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
                right: 2,
                top: 0,
                child: InkWell(
                  onTap: widget.onDelete,
                  child: Container(
                    height: 20,
                    width: 20,
                    color: Colors.transparent,
                    child: Image.asset("images/delete.png"),
                  ),
                ))
          ]),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}
