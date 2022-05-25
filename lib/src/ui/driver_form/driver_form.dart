import 'package:employee/utils/colors.dart';
import 'package:flutter/material.dart';

class DriverForm extends StatefulWidget {
  @override
  _DriverFormState createState() => _DriverFormState();
}

class _DriverFormState extends State<DriverForm> {
  //dhaba-idea-radio
  int dhabaIdeaRadio = 0;

  void dhabaIdeaRadioFunc(int value) {
    setState(() {
      dhabaIdeaRadio = value;
    });
  }
  //dhaba-idea-radio

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: ColorPrimary,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                iconSize: 20,
                onPressed: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
          title: Text('Driver Form', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Response of drivers at business idea',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaIdeaRadio,
                        activeColor: ColorPrimary,
                        onChanged: (value) {
                          dhabaIdeaRadioFunc(value as int);
                        }),
                    Text('A- for highly interested'),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaIdeaRadio,
                        activeColor: ColorPrimary,
                        onChanged: (value) {
                          dhabaIdeaRadioFunc(value as int);
                        }),
                    Text('B- mildly interested'),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 3,
                        groupValue: dhabaIdeaRadio,
                        activeColor: ColorPrimary,
                        onChanged: (value) {
                          dhabaIdeaRadioFunc(value as int);
                        }),
                    Text('C- not interested'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Suggestions',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Name of driver',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Mobile Number',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Address (For gifts)',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Truck Agency (Usual)',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Route on which he travels often',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Per meal expenditure (Approx.)',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Preferred gifts',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Text('(Box, Earphones, Torch) etc.',
                  style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Any other truck driver’s',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Mobile number',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Addresss',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Any other suggestions',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: ButtonTheme(
                  minWidth: 200,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    color: ColorPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
