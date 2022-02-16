import 'dart:io';

import 'package:employee/src/ui/form2/form2.dart';
import 'package:employee/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Form1 extends StatefulWidget {
  @override
  _Form1State createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  //image-picker
  File? seatingCapacityImage;
  File? increaseSeatingCapacityImage;
  File? dhabaBoardImage;
  File? parkingLoatImage;
  File? washroomImage;
  File? dhabaWallsImage;

  //image-picker

  //dhaba-availability-radio
  int dhabaAvailabilityRadio = 0;

  void dhabaAvailabilityRadioFunc(int value) {
    setState(() {
      dhabaAvailabilityRadio = value;
    });
  }

  //dhaba-availability-radio

  //dhaba-idea-radio
  int dhabaIdeaRadio = 0;

  void dhabaIdeaRadioFunc(int value) {
    setState(() {
      dhabaIdeaRadio = value;
    });
  }

  //dhaba-idea-radio

  //dhaba-willing-radio
  int dhabaWillingRadio = 0;

  void dhabaWillingRadioFunc(int value) {
    setState(() {
      dhabaWillingRadio = value;
    });
  }

  //dhaba-willing-radio

  //dhaba-rules-radio
  int dhabaRulesRadio = 0;

  void dhabaRulesRadioFunc(int value) {
    setState(() {
      dhabaRulesRadio = value;
    });
  }

  //dhaba-rules-radio

  //dhaba-seating-radio
  int dhabaSeatingRadio = 0;

  void dhabaSeatingRadioFunc(int value) {
    setState(() {
      dhabaSeatingRadio = value;
    });
  }

  //dhaba-seating-radio

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

  //dhaba-UPI-radio
  int dhabaUPIRadio = 0;

  void dhabaUPIRadioFunc(int value) {
    setState(() {
      dhabaUPIRadio = value;
    });
  }
  //dhaba-UPI-radio

  //dhaba-parking-radio
  int dhabaParkingRadio = 0;

  void dhabaParkingRadioFunc(int value) {
    setState(() {
      dhabaParkingRadio = value;
    });
  }
  //dhaba-parking-radio

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

  TextEditingController _dhabaIDController = TextEditingController();
  TextEditingController _dhabaNameController = TextEditingController();
  TextEditingController _dhabaOwnerNameController = TextEditingController();
  TextEditingController _netSpeedtestController = TextEditingController();
  TextEditingController _locationBetweenTollsController = TextEditingController();
  TextEditingController _mobileNoDhabaOwnerController = TextEditingController();
  TextEditingController _tablesChairsController = TextEditingController();
  TextEditingController _seatingCapacityController = TextEditingController();
  TextEditingController _seatingSpaceCapacityController = TextEditingController();
  TextEditingController _truckTrafficController = TextEditingController();
  TextEditingController _noPeopleEatingController = TextEditingController();
  TextEditingController _workersDayShiftController = TextEditingController();
  TextEditingController _workersNightShiftController = TextEditingController();
  TextEditingController _dalController = TextEditingController();
  TextEditingController _sevTomatoController = TextEditingController();
  TextEditingController _riceController = TextEditingController();
  TextEditingController _chapatiController = TextEditingController();
  TextEditingController _tryTeachHimController = TextEditingController();
  TextEditingController _specialFeatureController = TextEditingController();

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
          title: Text('Form 1 - All Dhabas', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
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
              Text('Dhaba name',
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
                maxLength: 25,
                controller: _dhabaNameController,
              ),
              SizedBox(height: 15),
              Text('Affix the google gps location of Dhaba (Section to select the location of dhaba should be given)',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Pick location',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text('Name of Dhaba owner',
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
                maxLength: 25,
                controller: _dhabaOwnerNameController,
              ),
              SizedBox(height: 15),
              Text('Internet availability at Dhaba',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
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
              Text('(Use net speedtest to check net and write speed in mbps/kbps)',
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
                maxLength: 10,
                controller: _netSpeedtestController,
              ),
              SizedBox(height: 15),
              Text('Location between the tolls',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Text('(eg- between toll no.5 and toll no.6)',
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
                controller: _locationBetweenTollsController,
              ),
              SizedBox(height: 15),
              Text('Mobile no of Dhaba owner',
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
                maxLength: 10,
                controller: _mobileNoDhabaOwnerController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMobile(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Reaction of Dhaba owner to idea and collaboration',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaIdeaRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
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
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
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
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaIdeaRadioFunc(value as int);
                        }),
                    Text('C- not interested'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Will he be willing to give 20% in first month and 25% from the second?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaWillingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaWillingRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaWillingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaWillingRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Will he be willing to comply to company rules?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaRulesRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaRulesRadioFunc(value as int);
                        }),
                    Text('Yes'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaRulesRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaRulesRadioFunc(value as int);
                        }),
                    Text('No'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('No of tables and chairs in Dhaba',
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
                maxLength: 25,
                controller: _tablesChairsController,
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
              Text('Is there space to increase seating capacity?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Text('(Employee’s judgement)',
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
                controller: _seatingSpaceCapacityController,
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
              Text('No of people eating food of atleast 100rs/ drinking only chai/ not spending much money',
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
                maxLength: 25,
                controller: _noPeopleEatingController,
              ),
              SizedBox(height: 15),
              Text('Timings of Dhaba',
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
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
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
                        hintStyle:
                            TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
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
              Text('Workers in day shift',
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
                maxLength: 3,
                controller: _workersDayShiftController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateEmployee(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Workers at night shift',
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
                maxLength: 3,
                controller: _workersNightShiftController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateEmployee(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Lodging facility available or not?',
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
                    Text('Available'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaLodgingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLodgingRadioFunc(value as int);
                        }),
                    Text('Not Available'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Main mrp of dishes :',
                  style: TextStyle(color: Color.fromRGBO(102, 87, 244, 1), fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(height: 15),
              Text('Dal',
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
                controller: _dalController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Sev tomato',
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
                controller: _sevTomatoController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Rice',
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
                controller: _riceController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Chapati',
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
                controller: _chapatiController,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMainMrp(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              SizedBox(height: 15),
              Text('Land ownership or not?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
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
                    Text('Owned'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaLandRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaLandRadioFunc(value as int);
                        }),
                    Text('Rented'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Land legal or not?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
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
              Text('Does he use UPI?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
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
              Text('(If not, try to teach him( write issues, if any)',
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
              Text('Parking area of Dhaba',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Container(
                transform: Matrix4.translationValues(-10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 1,
                        groupValue: dhabaParkingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaParkingRadioFunc(value as int);
                        }),
                    Text('Small'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 2,
                        groupValue: dhabaParkingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaParkingRadioFunc(value as int);
                        }),
                    Text('Medium'),
                    Radio(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: 3,
                        groupValue: dhabaParkingRadio,
                        activeColor: Color.fromRGBO(102, 87, 244, 1),
                        onChanged: (value) {
                          dhabaParkingRadioFunc(value as int);
                        }),
                    Text('Big'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('Photo of seating capacity',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: seatingCapacityImage != null
                      ? Image(
                          image: FileImage(seatingCapacityImage!),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(1, context);
                },
              ),
              SizedBox(height: 15),
              Text('Photo of space to increase seating capacity',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: increaseSeatingCapacityImage != null
                      ? Image(
                          image: FileImage(increaseSeatingCapacityImage!),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(2, context);
                },
              ),
              SizedBox(height: 15),
              Text('Photo of dhaba name board',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: dhabaBoardImage != null
                      ? Image(
                          image: FileImage(dhabaBoardImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(3, context);
                },
              ),
              SizedBox(height: 15),
              Text('Photo of parking lot',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: parkingLoatImage != null
                      ? Image(
                          image: FileImage(parkingLoatImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(4, context);
                },
              ),
              SizedBox(height: 15),
              Text('Photo of washroom',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: washroomImage != null
                      ? Image(image: FileImage(washroomImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(5, context);
                },
              ),
              SizedBox(height: 15),
              Text('Photo of Dhaba walls interior',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: dhabaWallsImage != null
                      ? Image(
                          image: FileImage(dhabaWallsImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                      : Image(
                          image: AssetImage('images/placeholder.png'),
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover),
                ),
                onTap: () {
                  showBottomSheet(6, context);
                },
              ),
              SizedBox(height: 15),
              Text('Any special feature of Dhaba which gives it an edge?',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              Text('(like if the dhaba owner is sarpanch or has any political connections)',
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
                controller: _specialFeatureController,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Form2()),
                      );
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
                child:
                    Text('Gallery', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  Text('Cancel', style: TextStyle(color: Color(0xfff92d28), fontSize: 16, fontWeight: FontWeight.w600)),
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
        seatingCapacityImage = File(pickedFile.path);
        break;
      case 2:
        increaseSeatingCapacityImage = File(pickedFile.path);
        break;
      case 3:
        dhabaBoardImage = File(pickedFile.path);
        break;
      case 4:
        parkingLoatImage = File(pickedFile.path);
        break;
      case 5:
        washroomImage = File(pickedFile.path);
        break;
      case 6:
        dhabaWallsImage = File(pickedFile.path);
        break;
    }

    setState(() {});
  }
//image-picker
}
