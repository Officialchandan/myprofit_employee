import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:myprofit_employee/model/get_all_state_response.dart';
import 'package:myprofit_employee/model/getcity_by_state_response.dart';
import 'package:myprofit_employee/src/ui/added_vendor_list/added_vendor_list.dart';
import 'package:myprofit_employee/src/ui/map/google_maps.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import 'package:myprofit_employee/model/addvendor_form.dart';
import 'package:myprofit_employee/model/categories_respnse.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/home/home.dart';
import 'package:myprofit_employee/utils/colors.dart';

import 'package:myprofit_employee/utils/network.dart';
import 'package:myprofit_employee/utils/validator.dart';

class VendorForm extends StatefulWidget {
  final int? id;
  final String? title;
  // final double? lat;
  // final double? long;

  const VendorForm({Key? key, this.id, this.title}) : super(key: key);

  @override
  _VendorFormState createState() => _VendorFormState(this.id, this.title);
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
  _VendorFormState(id, title);
  getCategories() async {
    result = await ApiProvider().getCategoriess();
    print(result);
    CategoriesResponseData? data;
    result!.data!.forEach((element) {
      if (element.id == widget.id) {
        data = element;
        // result!.data!.remove(element);
        // subcatlist.add(SubCat(element));
      }
    });
    if (data != null) {
      result!.data!.remove(data);
    }
    setState(() {});
    // return result!.data!;
  }

  String searchText = "";
  bool searching = false;
  TextEditingController _searchController = TextEditingController();
  final PublishSubject<List<GetAllStateResponseData>> subject =
      PublishSubject();
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

  TextEditingController _mobile = TextEditingController();
  TextEditingController _comission = TextEditingController();

  TextEditingController _address = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  TextEditingController _state = TextEditingController();
  TextEditingController edtSearch = TextEditingController();
  StreamController<bool> editController = StreamController();
  StreamController<List<GetAllCityByStateResponse>> controller =
      StreamController();
  List<GetAllCityByStateResponse> cityList = [];

  List<SubCat> subcatlist = [];
//api calling
  addVendors() async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_shopname.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Shop Name");
      } else if (_comission.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Comission");
      } else if (_ownername.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Owner Name");
      } else if (_mobile.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Owner Mobile Number");
      } else if (_mobile.text.length != 10) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Valid Mobile Number");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Shop Address");
      } else if (lat == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Locator from map in Address Textfeild ");
      } else if (_pincode.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Pincode");
      } else if (_pincode.text.length != 6) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Valid Pincode");
      } else if (_state.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Shop State");
      } else if (_city.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Shop City");
      } else if (valuesecond == false) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select Term and Condition");
      } else if (imageData == null) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please do Signature in Terms and Condition");
      } else if (subcatlist.isNotEmpty) {
        String savelist = "";

        for (int i = 0; i < subcatlist.length; i++) {
          if (subcatlist[i].subController.text.isEmpty) {
            Fluttertoast.showToast(
                backgroundColor: ColorPrimary,
                textColor: Colors.white,
                msg: "Please Enter Other Categories Comission");
            savelist = "";
            break;
          } else {
            if (i == subcatlist.length - 1) {
              log("comiision====>${double.parse(subcatlist[i].subController.text.trim())}");
              savelist = savelist + subcatlist[i].subController.text.trim();
            } else {
              log("comiision====>${subcatlist[i].subController.text.trim()}");
              savelist =
                  savelist + subcatlist[i].subController.text.trim() + ",";
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
              arr,
              savelist);
          // log("ooooo ${loginData.data!.categoryType}");
          // log("ooooo ${loginData.data!.ownerMobile}");
          // log("ooooo ${savelist}");
          // log("ooooo ${arr}");
          if (loginData.success == true) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddedVendor(title: widget.title!, id: widget.id!)),
                (Route<dynamic> route) => false);
          } else {
            log("ooooo2 }");
            Fluttertoast.showToast(
                backgroundColor: ColorPrimary,
                textColor: Colors.white,
                msg: loginData.success == false
                    ? loginData.message
                    : "loginData.message"
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
            arr,
            comiisionarray);
        log("ooooo ${loginData}");
        log("ooooo ${comiisionarray}");
        log("ooooo ${arr}");
        if (loginData.success == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddedVendor(title: widget.title!, id: widget.id!)),
              (Route<dynamic> route) => false);
          Fluttertoast.showToast(
              backgroundColor: ColorPrimary,
              textColor: Colors.white,
              msg: "Added Sucsessfully");
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false
                ? loginData.message
                : "Thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
      //signaturePadKey!.currentState!.toPathList().length
      // else if (subcatlist.isNotEmpty) {
      //   for (int i = 0; i < subcatlist.length; i++) {
      //     if (subcatlist[i].subController.text.isEmpty) {
      //       Fluttertoast.showToast(
      //           backgroundColor: ColorPrimary,
      //           textColor: Colors.white,
      //           msg: "Please Enter SubCategories comission");
      //     }
      // else {
      //   for (int i = 0; i < subcatlist.length; i++) {
      //     if (i == subcatlist.length - 1) {
      //       comiisionarray = comiisionarray +
      //           double.parse(subcatlist[i].subController.text.trim())
      //               .toStringAsPrecision(2);
      //     } else {
      //       comiisionarray = comiisionarray +
      //           double.parse(subcatlist[i].subController.text.trim())
      //               .toStringAsPrecision(2) +
      //           ",";
      //     }
      //   }
      //   final AddVendorResponse loginData = await ApiProvider().addVendor(
      //       "${widget.id}",
      //       _shopname.text,
      //       _ownername.text,
      //       _comission.text,
      //       _mobile.text,
      //       _address.text,
      //       lat,
      //       lng,
      //       data,
      //       arr,
      //       comiisionarray);
      //   log("ooooo ${loginData}");
      //   log("ooooo ${comiisionarray}");
      //   log("ooooo ${arr}");
      //   if (loginData.success == true) {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) =>
      //                 AddFootwear(title: widget.title, id: widget.id)),
      //         (Route<dynamic> route) => false);
      //   } else {
      //     Fluttertoast.showToast(
      //       backgroundColor: ColorPrimary,
      //       textColor: Colors.white,
      //       msg: loginData.success == false
      //           ? "Please select Terms and condition"
      //           : "thanks for login ",
      //       // timeInSecForIos: 3
      //     );
      //   }
      // }
      //   }
      // }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on the internet");
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
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            alignment: Alignment.center,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: MediaQuery.of(context).size.width / 80,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: GestureDetector(
                              child:
                                  Image.asset('images/bg-cross.png', width: 20),
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
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // height: 200,
                      width: 300,
                      child: SignPad(
                          data: data,
                          imageData: imageData,
                          signaturePadKey: _signaturePadKey),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: () async {
                          if (_signaturePadKey.currentState != null) {
                            log("${_signaturePadKey.currentState!.toPathList().length}");
                            if (_signaturePadKey.currentState!
                                    .toPathList()
                                    .length !=
                                0) {
                              _handleSaveButtonPressed();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please do valid Signature",
                                  backgroundColor: ColorPrimary);
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
    final ByteData? bytes =
        await imageData!.toByteData(format: ui.ImageByteFormat.png);
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
                              child:
                                  Image.asset('images/bg-cross.png', width: 20),
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
                                color: Color.fromRGBO(48, 48, 48, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                  text: ' Myprofit ',
                                  style: TextStyle(
                                      color: Color.fromRGBO(102, 87, 244, 1),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text:
                                      'team jald hi aapke sampark mai aaegi!'),
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
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
  var placeholderText = "Select other categories";
  var cityid;
  var stateid;
  String arr = "";
  String comiisionarray = "";
  String commission = "";
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
    // getCityId(21);
  }

  GetAllStateResponse? getData;
  List<GetAllStateResponseData> stateData = [];
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
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on  internet");
    }
    return stateData;
    //_tap = true;
  }

  List<GetAllCityByStateResponseData> citydata = [];
  Future<List<GetAllCityByStateResponseData>> getCityId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${id}");
      GetAllCityByStateResponse getData =
          await ApiProvider().getCityByState(id);
      if (getData.success) {
        citydata = getData.data!;

        log("ggg ${citydata}");
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on  internet");
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
              title: Text('${widget.title} Form',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              centerTitle: true,
            ),
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shop Name',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 48, 48, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _shopname,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[[a-zA-Z0-9 ]')),
                      ],
                      autofocus: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 25,

                      // keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    Text(' Comission on ${widget.title}',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 48, 48, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _comission,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[[0-9. ]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 4,
                      autofocus: false,
                      // keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter Comission of ${widget.title}',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Owners Name',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 48, 48, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _ownername,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //autovalidate: true,
                      maxLength: 25,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('Mobile Number ',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 48, 48, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _mobile,
                      keyboardType: TextInputType.number,
                      validator: (numb) =>
                          Validator.validateMobile(numb!, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    Text('Address',
                        style: TextStyle(
                            color: Color.fromRGBO(48, 48, 48, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _address,
                      autofocus: false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            result1 = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoogleMapScreen()));
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
                            color: ColorPrimary,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here shop Address',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      controller: _landmark,
                      autofocus: false,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here Landmark (optional)',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _pincode,
                      keyboardType: TextInputType.number,
                      validator: (numb) =>
                          Validator.validatePincode(numb!, context),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 6,
                      autofocus: false,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Enter here Your Pincode',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return IntrinsicHeight(
                              child: Container(
                                padding: EdgeInsets.only(top: 20, bottom: 0),
                                child: Column(children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.45,
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: Colors.black,
                                            ),
                                        itemCount: stateData.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _city.clear();
                                                });

                                                getCityId(stateData[index].id);
                                                _state.text =
                                                    stateData[index].name;
                                                stateid = stateData[index]
                                                    .id
                                                    .toString();
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                  height: 30,
                                                  child: Text(
                                                      "${stateData[index].name.toUpperCase()}")),
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
                                      height: 50,
                                      elevation: 5,
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
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
                        suffixIcon: Icon(Icons.keyboard_arrow_down,
                            color: ColorPrimary),
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Select State',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      onTap: () {
                        log("${citydata.length}");
                        if (citydata.length > 0) {
                          _showModal(context);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Select State from above list",
                              backgroundColor: ColorPrimary);
                        }
                      },
                      controller: _city,
                      autofocus: false,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                        suffixIcon: Icon(Icons.keyboard_arrow_down,
                            color: ColorPrimary),
                        filled: true,
                        fillColor: Color.fromRGBO(242, 242, 242, 1),
                        hintText: 'Select Your city/village',
                        hintStyle: TextStyle(
                            color: Color.fromRGBO(85, 85, 85, 1),
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    AutoSizeText(
                      'Other Categories (If exists)',
                      style: TextStyle(
                          color: Color.fromRGBO(48, 48, 48, 1),
                          fontWeight: FontWeight.w600),
                      maxFontSize: 15,
                      minFontSize: 10,
                    ),
                    SizedBox(height: 10),

                    SizedBox(height: 15),

                    // GestureDetector(
                    //   onTap: () {
                    //     FocusScopeNode currentFocus = FocusScope.of(context);
                    //     if (!currentFocus.hasPrimaryFocus) {
                    //       currentFocus.unfocus();
                    //     }
                    //   },
                    //   child:
                    Container(
                      child: result == null
                          ? Center(child: CircularProgressIndicator())
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
                              child: MultiSelectDialogField<
                                  CategoriesResponseData?>(
                                buttonIcon: Icon(Icons.keyboard_arrow_down,
                                    color: ColorPrimary),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                key: _multiSelectKey,
                                // initialChildSize: 0.7,
                                // maxChildSize: 0.95,
                                title: GestureDetector(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Other categories',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600)),
                                ),
                                buttonText: Text(placeholderText,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color.fromRGBO(85, 85, 85, 1),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600)),
                                searchTextStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                                cancelText: Text('Cancel',
                                    style: TextStyle(
                                        color: Color(0xff6657f4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                confirmText: Text('Ok',
                                    style: TextStyle(
                                        color: Color(0xff6657f4),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                items: result!.data!
                                    .map((category) =>
                                        MultiSelectItem<CategoriesResponseData>(
                                            category, category.categoryName))
                                    .toList(),
                                searchable: true,
                                initialValue:
                                    subcatlist.map((e) => e.subCat).toList(),

                                validator: (values) {
                                  if (values == null || values.isEmpty) {
                                    return "";
                                  }
                                  List<String> names = values
                                      .map((e) => e!.categoryName)
                                      .toList();

                                  if (names.contains("Frog")) {
                                    return "Frogs are weird!";
                                  }
                                  return null;
                                },
                                onConfirm: (values) {
                                  // SystemChannels.textInput.invokeMethod('TextInput.hide');
                                  // SystemChannels.textInput
                                  //     .invokeMethod('TextInput.hide');
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  setState(() {
                                    _selectedCategory3 = values;
                                    placeholderText = "";
                                    subcatlist.clear();
                                    if (values.length == 0) {
                                      placeholderText =
                                          "Please select category";
                                    } else {
                                      for (int i = 0; i < values.length; i++) {
                                        if (i == values.length - 1) {
                                          placeholderText =
                                              "Please select category";
                                          arr = arr + values[i]!.id.toString();
                                        } else {
                                          // placeholderText = placeholderText +
                                          //     values[i]!.categoryName +
                                          //     ", ";
                                          arr = arr +
                                              (values[i]!.id.toString()) +
                                              ",";
                                        }
                                        subcatlist.add(SubCat(values[i]!));
                                      }
                                    }
                                  });
                                  _multiSelectKey.currentState!.validate();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (item) {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
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
                    //),
                    Column(
                        children: List.generate(subcatlist.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: false),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[[0-9. ]')),
                          ],
                          maxLength: 4,
                          controller: subcatlist[index].subController,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            filled: true,
                            fillColor: Color.fromRGBO(242, 242, 242, 1),
                            hintText:
                                'Please Enter ${subcatlist[index].subCat.categoryName} Commision',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(85, 85, 85, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      );
                    })),

                    SizedBox(height: 15),
                    // Text('Photo of the place where MyProfit board is to be placed',
                    //     style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    // SizedBox(height: 10),
                    // InkWell(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: myProfitBoardImage != null
                    //         ? Image(image: FileImage(myProfitBoardImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                    //         : Image(image: AssetImage('images/placeholder.png'), width: double.infinity, height: 150, fit: BoxFit.cover),
                    //   ),
                    //   onTap: () {
                    //     showBottomSheet(5, context);
                    //   },
                    // ),
                    // SizedBox(height: 15),
                    // Text('Documents for validation of Shop', style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
                    // SizedBox(height: 10),
                    // InkWell(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(10),
                    //     child: validationShopImage != null
                    //         ? Image(image: FileImage(validationShopImage!), width: double.infinity, height: 150, fit: BoxFit.cover)
                    //         : Image(image: AssetImage('images/placeholder.png'), width: double.infinity, height: 150, fit: BoxFit.cover),
                    //   ),
                    //   onTap: () {
                    //     showBottomSheet(6, context);
                    //   },
                    // ),
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
                    //                 color: Color.fromRGBO(102, 87, 244, 1),
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
                              Text('Accept all ',
                                  style: TextStyle(
                                      color: Color(0xff303030),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              InkWell(
                                child: Text('Terms & Conditions',
                                    style: TextStyle(
                                        color: Color(0xff6657f4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline)),
                                onTap: () {
                                  log("img ${data}");
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
                            log("kai kai---->");

                            log("${imageData.toString()}");
                            addVendors();
                          },
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showModal(context) {
    showModalBottomSheet(
      //isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      context: context,
      builder: (context) {
        return IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 0),
            child: Column(children: [
              TextFormField(
                controller: edtSearch,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: "Search your City...",
                ),
                onChanged: (text) {
                  setState(() {
                   // cityList = _buildSearchList(value);
                  });
                  // if (text.isNotEmpty) {
                  //   List<GetAllCityByStateResponse>
                  //       searchList = [];

                  //   cityList.forEach((element) {
                  //     if (element.data!.contains(
                  //         text.trim().toLowerCase())) {
                  //       searchList.add(element);
                  //     }
                  //   });
                  //   controller.add(searchList);
                  //   editController.add(true);
                  // } else {
                  //   controller.add(cityList);
                  //   editController.add(false);
                  // }
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.39,
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: citydata.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            /// getCityId(stateData[index].id);
                            _city.text = citydata[index].name;
                            cityid = citydata[index].id.toString();
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 30,
                              child: Text("${citydata[index].name}")),
                        ),
                      );
                    }),
              ),
              Container(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    edtSearch.clear();
                    cityList.clear();
                  },
                  height: 50,
                  elevation: 5,
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
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
  }

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
                child: Text('Camera',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  selectImage(2, imageType);
                  Navigator.pop(context);
                },
                child: Text('Gallery',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoogleMapScreen(
                            id: widget.id, title: widget.title)));
                // Navigator.pop(context);
              },
              child: Text('Cancel',
                  style: TextStyle(
                      color: Color(0xfff92d28),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
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
        myProfitBoardImage = File(pickedFile.path);
        break;
      case 2:
        validationShopImage = File(pickedFile.path);
        break;
    }

    setState(() {});
  }

//image-picker
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
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white54),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Signature',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
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
              child: Text('Clear',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
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
