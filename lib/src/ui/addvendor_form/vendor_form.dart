import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:day_picker/day_picker.dart';
import 'package:employee/model/add_chat_papdi.dart';
import 'package:employee/model/addvendor_form.dart';
import 'package:employee/model/categories_respnse.dart';
import 'package:employee/model/custome_textfeild.dart';
import 'package:employee/model/get_all_state_response.dart';
import 'package:employee/model/getcity_by_state_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/added_vendor_list/added_vendor_list.dart';
import 'package:employee/src/ui/addvendor_form/form.dart';
import 'package:employee/src/ui/home/home.dart';
import 'package:employee/src/ui/map/google_maps.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../model/add_vendor_otp.dart';
import '../../../model/get_state_city_bypincode.dart';

class VendorForm extends StatefulWidget {
  final int? id;
  final String? title;
  // final double? lat;
  // final double? long;

  const VendorForm({Key? key, this.id, this.title}) : super(key: key);

  @override
  _VendorFormState createState() => _VendorFormState();
}

//select-category
class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}
//select-category

class _VendorFormState extends State<VendorForm> {
  CategoriesResponse? result;
  File? image;
  Uint8List? data;
  ui.Image? imageData;
  AddVendorResponse? saveVendordetail;
  ChatPapdiResponse? savechatdetail;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, initialDate: currentDate, firstDate: DateTime(2015), lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    setState(() {
      log("message=>$pickedDate");
      _startday.text = currentDate.weekday.toString();
    });
  }

  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? pickedDate1 = await showDatePicker(
        context: context, initialDate: currentDate, firstDate: DateTime(2015), lastDate: DateTime(2050));
    if (pickedDate1 != null && pickedDate1 != currentDate)
      setState(() {
        currentDate = pickedDate1;
      });
    setState(() {
      log("message=>$pickedDate1");
      _startday.text = currentDate.day.toString();
    });
  }

  getCategories() async {
    result = await ApiProvider().getCategoriess();
    print(result);
    CategoriesResponseData? data;
    CategoriesResponseData? data1;
    result!.data!.forEach((element) {
      if (element.id == widget.id) {
        log("====>${element.categoryName}");
        data = element;
        // result!.data!.remove(element);
        // subcatlist.add(SubCat(element));
      }
      if (element.id == 0) {
        log("====>${element.categoryName}");
        data1 = element;
        // result!.data!.remove(element);
        // subcatlist.add(SubCat(element));
      }
    });
    if (data != null) {
      result!.data!.remove(data);
    }
    if (data != null) {
      result!.data!.remove(data1);
    }
    setState(() {});
    // return result!.data!;
  }

  String searchText = "";
  bool searching = false;

  List<GetAllStateResponseData> loginData = [];
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  var devicewidth, deviceheight;

  //image-picker
  File? myProfitBoardImage;
  File? validationShopImage;
  //image-picker
  List<double> sub = [];
  //checkbox
  bool valuefirst = false;
  bool valuesecond = false;
  //checkbox
  double? lat, lng;
  TextEditingController _shopname = TextEditingController();
  TextEditingController _ownername = TextEditingController();
  TextEditingController _otp = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _comission = TextEditingController();
  TextEditingController _openingtime = TextEditingController();
  TextEditingController _closingtime = TextEditingController();
  TextEditingController _startday = TextEditingController();
  TextEditingController _endday = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  TextEditingController _state = TextEditingController();
  TextEditingController edtSearch = TextEditingController();

  List<UserForm?> users = [];
  User user = User();

  List<GetAllCityByStateResponseData> cityList = [];
  List<String>? selecteddays;
  List<DayInWeek> _days = [
    DayInWeek(
      "Sun",
    ),
    DayInWeek("Mon", isSelected: true),
    DayInWeek(
      "Tue",
    ),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
  ];
  List<SubCat> subcatlist = [];
  //api calling
  addChatPapdi() async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_shopname.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Shop Name");
      } else if (_comission.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Comission");
      } else if (_ownername.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Owner Name");
      } else if (_mobile.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Owner Mobile Number");
      } else if (_mobile.text.length != 10) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Valid Mobile Number");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Shop Address");
      } else if (lat == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Locator from map in Address Textfeild ");
      } else if (_pincode.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Pincode");
      } else if (_pincode.text.length != 6) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Valid Pincode");
      } else if (_state.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Shop State");
      } else if (_city.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Shop City");
      } else if (valuesecond == false) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Term and Condition");
      } else if (validationShopImage == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Upload Document First");
      } else if (imageData == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please do Signature in Terms and Condition");
      } else {
        final ChatPapdiResponse loginData = await ApiProvider().addChatPapdi(
            0,
            _shopname.text,
            _ownername.text,
            _comission.text,
            _mobile.text,
            _address.text,
            _landmark.text,
            cityid,
            stateid,
            _pincode.text,
            lat,
            lng,
            data,
            validationShopImage!);
        log("ooooo ${loginData}");
        log("ooooo ${comiisionarray}");
        log("ooooo ${arr}");
        if (loginData.success == true) {
          savechatdetail = loginData;
          // Fluttertoast.showToast(msg: "${saveVendordetail!.message}");
          _displayDialog(context, _mobile.text, 0);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => AddedVendor(title: widget.title!, id: widget.id!)),
          //     (Route<dynamic> route) => false);
          Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Added Sucsessfully");
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false ? loginData.message : "Thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on the internet");
    }
  }

//api calling
  addVendors() async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_shopname.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Shop Name");
      } else if (_comission.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Comission");
      } else if (_ownername.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Owner Name");
      } else if (_mobile.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Owner Mobile Number");
      } else if (_mobile.text.length != 10) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Valid Mobile Number");
      } else if (_openingtime.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please select opening time");
      } else if (_closingtime.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please select close time");
      } else if (selecteddays!.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please select opening shop days");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Shop Address");
      } else if (lat == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Locator from map in Address Textfeild ");
      } else if (_pincode.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Pincode");
      } else if (_pincode.text.length != 6) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Valid Pincode");
      } else if (_state.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Shop State");
      } else if (_city.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Shop City");
      } else if (valuesecond == false) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Select Term and Condition");
      } else if (imageData == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please do Signature in Terms and Condition");
      } else if (validationShopImage == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Upload Document First");
      } else if (subcatlist.isNotEmpty) {
        String savelist = "";

        for (int i = 0; i < subcatlist.length; i++) {
          if (subcatlist[i].subController.text.isEmpty) {
            Fluttertoast.showToast(
                backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter Other Categories Comission");
            savelist = "";
            break;
          } else {
            if (i == subcatlist.length - 1) {
              log("comiision====>${double.parse(subcatlist[i].subController.text.trim().toString())}");
              savelist = savelist + subcatlist[i].subController.text.trim();
            } else {
              log("comiision====>${subcatlist[i].subController.text.trim()}");
              savelist = savelist + subcatlist[i].subController.text.trim() + ",";
            }
          }
        }

        if (savelist.isNotEmpty) {
          log("ooooo1 }");
          final AddVendorResponse loginData = await ApiProvider().addVendor(
              "${widget.id}",
              _shopname.text,
              _ownername.text,
              _comission.text,
              _mobile.text,
              _address.text,
              _landmark.text,
              cityid,
              stateid,
              _pincode.text,
              lat,
              lng,
              data,
              validationShopImage!,
              arr,
              savelist,
              _openingtime.text,
              _closingtime.text,
              selecteddays!,
              customedata);
          // log("ooooo ${loginData.data!.categoryType}");
          // log("ooooo ${loginData.data!.ownerMobile}");
          // log("ooooo ${savelist}");
          // log("ooooo ${arr}");
          if (loginData.success == true) {
            saveVendordetail = loginData;
            // Fluttertoast.showToast(msg: "${saveVendordetail!.message}");
            _displayDialog(context, _mobile.text, 1);
          } else {
            log("ooooo2 }");
            Fluttertoast.showToast(
                backgroundColor: ColorPrimary,
                textColor: Colors.white,
                msg: loginData.success == false ? loginData.message : "loginData.message"
                // timeInSecForIos: 3
                );
          }
        }
      } else {
        final AddVendorResponse loginData = await ApiProvider().addVendor(
            "${widget.id}",
            _shopname.text,
            _ownername.text,
            _comission.text,
            _mobile.text,
            _address.text,
            _landmark.text,
            cityid,
            stateid,
            _pincode.text,
            lat,
            lng,
            data,
            validationShopImage!,
            arr,
            comiisionarray,
            _openingtime.text,
            _closingtime.text,
            selecteddays!,
            customedata);
        log("ooooo ${loginData}");
        log("ooooo ${comiisionarray}");
        log("ooooo ${arr}");
        if (loginData.success == true) {
          saveVendordetail = loginData;
          // Fluttertoast.showToast(msg: "${saveVendordetail!.message}");
          _displayDialog(context, _mobile.text, 1);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => AddedVendor(title: widget.title!, id: widget.id!)),
          //     (Route<dynamic> route) => false);
          Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Added Sucsessfully");
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false ? loginData.message : "Thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on the internet");
    }
  }
//bottom sheet

  //terms-conditions-dialog
  termsConditionsDialog() {
    // _signaturePadKey.currentWidget.
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          //Image? signature;
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
                  child: Column(children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Align(
                            child: Text('Terms & Conditions',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
                            alignment: Alignment.center,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: MediaQuery.of(context).size.width / 80,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                    Container(
                      // height: 200,
                      width: 300,
                      child: SignPad(data: data, imageData: imageData, signaturePadKey: _signaturePadKey),
                    ),
                    InkWell(
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          decoration: BoxDecoration(
                            color: ColorPrimary,
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
                        onTap: () async {
                          if (_signaturePadKey.currentState != null) {
                            log("${_signaturePadKey.currentState!.toPathList().length}");
                            if (_signaturePadKey.currentState!.toPathList().length != 0) {
                              _handleSaveButtonPressed();
                            } else {
                              Fluttertoast.showToast(msg: "Please do valid Signature", backgroundColor: ColorPrimary);
                            }
                          } else {
                            Navigator.pop(context);
                          }
                        }),
                  ]),
                ),
              ],
            ),
          );
        });
  }

  //terms-conditions-dialog
  Future<void> _handleSaveButtonPressed() async {
    // final ui.Image
    imageData = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes = await imageData!.toByteData(format: ui.ImageByteFormat.png);
    if (bytes != null) {
      data = bytes.buffer.asUint8List();
      //log("data   ${data}");
      image = File.fromRawPath(data!);
      //log("patj>>>${image!.path}");
      log("name   ${image!.length()}");
      // File(carData['image'])
    }
    Navigator.pop(context);
  }

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
                            style: TextStyle(
                                color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: ' Myprofit ',
                                  style: TextStyle(color: ColorPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                              TextSpan(text: 'team jald hi aapke sampark mai aaegi!'),
                            ]),
                      ),
                      SizedBox(height: 12),
                      ButtonTheme(
                        minWidth: 180,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                          color: ColorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          onTab: () {},
                                        )),
                                (Route<dynamic> route) => false);
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

  //select-category
  var placeholderText = "Select Other Categories";
  String cityid = "";
  var stateid;
  String arr = "";
  String comiisionarray = "";
  String commission = "";
  List<Map<String, String>> customedata = [];
  //List<Animal> _selectedAnimals = [];
  // List<Category> _selectedCategory2 = [];
  List<CategoriesResponseData?> _selectedCategory3 = [];

  //List<Animal> _selectedCategory4 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  var result1;
  @override
  void initState() {
    super.initState();
    getCategories();
    getStateId(101);
    super.initState();

    // getCityId(21);
  }

  GetAllStateResponse? getData;
  GetAllStateCityByPincodeResponse? getcitystate;
  List<GetAllStateResponseData> stateData = [];
  List<GetAllStateCityByPincodeData> statePincodeData = [];

  Future<List<GetAllStateResponseData>> getStateId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${id}");
      getData = await ApiProvider().getState(id);
      if (getData!.success) {
        stateData = getData!.data!;

        log("ggg ${stateData}");
      }
    } else {
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    return stateData;
    //_tap = true;
  }

  Future<List<GetAllStateCityByPincodeData>> getStateCityIdByPincode(pincode) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${pincode}");
      getcitystate = await ApiProvider().getStatebypincode(pincode);

      if (getcitystate!.success) {
        statePincodeData = getcitystate!.data!;
        _city.text = statePincodeData[0].cityName.toString();
        cityid = statePincodeData[0].cityId.toString();
        _state.text = statePincodeData[0].stateName.toString();
        stateid = statePincodeData[0].stateId.toString();

        log("ggg ${statePincodeData}");
        setState(() {});
      } else {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "${getcitystate!.message}");
      }
    } else {
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    return statePincodeData;
    //_tap = true;
  }

  List<GetAllCityByStateResponseData> citydata = [];
  Future<List<GetAllCityByStateResponseData>> getCityId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${id}");
      GetAllCityByStateResponse getData = await ApiProvider().getCityByState(id);
      if (getData.success) {
        citydata = getData.data!;

        log("ggg ${citydata}");
      }
    } else {
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    return citydata;
    //_tap = true;
  }

  //select-category

  @override
  Widget build(BuildContext context) {
    devicewidth = MediaQuery.of(context).size.width;
    deviceheight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
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
              title: Text('${widget.title} Form', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              centerTitle: true,
            ),
            body: StreamBuilder(builder: (context, snapshot) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name of Shop *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _shopname,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[[a-zA-Z0-9 ]')),
                        ],
                        autofocus: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //autovalidate: true,
                        maxLength: 40,

                        // keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),

                      SizedBox(height: 15),
                      Text(' Comission on ${widget.title} *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Row(children: [
                        Container(
                          width: devicewidth * 0.40,
                          child: TextFormField(
                            cursorColor: ColorPrimary,
                            controller: _comission,
                            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                            ],

                            autovalidateMode: AutovalidateMode.onUserInteraction,

                            //autovalidate: true,
                            maxLength: 5,
                            autofocus: false,
                            // keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              fillColor: Color.fromRGBO(242, 242, 242, 1),
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: ColorPrimary, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "images/percentage.png",
                          scale: 4,
                        )
                      ]),
                      SizedBox(
                        height: 15,
                      ),
                      Text('Name of Owner *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _ownername,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //autovalidate: true,
                        maxLength: 40,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text('Mobile Number  *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _mobile,
                        keyboardType: TextInputType.number,
                        validator: (numb) => Validator.validateMobile(numb!, context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 10,
                        autofocus: false,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text('Timings of Shop *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      Row(children: [
                        Container(
                          width: devicewidth * 0.43,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () {
                              _selectTime(context);
                            },
                            controller: _openingtime,
                            maxLength: 10,
                            autofocus: false,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              fillColor: Color.fromRGBO(242, 242, 242, 1),
                              hintText: 'Opening timing',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: ColorPrimary, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: devicewidth * 0.42,
                          child: TextFormField(
                            cursorColor: ColorPrimary,
                            controller: _closingtime,
                            readOnly: true,
                            onTap: () {
                              _selectTime1(context);
                            },
                            maxLength: 10,
                            autofocus: false,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              fillColor: Color.fromRGBO(242, 242, 242, 1),
                              hintText: 'Closing timing',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: ColorPrimary, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 20),
                      Text('Working Days',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectWeekDays(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          days: _days,
                          border: false,
                          daysFillColor: ColorPrimary,
                          backgroundColor: ColorPrimary,
                          selectedDayTextColor: Colors.white,
                          daysBorderColor: Colors.grey,
                          unSelectedDayTextColor: Colors.black,
                          boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              colors: [Colors.white10, Colors.white10],
                              tileMode: TileMode.repeated, // repeats the gradient over the canvas
                            ),
                          ),
                          onSelect: (values) {
                            // <== Callback to handle the selected days
                            print(values);
                            selecteddays = values;
                            log("===>$selecteddays}");
                          },
                        ),
                      ),

                      Text('Address of Shop *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _address,
                        maxLength: 40,
                        autofocus: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9'\.\-\s\,\\\/]")),
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          suffixIcon: Container(
                            width: 120,
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              lat == null
                                  ? Text(
                                      "Select location",
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 2,
                                    )
                                  : Text(
                                      "location ${lat!.toStringAsFixed(2)}",
                                      style: TextStyle(fontSize: 10),
                                      maxLines: 2,
                                    ),
                              IconButton(
                                onPressed: () async {
                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  result1 = await Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => GoogleMapScreen()));
                                  log("result ${result1}");
                                  if (result1 != null) {
                                    //Map location = result as Map;
                                    lat = result1["lat"];
                                    lng = result1["long"];
                                    //  Fluttertoast.showToast(msg: "$lat");
                                    log("result1---->${lat}");
                                  }
                                },
                                icon: Icon(
                                  Icons.add_location,
                                  color: lat == null ? ColorPrimary : Colors.green,
                                ),
                                tooltip: "Select location",
                              ),
                            ]),
                          ),
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintText: 'Enter Shop Address',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _landmark,
                        autofocus: false,
                        maxLength: 40,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r"[a-z A-Z,.\-]")),
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          counterText: "",
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintText: 'Enter Landmark (optional)',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        cursorColor: ColorPrimary,
                        controller: _pincode,
                        keyboardType: TextInputType.number,
                        validator: (numb) => Validator.validatePincode(numb!, context),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onChanged: ((texts) {
                          if (texts.length == 6) {
                            getStateCityIdByPincode(_pincode.text);
                          }
                        }),
                        maxLength: 6,
                        autofocus: false,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintText: 'Pincode',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(height: 10),

                      TextFormField(
                        // enableInteractiveSelection: false,
                        readOnly: true,
                        onTap: () {
                          log("${stateData.length}");

                          showModalBottomSheet(
                            enableDrag: true,
                            isDismissible: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                            ),
                            context: context,
                            builder: (context) {
                              return IntrinsicHeight(
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.40,
                                  padding: EdgeInsets.only(top: 20, bottom: 0),
                                  child: Column(children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: stateData.length,
                                          itemBuilder: (BuildContext ctxt, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    log("==?${_state.text}");
                                                    log("===?${stateData[index].statename}");
                                                    if (_state.text == stateData[index].statename) {
                                                      log("${_state.text}");
                                                      log("${stateData[index].statename}");
                                                    } else {
                                                      _city.clear();
                                                      cityid = "";
                                                      _pincode.clear();
                                                    }
                                                  });

                                                  getCityId(stateData[index].id);
                                                  _state.text = stateData[index].statename;
                                                  stateid = stateData[index].id.toString();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    height: 30,
                                                    child: Text("${stateData[index].statename.toUpperCase()}")),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      // height: 15,
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        elevation: 5,
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.red, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ]),
                                ),
                              );
                            },
                          );
                        },
                        controller: _state,
                        autofocus: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: ColorPrimary),
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          hintText: 'Select State',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        onTap: () {
                          log("${citydata.length}");

                          if (citydata.length > 0) {
                            _showModal(context, citydata);
                          } else if (_city.text.isNotEmpty) {
                          } else {
                            Fluttertoast.showToast(msg: "Select State from above list", backgroundColor: ColorPrimary);
                          }
                        },
                        controller: _city,
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          suffixIcon: Icon(Icons.keyboard_arrow_down, color: ColorPrimary),
                          fillColor: Color.fromRGBO(242, 242, 242, 1),
                          counterText: "",
                          hintText: 'Select Your City/Village',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        ),
                      ),

                      SizedBox(height: 15),
                      widget.id == 0
                          ? Container(
                              height: 0,
                            )
                          : AutoSizeText(
                              'Other Categories (If exists)',
                              style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontWeight: FontWeight.w600),
                              maxFontSize: 15,
                              minFontSize: 10,
                            ),
                      widget.id == 0
                          ? Container(
                              height: 0,
                            )
                          : SizedBox(height: 10),

                      widget.id == 0
                          ? Container(
                              height: 0,
                            )
                          : SizedBox(height: 15),

                      GestureDetector(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: widget.id == 0
                            ? Container(
                                height: 0,
                              )
                            : Container(
                                child: result == null
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: ColorPrimary,
                                      ))
                                    :
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       FocusScopeNode currentFocus =
                                    //           FocusScope.of(context);
                                    //       if (!currentFocus.hasPrimaryFocus) {
                                    //         currentFocus.unfocus();
                                    //       }
                                    //     },
                                    //     child:
                                    Container(
                                        // width: devicewidth - 30,
                                        child: MultiSelectDialogField<CategoriesResponseData?>(
                                          buttonIcon: Icon(Icons.keyboard_arrow_down, color: ColorPrimary),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(width: 1, color: Colors.grey)),

                                          key: _multiSelectKey,
                                          // initialChildSize: 0.7,
                                          // maxChildSize: 0.95,
                                          title: GestureDetector(
                                            onTap: () {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              Navigator.pop(context);
                                            },
                                            child: Text('Other categories',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
                                          ),
                                          buttonText: Text(placeholderText,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(85, 85, 85, 1),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600)),
                                          searchTextStyle:
                                              TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                                          cancelText: Text('Cancel',
                                              style: TextStyle(
                                                  color: ColorPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                                          confirmText: Text('Ok',
                                              style: TextStyle(
                                                  color: ColorPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                                          items: result!.data!
                                              .map((category) => MultiSelectItem<CategoriesResponseData>(
                                                  category, category.categoryName))
                                              .toList(),
                                          searchable: true,
                                          initialValue: subcatlist.map((e) => e.subCat).toList(),

                                          validator: (values) {
                                            if (values == null || values.isEmpty) {
                                              return "";
                                            }
                                            List<String> names = values.map((e) => e!.categoryName).toList();

                                            if (names.contains("Frog")) {
                                              return "Frogs are weird!";
                                            }
                                            return null;
                                          },
                                          onConfirm: (values) {
                                            // SystemChannels.textInput.invokeMethod('TextInput.hide');
                                            // SystemChannels.textInput
                                            //     .invokeMethod('TextInput.hide');
                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            setState(() {
                                              _selectedCategory3 = values;
                                              placeholderText = "";
                                              subcatlist.clear();
                                              if (values.length == 0) {
                                                placeholderText = "Select Category";
                                              } else {
                                                for (int i = 0; i < values.length; i++) {
                                                  if (i == values.length - 1) {
                                                    placeholderText = "Select Category";
                                                    arr = arr + values[i]!.id.toString();
                                                  } else {
                                                    arr = arr + (values[i]!.id.toString()) + ",";
                                                  }
                                                  log("arr===>$arr");
                                                  subcatlist.add(SubCat(values[i]!));
                                                }
                                              }
                                            });
                                            _multiSelectKey.currentState!.validate();
                                          },
                                          chipDisplay: MultiSelectChipDisplay(
                                            onTap: (item) {
                                              FocusScopeNode currentFocus = FocusScope.of(context);
                                              if (!currentFocus.hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              setState(() {
                                                _selectedCategory3.remove(item);
                                                log("dddd ${item}");
                                              });
                                              _multiSelectKey.currentState!.validate();
                                            },
                                          )..disabled = true,
                                          //  );
                                          // }
                                        ),
                                      ),
                                //),
                              ),
                      ),
                      Column(
                          children: List.generate(subcatlist.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            cursorColor: ColorPrimary,
                            keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
                            ],
                            maxLength: 5,
                            controller: subcatlist[index].subController,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              fillColor: Color.fromRGBO(242, 242, 242, 1),
                              hintText: 'Enter ${subcatlist[index].subCat.categoryName} Commision',
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: ColorPrimary, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                            ),
                          ),
                        );
                      })),

                      SizedBox(height: 15),
                      // Text('Photo of the place where MyProfit board is to be placed',
                      //     style: TextStyle(
                      //         color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      // SizedBox(height: 10),
                      // InkWell(
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: myProfitBoardImage != null
                      //         ? Image(
                      //             image: FileImage(myProfitBoardImage!),
                      //             width: double.infinity,
                      //             height: 150,
                      //             fit: BoxFit.cover)
                      //         : Image(
                      //             image: AssetImage('images/placeholder.png'),
                      //             width: double.infinity,
                      //             height: 150,
                      //             fit: BoxFit.cover),
                      //   ),
                      //   onTap: () {
                      //     showBottomSheet(5, context);
                      //   },
                      // ),
                      // SizedBox(height: 15),
                      Text('Documents for validation of Shop *',
                          style: TextStyle(
                              color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                      SizedBox(height: 10),
                      InkWell(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: validationShopImage != null
                                ? Image(
                                    image: FileImage(validationShopImage!),
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.contain)
                                : Image(
                                    image: AssetImage('images/placeholder.png'),
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover),
                          ),
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            log("$validationShopImage");

                            showBottomSheet(2, context);
                          }),
                      //     Container(
                      //       child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // children: [
                      //   Container(
                      //     width: double.infinity,
                      //     height: MediaQuery.of(context).size.height - 80,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(7),
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Stack(
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      //               child: Align(
                      //                 child: Text('Terms & Conditions',
                      //                     style: TextStyle(
                      //                         color: Colors.black,
                      //                         fontSize: 16,
                      //                         fontWeight: FontWeight.w600)),
                      //                 alignment: Alignment.center,
                      //               ),
                      //             ),
                      //             Positioned(
                      //               top: 10,
                      //               right: MediaQuery.of(context).size.width / 80,
                      //               child: Padding(
                      //                 padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      //                 child: GestureDetector(
                      //                   child: Image.asset('images/bg-cross.png',
                      //                       width: 20),
                      //                   onTap: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 12),
                      //         Expanded(
                      //           child: Padding(
                      //             padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      //             child: SingleChildScrollView(
                      //               child: Text(
                      //                 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley.',
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 14,
                      //                     fontWeight: FontWeight.w400),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Container(
                      //             margin: EdgeInsets.all(10),
                      //             // height: 300,
                      //             // width: devicewidth,
                      //             decoration: BoxDecoration(
                      //                 border: Border.all(width: 1),
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 color: Colors.white54),
                      //             child: Column(children: [
                      //               Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceEvenly,
                      //                   children: [
                      //                     Text('Signature',
                      //                         style: TextStyle(
                      //                             color: Colors.black,
                      //                             fontSize: 16,
                      //                             fontWeight: FontWeight.w600)),
                      //                     GestureDetector(
                      //                       onTap: () {
                      //                         _signaturePadKey.currentState!.clear();
                      //                       },
                      //                       child: Text('Clear',
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 16,
                      //                               fontWeight: FontWeight.w600)),
                      //                     ),
                      //                   ]),
                      //               Container(
                      //                 height: 180,
                      //                 width: 300,
                      //                 child: SfSignaturePad(
                      //                   backgroundColor: Colors.transparent,
                      //                   key: _signaturePadKey,
                      //                 ),
                      //               ),
                      //             ])),
                      //         InkWell(
                      //             child: Container(
                      //               width: double.infinity,
                      //               alignment: Alignment.center,
                      //               padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      //               decoration: BoxDecoration(
                      //                 color: ColorPrimary,
                      //                 borderRadius: BorderRadius.only(
                      //                   bottomLeft: Radius.circular(7),
                      //                   bottomRight: Radius.circular(7),
                      //                 ),
                      //               ),
                      //               child: Text(
                      //                 "Done",
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontSize: 16,
                      //                     fontWeight: FontWeight.w600),
                      //               ),
                      //             ),
                      //             onTap: () async {
                      //               _handleSaveButtonPressed();
                      //             }),
                      //       ],
                      //     ),
                      //   ),
                      // ],
                      //     ),),
                      // MaterialButton(
                      //   child: Text('Add entries'),
                      //   onPressed: () async {
                      //     List<PersonEntry> persons = await Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => _onDone(),
                      //       ),
                      //     );
                      //     if (persons != null) persons.forEach(print);
                      //   },
                      // ),

                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 30,
                          width: 130,
                          //padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorPrimary,
                          ),
                          child: Center(
                            child: InkWell(
                              child: Text('Add Custom Field',
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              onTap: () => setState(() {
                                log("");
                                onAddForm();
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      users.length != 0
                          ? Container(
                              height: 145 * double.parse(users.length.toString()),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                addAutomaticKeepAlives: true,
                                itemCount: users.length,
                                itemBuilder: (_, i) => users[i]!,
                              ),
                            )
                          : Text(""),

                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: MaterialButton(
                      //       child: Text('remove new'),
                      //       onPressed: () {
                      //         setState(() {
                      //           onDelete();
                      //         });
                      //       }),
                      // ),
                      Container(
                        transform: Matrix4.translationValues(-10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              activeColor: ColorPrimary,
                              value: this.valuesecond,
                              onChanged: (bool? value) {
                                setState(() {
                                  this.valuesecond = value!;
                                  FocusScope.of(context).unfocus();
                                });
                              },
                            ),
                            Row(
                              children: [
                                Text('Accept all ',
                                    style:
                                        TextStyle(color: Color(0xff303030), fontSize: 15, fontWeight: FontWeight.w600)),
                                InkWell(
                                  child: Text('Terms & Conditions',
                                      style: TextStyle(
                                          color: ColorPrimary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline)),
                                  onTap: () {
                                    log("img ${data}");
                                    FocusScope.of(context).unfocus();
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
                          minWidth: MediaQuery.of(context).size.width,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            color: ColorPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onPressed: () {
                              customedata.clear();
                              for (int i = 0; users.length > i; i++) {
                                log("'name kai---->${users[i]!.user.title}");
                                log("value kai---->${users[i]!.user.description}");
                                customedata.add({
                                  '"name"': '"${(users[i]!.user.title).toString()}"',
                                  '"value"': '"${(users[i]!.user.description).toString()}"'
                                });
                              }
                              log("${imageData.toString()}");
                              if (widget.id == 0) {
                                addChatPapdi();
                              } else {
                                addVendors();
                              }
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
              );
            }),
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
      helpText: " select shop open time",
    );

    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        DateTime tempDate =
            DateFormat("hh:mm").parse(selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
        var dateFormat = DateFormat("h:mm a"); // you can change the format here
        print(dateFormat.format(tempDate));

        log("${selectedTime.hour}:${selectedTime.minute}");
        _openingtime.text = dateFormat.format(tempDate);
      });
    }
  }

  _selectTime1(BuildContext context) async {
    final TimeOfDay? timeOfDay1 = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial,
        helpText: " select shop close time");
    if (timeOfDay1 != null && timeOfDay1 != selectedTime) {
      setState(() {
        selectedTime = timeOfDay1;
        log("${selectedTime.hour}:${selectedTime.minute}");
        DateTime tempDate =
            DateFormat("hh:mm").parse(selectedTime.hour.toString() + ":" + selectedTime.minute.toString());
        var dateFormat = DateFormat("h:mm a"); // you can change the format here
        print(dateFormat.format(tempDate));

        log("${selectedTime.hour}:${selectedTime.minute}");
        _closingtime.text = dateFormat.format(tempDate);
      });
    }
  }

  void _showModal(context, List<GetAllCityByStateResponseData> citydata) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return CityBottomSheet(
          citydata: citydata,
          onSelect: (GetAllCityByStateResponseData city) {
            log("${_city.text}");
            log("${city.cityName}");
            if (_city.text == city.cityName) {
            } else {
              _pincode.clear();
            }
            _city.text = city.cityName;
            cityid = city.id.toString();
          },
        );
      },
    );
  }

  // List<GetAllCityByStateResponseData> _buildSearchList(String userSearchTerm) {
  //   List<GetAllCityByStateResponseData> _searchList = [];

  //   for (int i = 0; i < citydata.length; i++) {
  //     String name = citydata[i].name;
  //     if (name.toLowerCase().contains(userSearchTerm.toLowerCase())) {
  //       _searchList.add(citydata[i]);
  //     } else {
  //       Text("ju");
  //     }
  //   }
  //   return _searchList;
  // }

//192.168.10.62
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
                // Navigator.pop(context);
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
      pickedFile = (await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 70))!;
    } else {
      // ignore: deprecated_member_use
      pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery, imageQuality: 70))!;
    }

    switch (imageType) {
      case 1:
        myProfitBoardImage = File(pickedFile.path);
        break;
      case 2:
        validationShopImage = File(pickedFile.path);
        break;
    }
    log("$imageType");
    setState(() {});
  }

  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it!.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  void onAddForm() {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }
//image-picker

  _displayDialog(BuildContext context, mobile, status) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: RichText(
                text: TextSpan(
                  text: "OTP Verification\n",
                  style: GoogleFonts.openSans(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "Please verify your OTP on ${mobile}",
                      style: GoogleFonts.openSans(
                        fontSize: 14.0,
                        color: ColorTextPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              content: TextField(
                controller: _otp,
                maxLength: 4,
                cursorColor: ColorPrimary,
                keyboardType: TextInputType.number,
                //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  // fillColor: Colors.black,
                  counterText: "",
                  hintText: "Enter OTP",
                  hintStyle: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                  ),
                  contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorPrimary, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              actions: <Widget>[
                Center(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: ColorPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      if (status == 1) {
                        registerVendorOtpCall(saveVendordetail!.data!.vendorId.toString(), _otp.text);
                      } else {
                        registerVendorOtpCall(savechatdetail!.data!.vendorId.toString(), _otp.text);
                      }
                    },
                    child: new Text(
                      "Verify",
                      style: GoogleFonts.openSans(
                          fontSize: 17, fontWeight: FontWeight.w600, decoration: TextDecoration.none),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.95,
                  color: Colors.transparent,
                )
              ],
            ),
          );
        });
  }

  registerVendorOtpCall(vendorid, otp) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_otp.text.isEmpty) {
        Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please Enter OTP");
      } else {
        log("ooooo $vendorid");
        log("ooooo $otp");
        final AddVendorOtpResponse loginData = await ApiProvider().addVendorVerifyOtp(vendorid, otp);
        log("ooooo ${loginData}");

        if (loginData.success == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => AddedVendor(title: widget.title!, id: widget.id!)),
              (Route<dynamic> route) => false);
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false ? "OTP is incorrect" : "thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on the internet");
    }
  }
}

class SubCat {
  TextEditingController subController = TextEditingController();
  // String hinttext = "";
  // String text = "";
  CategoriesResponseData subCat;
  SubCat(this.subCat);
}

class SignPad extends StatefulWidget {
  final Uint8List? data;
  final ui.Image? imageData;
  final GlobalKey<SfSignaturePadState>? signaturePadKey;
  SignPad({
    Key? key,
    this.data,
    this.imageData,
    this.signaturePadKey,
  }) : super(key: key);
  @override
  _SignPadState createState() => _SignPadState();
}

class _SignPadState extends State<SignPad> {
  Uint8List? data;
  ui.Image? imageData;
  //GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  @override
  void initState() {
    if (widget.data != null && widget.imageData != null) {
      data = widget.data;
      imageData = widget.imageData;
    }

    super.initState();
  }

  var a, b;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        // height: 300,
        // width: devicewidth,
        decoration:
            BoxDecoration(border: Border.all(width: 1), borderRadius: BorderRadius.circular(20), color: Colors.white54),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text('Signature', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
            GestureDetector(
              onTap: () {
                if (imageData == null) {
                  widget.signaturePadKey!.currentState!.clear();
                } else {
                  // log("${data}");
                  data = null;
                  imageData = null;

                  setState(() {});
                }

                // termsConditionsDialog();
              },
              child: Text('Clear', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ]),
          imageData == null
              ? Container(
                  height: 180,
                  width: 300,
                  child: SfSignaturePad(
                    backgroundColor: Colors.transparent,
                    key: widget.signaturePadKey,
                    onDraw: (a, b) {
                      log("kai${widget.signaturePadKey!.currentState!.toPathList().length}");
                    },
                  ),
                )
              : Container(
                  height: 180,
                  width: 300,
                  child: Image.memory(data!),
                ),
          // SfSignaturePad(
          //   backgroundColor: Colors.red,
          //   // key: ,
          // ),
        ]));
  }
}

class CityBottomSheet extends StatefulWidget {
  final List<GetAllCityByStateResponseData> citydata;
  final Function(GetAllCityByStateResponseData city) onSelect;
  CityBottomSheet({required this.citydata, required this.onSelect, Key? key}) : super(key: key);

  @override
  _CityBottomSheetState createState() => _CityBottomSheetState();
}

class _CityBottomSheetState extends State<CityBottomSheet> {
  List<GetAllCityByStateResponseData> citydata = [];
  TextEditingController edtSearch = TextEditingController();
  StreamController<List<GetAllCityByStateResponseData>> subject = StreamController();
  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  @override
  void initState() {
    super.initState();
    this.citydata = widget.citydata;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 0),
        height: MediaQuery.of(context).size.height * 0.50,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextFormField(
              controller: edtSearch,
              autofocus: false,
              cursorColor: ColorPrimary,
              decoration: InputDecoration(
                hintText: "Search your City...",
                counterText: "",
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: ColorPrimary, width: 2),
                ),
              ),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  List<GetAllCityByStateResponseData> searchList = [];

                  citydata.forEach((element) {
                    if (element.cityName.toLowerCase().contains(text.trim().toLowerCase())) {
                      searchList.add(element);
                    }
                  });
                  subject.add(searchList);
                } else {
                  subject.add(citydata);
                }
              },
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.33,
              child: StreamBuilder<List<GetAllCityByStateResponseData>>(
                  stream: subject.stream,
                  initialData: citydata,
                  builder: (context, snap) {
                    if (snap.hasData && snap.data!.length > 0) {
                      return ListView.builder(
                          itemCount: snap.data!.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  widget.onSelect(snap.data![index]);

                                  Navigator.pop(context);
                                },
                                child: Container(height: 30, child: Text("${snap.data![index].cityName}")),
                              ),
                            );
                          });
                    }

                    return Container();
                  })),
          Container(
            child: MaterialButton(
              onPressed: () {
                edtSearch.clear();
                Navigator.pop(context);
              },
              elevation: 5,
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

// class PersonEntry {
//   final String name;
//   final String age;
//   final String studyJob;

//   PersonEntry(this.name, this.age, this.studyJob);
//   @override
//   String toString() {
//     return 'Person: name= $name, age= $age, study job= $studyJob';
//   }
// }
// var nameTECs = <TextEditingController>[];
//   var ageTECs = <TextEditingController>[];
//   var jobTECs = <TextEditingController>[];
//   var cards = <Card>[];

//   Card createCard() {
//     var nameController = TextEditingController();
//     var ageController = TextEditingController();

//     nameTECs.add(nameController);
//     ageTECs.add(ageController);

//     return Card(
//       color: Colors.white,
//       margin: EdgeInsets.only(top: 10),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             TextFormField(
//               controller: nameController,
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
//               ],
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               //autovalidate: true,

//               decoration: InputDecoration(
//                 counterText: "",
//                 contentPadding:
//                     EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//
//                 fillColor: Color.fromRGBO(242, 242, 242, 1),
//                 hintText: 'Enter here title',
//                 hintStyle: TextStyle(
//                     color: Color.fromRGBO(85, 85, 85, 1),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: ageController,
//               inputFormatters: [
//                 FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
//               ],
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               //autovalidate: true,

//               decoration: InputDecoration(
//                 counterText: "",
//                 contentPadding:
//                     EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
//
//                 fillColor: Color.fromRGBO(242, 242, 242, 1),
//                 hintText: 'Enter here description',
//                 hintStyle: TextStyle(
//                     color: Color.fromRGBO(85, 85, 85, 1),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _onDone() {
//     List<PersonEntry> entries = [];
//     for (int i = 0; i < cards.length; i++) {
//       var name = nameTECs[i].text;
//       var age = ageTECs[i].text;
//       var job = jobTECs[i].text;
//       entries.add(PersonEntry(name, age, job));
//     }
//     Navigator.pop(context, entries);
//   }
