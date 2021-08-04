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
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:myprofit_employee/model/adddriver_response.dart';
import 'package:myprofit_employee/model/addvendor_form.dart';
import 'package:myprofit_employee/model/categories_respnse.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/add_footwear/add_footwear.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myprofit_employee/src/ui/home/home.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/imageconverter.dart';
import 'package:myprofit_employee/utils/network.dart';
import 'package:myprofit_employee/utils/validator.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class VendorForm extends StatefulWidget {
  final int id;
  final String title;

  const VendorForm({Key? key, required this.id, required this.title})
      : super(key: key);

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
  _VendorFormState(id, title);
  getCategories() async {
    result = await ApiProvider().getCategoriess();
    print(result);
    setState(() {});
    // return result!.data!;
  }

  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  var devicewidth, deviceheight;
  //image-picker
  File? myProfitBoardImage;
  File? validationShopImage;
  //image-picker

  //checkbox
  bool valuefirst = false;
  bool valuesecond = false;
  //checkbox

  TextEditingController _shopname = TextEditingController();
  TextEditingController _ownername = TextEditingController();

  TextEditingController _mobile = TextEditingController();

  TextEditingController _address = TextEditingController();

//api calling
  addVendors() async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      if (_shopname.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter ShopName");
      } else if (_ownername.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter OwnerName");
      } else if (_mobile.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter OwnerMobileNumber");
      } else if (_address.text.isEmpty) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Enter Shopaddress");
      } else if (valuesecond == false) {
        Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: "Please Select term and Condition");
      } else {
        final AddVendorResponse loginData = await ApiProvider().addVendor(
            "${widget.id}",
            _shopname.text,
            _ownername.text,
            _mobile.text,
            _address.text,
            data,
            arr);
        log("ooooo ${loginData}");
        if (loginData.success == true) {
          // pref.setBool("login", true);
          // pref.setString("token", loginData.token);
          // pref.setBool("sucees", loginData.success);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddFootwear(title: widget.title, id: widget.id)),
              (Route<dynamic> route) => false);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => thankYouDialog(),
          //     ));
        } else {
          Fluttertoast.showToast(
            backgroundColor: ColorPrimary,
            textColor: Colors.white,
            msg: loginData.success == false
                ? "Otp was incoorect"
                : "thanks for login ",
            // timeInSecForIos: 3
          );
        }
      }
    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on the internet");
    }
  }

  //terms-conditions-dialog
  termsConditionsDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Image? signature;
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
                                child: Image.asset('images/bg-cross.png',
                                    width: 20),
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
                          margin: EdgeInsets.all(10),
                          // height: 300,
                          // width: devicewidth,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white54),
                          child: Column(children: [
                            Text('Signature',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            Container(
                              height: 180,
                              width: 300,
                              child: SfSignaturePad(
                                backgroundColor: Colors.transparent,
                                key: _signaturePadKey,
                              ),
                            ),
                          ])),
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
                            _handleSaveButtonPressed();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  //terms-conditions-dialog
  Future<void> _handleSaveButtonPressed() async {
    final ui.Image imageData =
        await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await imageData.toByteData(format: ui.ImageByteFormat.png);
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
  var placeholderText = "Select sub categories";

  String arr = "";

  //List<Animal> _selectedAnimals = [];
  // List<Category> _selectedCategory2 = [];
  List<CategoriesResponseData?> _selectedCategory3 = [];

  //List<Animal> _selectedCategory4 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    getCategories();
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
          title: Text('${widget.title} Form',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                decoration: InputDecoration(
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
              Text('Owners name',
                  style: TextStyle(
                      color: Color.fromRGBO(48, 48, 48, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              TextFormField(
                controller: _ownername,
                decoration: InputDecoration(
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
                validator: (numb) => Validator.validateMobile(numb!, context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
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
                decoration: InputDecoration(
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
              AutoSizeText(
                'Sub Categories (If exists)',
                style: TextStyle(
                    color: Color.fromRGBO(48, 48, 48, 1),
                    fontWeight: FontWeight.w600),
                maxFontSize: 15,
                minFontSize: 10,
              ),
              SizedBox(height: 15),
              Container(
                height: 50,
                width: devicewidth,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      child: result == null
                          ? Center(child: CircularProgressIndicator())
                          :
                          //  FutureBuilder<List<CategoriesResponseData>>(
                          //     future: getCategories(),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.connectionState ==
                          //           ConnectionState.waiting) {
                          //         return Center(child: CircularProgressIndicator());
                          //       }
                          //       if (snapshot.hasError) {
                          //         return Center(
                          //           child: Text("Data Not Found"),
                          //         );
                          //       }
                          //       return

                          Container(
                              width: devicewidth - 30,
                              child: MultiSelectBottomSheetField<
                                  CategoriesResponseData?>(
                                buttonIcon: Icon(Icons.keyboard_arrow_down,
                                    color: Color.fromRGBO(85, 85, 85, 1)),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                key: _multiSelectKey,
                                initialChildSize: 0.7,
                                maxChildSize: 0.95,
                                title: Text('Sub categories',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
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
                                validator: (values) {
                                  if (values == null || values.isEmpty) {
                                    return "Required";
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
                                  setState(() {
                                    _selectedCategory3 = values;
                                    placeholderText = "Dhaba";
                                    for (int i = 0; i < values.length; i++) {
                                      if (i == values.length - 1) {
                                        placeholderText = placeholderText +
                                            values[i]!.categoryName;
                                        arr = arr + values[i]!.id.toString();
                                      } else {
                                        placeholderText = placeholderText +
                                            values[i]!.categoryName +
                                            ", ";
                                        arr = arr +
                                            values[i]!.id.toString() +
                                            ",";
                                      }
                                    }
                                  });
                                  _multiSelectKey.currentState!.validate();
                                },
                                chipDisplay: MultiSelectChipDisplay(
                                  onTap: (item) {
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
                    ),
                  ],
                ),
              ),

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
                Navigator.pop(context);
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
