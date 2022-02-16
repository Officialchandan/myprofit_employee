import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:employee/model/categories_respnse.dart';
import 'package:employee/model/get_all_state_response.dart';
import 'package:employee/model/getcity_by_state_response.dart';
import 'package:employee/model/getvenordbyid_response.dart';
import 'package:employee/model/updatevendordetail_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class UpdateVendorDetail extends StatefulWidget {
  final GetVendorByIdResponseData vendordata;
  final String title;
  final int id;

  const UpdateVendorDetail({
    Key? key,
    required this.vendordata,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  _UpdateVendorDetailState createState() => _UpdateVendorDetailState(this.vendordata, this.title, this.id);
}

//select-category

//select-category

class _UpdateVendorDetailState extends State<UpdateVendorDetail> {
  CategoriesResponse? result;
  File? image;
  Uint8List? data;
  var subcat;
  UpdateVendorResponse? loginData;
  _UpdateVendorDetailState(var data, String title, int id);

  getCategories() async {
    result = await ApiProvider().getCategoriess();
    print(result);
    // CategoriesResponseData? data;
    List<SubCategory> subcat = widget.vendordata.subCategory;

    subcat.forEach((subcat) {
      result!.data!.removeWhere((e) => e.id.toString() == subcat.catId);
    });
    result!.data!.removeWhere((e) => e.id.toString() == widget.id.toString());

    setState(() {});
    // return result!.data!;
  }

  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  var devicewidth, deviceheight;
  //image-picker
  File? myProfitBoardImage;
  File? validationShopImage;
  //image-picker
  var datas = [];
  //checkbox
  bool valuefirst = false;
  bool valuesecond = false;
  //checkbox

  TextEditingController _shopname = TextEditingController();

  TextEditingController _ownername = TextEditingController();

  TextEditingController _mobile = TextEditingController();

  TextEditingController _address = TextEditingController();
  TextEditingController _landmark = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _pincode = TextEditingController();

  TextEditingController _state = TextEditingController();

//api calling
  // addVendors() async {
  //   if (await Network.isConnected()) {
  //     SystemChannels.textInput.invokeMethod("TextInput.hide");

  //     if (_shopname.text.isEmpty) {
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "Please Enter ShopName");
  //     } else if (_ownername.text.isEmpty) {
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "Please Enter OwnerName");
  //     } else if (_mobile.text.isEmpty) {
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "Please Enter OwnerMobileNumber");
  //     } else if (_mobile.text.length != 10) {
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "Please Enter Valid Mobile Number");
  //     } else if (_address.text.isEmpty) {
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "Please Enter Shopaddress");
  //     } else if (subcatlist.isNotEmpty) {
  //       String savelist = "";

  //       for (int i = 0; i < subcatlist.length; i++) {
  //         if (subcatlist[i].subController.text.isEmpty) {
  //           Fluttertoast.showToast(
  //               backgroundColor: ColorPrimary,
  //               textColor: Colors.white,
  //               msg: "Please Enter OtherCategories comission");
  //           savelist = "";
  //           break;
  //         } else {
  //           if (i == subcatlist.length - 1) {
  //             savelist = savelist +
  //                 double.parse(subcatlist[i].subController.text.trim())
  //                     .toStringAsPrecision(2);
  //           } else {
  //             savelist = savelist +
  //                 double.parse(subcatlist[i].subController.text.trim())
  //                     .toStringAsPrecision(2) +
  //                 ",";
  //           }
  //         }
  //       }

  //       if (savelist.isNotEmpty) {
  //         final UpdateVendorResponse loginData = await ApiProvider()
  //             .updatedetails(
  //                 "${widget.vendordata.id}",
  //                 _shopname.text,
  //                 _ownername.text,
  //                 _mobile.text,
  //                 _address.text,
  //                 _landmark.text,
  //                 widget.vendordata.city,
  //                 widget.vendordata.state,
  //                 widget.vendordata.pin,
  //                 subCatergory,
  //                 savelist);
  //         log("ooooo ${loginData.message}");
  //         if (loginData.success == true) {
  //           log("${widget.vendordata.id}");
  //           log("${widget.title}");
  //           log("${widget.id}");
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     AddFootwear(title: widget.title, id: widget.id)),
  //           );
  //         } else {
  //           Fluttertoast.showToast(
  //             backgroundColor: ColorPrimary,
  //             textColor: Colors.white,
  //             msg: loginData.success == false
  //                 ? "unable to update"
  //                 : "thanks for login ",
  //             // timeInSecForIos: 3
  //           );
  //         }
  //       }
  //     } else {
  //       final UpdateVendorResponse loginData = await ApiProvider()
  //           .updatedetails(
  //               "${widget.vendordata.id}",
  //               _shopname.text,
  //               _ownername.text,
  //               _mobile.text,
  //               _address.text,
  //                _landmark.text,
  //                 widget.vendordata.city,
  //                 widget.vendordata.state,
  //                 widget.vendordata.pin,
  //               subCatergory,
  //               subCatergorycomission);
  //       log("ooooo ${loginData.message}");
  //       if (loginData.success == true) {
  //         log("uuuuu${widget.vendordata.id}");
  //         log("${widget.title}");
  //         log("${widget.id}");
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) =>
  //                   AddFootwear(title: widget.title, id: widget.id)),
  //         );
  //         Fluttertoast.showToast(
  //             backgroundColor: ColorPrimary,
  //             textColor: Colors.white,
  //             msg: "updated sucsessfully");
  //       } else {
  //         Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: loginData.success == false
  //               ? "unable to update"
  //               : "thanks for login ",
  //           // timeInSecForIos: 3
  //         );
  //       }
  //       Fluttertoast.showToast(
  //           backgroundColor: ColorPrimary,
  //           textColor: Colors.white,
  //           msg: "updated sucsessfully");
  //     }
  //   } else {
  //     Fluttertoast.showToast(
  //         backgroundColor: ColorPrimary,
  //         textColor: Colors.white,
  //         msg: "Please turn on the internet");
  //   }
  // }

  //terms-conditions-dialog

  Future<void> _handleSaveButtonPressed() async {
    final ui.Image imageData = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes = await imageData.toByteData(format: ui.ImageByteFormat.png);
    if (bytes != null) {
      data = bytes.buffer.asUint8List();
      log("data   ${data}");
      image = File.fromRawPath(data!);
      log("patj>>>${image!.path}");
      log("name   ${image!.length()}");
      // File(carData['image'])
    }
    Navigator.pop(context);
  }

  //thank-you-dialog

  //thank-you-dialog

  //select-category
  var placeholderText = "Select Other categories";

  String subCatergory = "";
  String subCatergorycomission = "";

  //List<Animal> _selectedAnimals = [];
  // List<Category> _selectedCategory2 = [];
  List<CategoriesResponseData?> _selectedCategory3 = [];

  //List<Animal> _selectedCategory4 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();
  List<SubCat> subcatlist = [];
  @override
  void initState() {
    super.initState();
    _shopname.text = widget.vendordata.name;
    getCategories();
    _ownername.text = widget.vendordata.ownerName;
    _mobile.text = widget.vendordata.ownerMobile;

    _address.text = widget.vendordata.address;
    _landmark.text = widget.vendordata.landmark;

    _pincode.text = widget.vendordata.pin.toString();
    _state.text = widget.vendordata.stateName;

    _city.text = widget.vendordata.cityName;
    log(" pura milgya${widget.vendordata.city}");
    log(" pura milgya${widget.vendordata.cityName}");
    getStateId(101);
    //getCityId(21);
  }

  List<GetAllStateResponseData> stateData = [];
  Future<List<GetAllStateResponseData>> getStateId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +${id}");
      GetAllStateResponse getData = await ApiProvider().getState(id);
      if (getData.success) {
        stateData = getData.data!;

        log("ggg ${stateData}");
      }
    } else {
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    return stateData;
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
          title: Text(' ${widget.title} Shop Details', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shop Name',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                //  _shopname.text = widget.shopename,
                controller: _shopname,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                maxLength: 25,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              ),
              SizedBox(height: 15),
              Text('Owners name',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                maxLength: 25,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _ownername,
                readOnly: true,
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
              ),
              SizedBox(height: 15),
              Text('Mobile Number ',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _mobile,
                readOnly: true,
                keyboardType: TextInputType.number,
                validator: (numb) => Validator.validateMobile(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
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
              ),
              SizedBox(height: 15),
              Text('Address',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                controller: _address,
                autofocus: false,
                decoration: InputDecoration(
                  // suffixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.add_location,
                  //     color: ColorPrimary,
                  //   ),
                  // ),
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here shop Address',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Landmark',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _landmark,
                readOnly: true,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'landmark was not given by Vendor',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Pincode',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _pincode,
                readOnly: true,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here Landmark (optional)',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('City',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _city,
                readOnly: true,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here Landmark (optional)',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('State',
                  style: TextStyle(color: Color.fromRGBO(48, 48, 48, 1), fontSize: 15, fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _state,
                readOnly: true,
                autofocus: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  filled: true,
                  fillColor: Color.fromRGBO(242, 242, 242, 1),
                  hintText: 'Enter here Landmark (optional)',
                  hintStyle: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 13, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              // TextFormField(
              //   controller: _pincode,
              //   autofocus: false,
              //   decoration: InputDecoration(
              //     contentPadding:
              //         EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              //     filled: true,
              //     fillColor: Color.fromRGBO(242, 242, 242, 1),
              //     hintText: 'Enter here pincode',
              //     hintStyle: TextStyle(
              //         color: Color.fromRGBO(85, 85, 85, 1),
              //         fontSize: 13,
              //         fontWeight: FontWeight.w600),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: _city,
              //   autofocus: false,
              //   decoration: InputDecoration(
              //     contentPadding:
              //         EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              //     filled: true,
              //     fillColor: Color.fromRGBO(242, 242, 242, 1),
              //     hintText: 'Enter here Your City/village',
              //     hintStyle: TextStyle(
              //         color: Color.fromRGBO(85, 85, 85, 1),
              //         fontSize: 13,
              //         fontWeight: FontWeight.w600),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextFormField(
              //   controller: _state,
              //   autofocus: false,
              //   decoration: InputDecoration(
              //     contentPadding:
              //         EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
              //     filled: true,
              //     fillColor: Color.fromRGBO(242, 242, 242, 1),
              //     hintText: 'Enter here State',
              //     hintStyle: TextStyle(
              //         color: Color.fromRGBO(85, 85, 85, 1),
              //         fontSize: 13,
              //         fontWeight: FontWeight.w600),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              // ),
              SizedBox(height: 15),
              // AutoSizeText(
              //   'Other Categories (If exists)',
              //   style: TextStyle(
              //       color: Color.fromRGBO(48, 48, 48, 1),
              //       fontWeight: FontWeight.w600),
              //   maxFontSize: 15,
              //   minFontSize: 10,
              // ),
              // SizedBox(height: 15),
              // SizedBox(height: 10),
              // Container(
              //   child: result == null
              //       ? Center(child: CircularProgressIndicator())
              //       : Container(
              //           // width: devicewidth - 30,
              //           child: MultiSelectBottomSheetField<
              //               CategoriesResponseData?>(
              //             buttonIcon: Icon(Icons.keyboard_arrow_down,
              //                 color: Color.fromRGBO(85, 85, 85, 1)),
              //             decoration: BoxDecoration(
              //               color: Color.fromRGBO(242, 242, 242, 1),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             key: _multiSelectKey,
              //             initialChildSize: 0.7,
              //             maxChildSize: 0.95,
              //             title: Text('Other categories',
              //                 style: TextStyle(
              //                     color: Colors.black,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600)),
              //             buttonText: Text(placeholderText,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(
              //                     color: Color.fromRGBO(85, 85, 85, 1),
              //                     fontSize: 13,
              //                     fontWeight: FontWeight.w600)),
              //             searchTextStyle: TextStyle(
              //                 color: Colors.black,
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w600),
              //             cancelText: Text('Cancel',
              //                 style: TextStyle(
              //                     color: Color(0xff6657f4),
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600)),
              //             confirmText: Text('Ok',
              //                 style: TextStyle(
              //                     color: Color(0xff6657f4),
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600)),
              //             items: result!.data!
              //                 .map((category) =>
              //                     MultiSelectItem<CategoriesResponseData>(
              //                         category, category.categoryName))
              //                 .toList(),
              //             initialValue:
              //                 subcatlist.map((e) => e.subCat).toList(),
              //             searchable: true,

              //             validator: (values) {
              //               if (values == null || values.isEmpty) {
              //                 return "";
              //               }
              //               List<String> names =
              //                   values.map((e) => e!.categoryName).toList();

              //               if (names.contains("Frog")) {
              //                 return "Frogs are weird!";
              //               }
              //               return null;
              //             },
              //             onConfirm: (values) {
              //               // SystemChannels.textInput.invokeMethod('TextInput.hide');
              //               SystemChannels.textInput
              //                   .invokeMethod('TextInput.hide');
              //               setState(() {
              //                 _selectedCategory3 = values;
              //                 placeholderText = "";
              //                 subcatlist.clear();
              //                 if (values.length == 0) {
              //                   placeholderText = "please select category";
              //                 } else {
              //                   for (int i = 0; i < values.length; i++) {
              //                     if (i == values.length - 1) {
              //                       placeholderText = "please select category";
              //                       subCatergory =
              //                           subCatergory + values[i]!.id.toString();
              //                     } else {
              //                       placeholderText = "please select category";
              //                       subCatergory = subCatergory +
              //                           values[i]!.id.toString() +
              //                           ",";
              //                     }
              //                     subcatlist.add(SubCat(values[i]!));
              //                   }
              //                 }
              //               });
              //               _multiSelectKey.currentState!.validate();
              //             },
              //             chipDisplay: MultiSelectChipDisplay(
              //               onTap: (item) {
              //                 setState(() {
              //                   _selectedCategory3.remove(item);
              //                   log("dddd ${item}");
              //                 });
              //                 _multiSelectKey.currentState!.validate();
              //               },
              //             )..disabled = true,
              //             //  );
              //             // }
              //           ),
              //         ),
              // ),
              // Column(
              //     children: List.generate(
              //         subcatlist.length,
              //         (index) => Padding(
              //               padding: const EdgeInsets.only(top: 20),
              //               child: TextFormField(
              //                 keyboardType: TextInputType.number,
              //                 maxLength: 4,
              //                 controller: subcatlist[index].subController,
              //                 decoration: InputDecoration(
              //                   counterText: "",
              //                   contentPadding: EdgeInsets.only(
              //                       left: 14.0, bottom: 8.0, top: 8.0),
              //                   filled: true,
              //                   fillColor: Color.fromRGBO(242, 242, 242, 1),
              //                   hintText:
              //                       'Please Enter ${subcatlist[index].subCat.categoryName} Commision',
              //                   hintStyle: TextStyle(
              //                       color: Color.fromRGBO(85, 85, 85, 1),
              //                       fontSize: 13,
              //                       fontWeight: FontWeight.w600),
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(10),
              //                     borderSide: BorderSide.none,
              //                   ),
              //                 ),
              //               ),
              //             ))),
              SizedBox(height: 15),
              SizedBox(height: 15),
              // Align(
              //   alignment: Alignment.center,
              //   child: ButtonTheme(
              //     minWidth: 200,
              //     // ignore: deprecated_member_use
              //     child: RaisedButton(
              //       padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              //       color: Color.fromRGBO(102, 87, 244, 1),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       onPressed: () {
              //         Navigator.pop(context);
              //       },
              //       child: Text(
              //         "SUBMIT",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //   ),
              // ),
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

  CategoriesResponseData subCat;
  SubCat(this.subCat);
}
