import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myprofit_employee/src/ui/add_dhaba/add_dhaba.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myprofit_employee/utils/validator.dart';

class Form2 extends StatefulWidget {
  @override
  _Form2State createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  //image-picker
  File? dhabaCertificationImage;

  //image-picker

  //dhaba-area-radio
  int dhabaAreaRadio = 0;

  void dhabaAreaRadioFunc(int value) {
    setState(() {
      dhabaAreaRadio = value;
    });
  }

  //dhaba-area-radio

  //dhaba-availability-radio
  int dhabaAvailabilityRadio = 0;

  void dhabaAvailabilityRadioFunc(int value) {
    setState(() {
      dhabaAvailabilityRadio = value;
    });
  }

  //dhaba-availability-radio

  //dhaba-lodging-radio
  int dhabaLodgingRadio = 0;

  void dhabaLodgingRadioFunc(int value) {
    setState(() {
      dhabaLodgingRadio = value;
    });
  }

  //dhaba-lodging-radio

  //dhaba-land-radio
  int dhabaLandRadio = 0;

  void dhabaLandRadioFunc(int value) {
    setState(() {
      dhabaLandRadio = value;
    });
  }

  //dhaba-land-radio

  //dhaba-legal-radio
  int dhabaLegalRadio = 0;

  void dhabaLegalRadioFunc(int value) {
    setState(() {
      dhabaLegalRadio = value;
    });
  }

  //dhaba-legal-radio

  //dhaba-seating-radio
  int dhabaSeatingRadio = 0;

  void dhabaSeatingRadioFunc(int value) {
    setState(() {
      dhabaSeatingRadio = value;
    });
  }

  //dhaba-seating-radio

  //dhaba-UPI-radio
  int dhabaUPIRadio = 0;

  void dhabaUPIRadioFunc(int value) {
    setState(() {
      dhabaUPIRadio = value;
    });
  }

  //dhaba-UPI-radio

  //dhaba-space-radio
  int dhabaSpaceRadio = 0;

  void dhabaSpaceRadioFunc(int value) {
    setState(() {
      dhabaSpaceRadio = value;
    });
  }

  //dhaba-space-radio

  //terms-conditions-dialog
  termsConditionsDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Align(
                              child: Text('Terms & Conditions', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                              alignment: Alignment.center,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: MediaQuery.of(context).size.width / 80,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: GestureDetector(
                                child: Image.asset('images/bg-cross.png', width: 20),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: SingleChildScrollView(
                            child: Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley.',
                              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(102, 87, 244, 1),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(7),
                            ),
                          ),
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //terms-conditions-dialog

  //thank-you-dialog
  thankYouDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 95,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 87,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            child: Image.asset('images/flower.png', width: 120),
                            alignment: Alignment.center,
                          ),
                          Positioned(
                            right: MediaQuery.of(context).size.width / 80,
                            child: GestureDetector(
                              child: Image.asset('images/bg-cross.png', width: 20),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Shukriya sir! Humari',
                            style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(text: ' Myprofit ', style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                              TextSpan(text: 'team jald hi aapke sampark mai aaegi!'),
                            ]),
                      ),
                      SizedBox(height: 12),
                      ButtonTheme(
                        minWidth: 180,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          color: Color.fromRGBO(102, 87, 244, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddDhaba()),
                            );
                          },
                          child: Text(
                            "GO",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //thank-you-dialog

  //date-picker
  final openingDateController = TextEditingController();
  final closingDateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    openingDateController.dispose();
    closingDateController.dispose();
    super.dispose();
  }

  //date-picker

  //checkbox
  bool valuefirst = false;
  bool valuesecond = false;

  //checkbox

  TextEditingController _dhabaIDController = TextEditingController();
  TextEditingController _dhabaNameController = TextEditingController();
  TextEditingController _dhabaOwnerNameController = TextEditingController();
  TextEditingController _aadharNumberController = TextEditingController();
  TextEditingController _mobileNoDhabaOwnerController = TextEditingController();
  TextEditingController _morningSlotController = TextEditingController();
  TextEditingController _eveningSlotController = TextEditingController();
  TextEditingController _truckTrafficController = TextEditingController();
  TextEditingController _netSpeedtestController = TextEditingController();
  TextEditingController _distanceFromBankController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();
  TextEditingController _nearestVillageController = TextEditingController();
  TextEditingController _distanceNearestVillageController = TextEditingController();
  TextEditingController _dalController = TextEditingController();
  TextEditingController _sevTomatoController = TextEditingController();
  TextEditingController _riceController = TextEditingController();
  TextEditingController _chapatiController = TextEditingController();
  TextEditingController _seatingCapacityController = TextEditingController();
  TextEditingController _tryTeachHimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Color.fromRGBO(102, 87, 244, 1),
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
          title: Text('Form 2', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dhaba ID ( for IDR- BOM route, employee A,1st dhaba=IDRBOM-A1)',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                controller: _dhabaIDController,
              ),
              SizedBox(height: 15),
              Text('Dhaba name', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 25,
                controller: _dhabaNameController,
              ),
              SizedBox(height: 15),
              Text('Owner name', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 12,
                controller: _dhabaOwnerNameController,
              ),
              SizedBox(height: 15),
              Text('Aadhar number of Owner', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Align(
                alignment: Alignment.topLeft,
                child: Text('(or any other form of ID)', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 12,
                controller: _aadharNumberController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateAaadharNumber(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Mobile no. of Dhaba owner', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 10,
                controller: _mobileNoDhabaOwnerController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMobile(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Parking area of Dhaba', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaAreaRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaAreaRadioFunc(value as int);
                        }),
                    Text('Small'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaAreaRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaAreaRadioFunc(value as int);
                        }),
                    Text('Medium'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 3,
                        groupValue: dhabaAreaRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaAreaRadioFunc(value as int);
                        }),
                    Text('Big'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('No of working staff in dhaba', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Morning slot',
                        hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLength: 3,
                      controller: _morningSlotController,
                      keyboardType: TextInputType.number,
                      validator: (numb) => Validator.validateEmployee(numb!, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Evening slot',
                        hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      maxLength: 3,
                      controller: _eveningSlotController,
                      keyboardType: TextInputType.number,
                      validator: (numb) => Validator.validateEmployee(numb!, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text('Daily truck traffic at dhaba approximated by owner',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 4,
                controller: _truckTrafficController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateTruckTraffic(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('The time slot for which the dhaba is open now',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: openingDateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Opening timing',
                        hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        openingDateController.text = date.toString().substring(0, 10);
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextFormField(
                      readOnly: true,
                      controller: closingDateController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Closing timing',
                        hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        closingDateController.text = date.toString().substring(0, 10);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text('Internet availability at Dhaba', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaAvailabilityRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaAvailabilityRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaAvailabilityRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaAvailabilityRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text('(Use net speedtest to check net and write speed in mbps/kbps)',
                    style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 10,
                controller: _netSpeedtestController,
              ),
              SizedBox(height: 15),
              Text('Distance from bank', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Align(
                alignment: Alignment.topLeft,
                child: Text('(approximate distance in km)', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 3,
                controller: _distanceFromBankController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateDistanceBank(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('IFSC Code of that bank', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 11,
                controller: _ifscCodeController,
              ),
              SizedBox(height: 15),
              Text('Distance of nearest village with name', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 25,
                controller: _nearestVillageController,
              ),
              SizedBox(height: 15),
              Text('Does the dhaba provide lodging right now?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaLodgingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLodgingRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaLodgingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLodgingRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Land owned by the Dhaba owner or not?', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaLandRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLandRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaLandRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLandRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Land is legal or not?', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Align(
                alignment: Alignment.topLeft,
                child: Text('(see documents)', style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              ),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaLegalRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLegalRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaLegalRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLegalRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Any Dhaba certification', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: dhabaCertificationImage != null
                      ? Image(image: FileImage(dhabaCertificationImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                      : Image(image: AssetImage('images/placeholder.png'), width: double.infinity, height: 150, fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(1, context);
                },
              ),
              SizedBox(height: 15),
              Text('Main mrp of dishes :', style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 15),
              Text('Dal', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 5,
                controller: _dalController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Sev tomato', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 5,
                controller: _sevTomatoController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Rice', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 5,
                controller: _riceController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Chapati', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 5,
                controller: _chapatiController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Seating capacity of Dhaba according to Dhaba owner',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 5,
                controller: _seatingCapacityController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateSeatingCapacity(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Will he increase his seating capacity if required?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaSeatingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaSeatingRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaSeatingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaSeatingRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Does he use UPI?', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaUPIRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaUPIRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaUPIRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaUPIRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              Text('(If not, try to teach him(write issues, if any)',
                  style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  counterText: "",
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
                maxLength: 25,
                controller: _tryTeachHimController,
              ),
              SizedBox(height: 15),
              Text('Does he have space to keep gifts?', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaSpaceRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaSpaceRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaSpaceRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaSpaceRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: this.valuesecond,
                      onChanged: (bool? value) {
                        setState(() {
                          this.valuesecond = value!;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text('Accept all ', style: TextStyle(color: Color(0xff303030), fontSize: 15, fontWeight: FontWeight.w600)),
                        InkWell(
                          child: Text('Terms & Conditions',
                              style: TextStyle(color: Color(0xff6657f4), fontSize: 15, fontWeight: FontWeight.w600, decoration: TextDecoration.underline)),
                          onTap: () {
                            termsConditionsDialog();
                          },
                        ),
                      ],
                    ),
                  ],
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
                    color: Color.fromRGBO(102, 87, 244, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      thankYouDialog();
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

  //image-picker
  showBottomSheet(int imageType, BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  selectImage(1, imageType);
                  Navigator.pop(context);
                },
                child: Text('Camera', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  selectImage(2, imageType);
                  Navigator.pop(context);
                },
                child: Text('Gallery', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Color(0xfff92d28), fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          );
        });
  }

  selectImage(int source, int imageType) async {
    PickedFile pickedFile;
    if (source == 1) {
      // ignore: deprecated_member_use
      pickedFile = (await ImagePicker().getImage(source: ImageSource.camera))!;
    } else {
      // ignore: deprecated_member_use
      pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery))!;
    }

    switch (imageType) {
      case 1:
        dhabaCertificationImage = File(pickedFile.path);
        break;
    }

    setState(() {});
  }
//image-picker
}
