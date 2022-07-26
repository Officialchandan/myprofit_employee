import 'dart:developer';

import 'package:employee/model/getvenordbyid_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/addvendor_form/vendor_form.dart';
import 'package:employee/src/ui/bottom_navigation/bottom_navigation.dart';
import 'package:employee/src/ui/editvendor_details/edit_vendor_detail.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

class AddedVendor extends StatefulWidget {
  final String title;
  final int id;

  const AddedVendor({required this.title, required this.id});
  @override
  _AddedVendorState createState() => _AddedVendorState(this.title, this.id);
}

class _AddedVendorState extends State<AddedVendor> {
  // var t = widget.title;
  var footwearListText = ['Shoe Fly', 'Sole Mates', 'Hot Heels Boutique', 'FootCandy Shoes', 'Kickass Kicks'];
  var datas = [];
  _AddedVendorState(String title, int id);
  final PublishSubject<List<GetVendorByIdResponseData>> subject = PublishSubject();

  // GetVendorByIdResponse? loginData;
  List<GetVendorByIdResponseData> loginData = [];
  List<GetVendorByIdResponseData> searchList = [];
  bool loading = true;
  //searching
  TextEditingController _searchController = TextEditingController();

  String searchText = "";
  bool searching = false;

  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  @override
  void initState() {
    super.initState();
    log("====>${widget.id}");
    getVendorId(widget.id);
  }

  Future<List<GetVendorByIdResponseData>> getVendorId(id) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +$id");
      GetVendorByIdResponse getVendor = await ApiProvider().getVendorId(id);
      loading = false;
      if (getVendor.success) {
        loginData = getVendor.data!;
        searchList.addAll(loginData);
        // subject.add(loginData);
        log("ggg $loginData");

        setState(() {});
      } else {
        subject.add([]);
        setState(() {});
      }
    } else {
      loading = false;
      setState(() {});
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    return loginData;
    //_tap = true;
  }

  var gradientColor = GradientTemplate.gradientTemplate;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigation()), (route) => false);
        return Future.value(false);
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
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (BuildContext context) => BottomNavigation()), (route) => false);
                      },
                    );
                  },
                ),
                title: Text('${widget.title}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                // centerTitle: true,
                actions: [
                  loginData.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            child: Center(
                              child: Container(
                                height: 35,
                                color: Colors.transparent,
                                child: FittedBox(
                                  //height: 55,
                                  // constraints: BoxConstraints(
                                  //   minWidth: 150,
                                  // ),
                                  child: Container(
                                    //width: 150,

                                    height: 30,
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Row(children: [
                                        Text(
                                          'Add ',
                                          style: TextStyle(
                                            color: ColorPrimary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: ColorPrimary,
                                        )
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorForm(
                                          id: widget.id,
                                          title: widget.title,
                                        )),
                              );
                            },
                          ),
                        ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: loading
                      ? Center(
                          child: CircularProgressIndicator(color: ColorPrimary),
                        )
                      : Column(
                          //height: 400,
                          children: [
                              loginData.isEmpty
                                  ? Center(
                                      child: Padding(
                                          padding: const EdgeInsets.only(right: 10, top: 300),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => VendorForm(
                                                          id: widget.id,
                                                          title: widget.title,
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 40,
                                              margin: EdgeInsets.all(8),
                                              padding: EdgeInsets.only(right: 10, left: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 0),
                                                  ]),
                                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                Text(
                                                  'Add ',
                                                  style: TextStyle(
                                                    color: ColorPrimary,
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Icon(
                                                  Icons.add,
                                                  color: ColorPrimary,
                                                )
                                              ]),
                                            ),
                                          )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 16, right: 16),
                                      child: TextFormField(
                                        controller: _searchController,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: ColorPrimary,
                                            size: 25,
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(12, 8, 5, 8),
                                          hintText: 'Search Shops',
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(85, 85, 85, 1),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: ColorPrimary, width: 2),
                                          ),
                                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                        ),
                                        onChanged: (text) {
                                          searchList.clear();
                                          if (text.isNotEmpty) {
                                            print("searchText -->$text");
                                            List<GetVendorByIdResponseData> list = [];
                                            log("loginData ${loginData.length}");
                                            loginData.forEach((element) {
                                              if (element.name.toLowerCase().contains(text.toLowerCase())) {
                                                print("text -->$text");
                                                list.add(element);
                                                log("element.name ${element.name}");
                                              }

                                              if (list.isEmpty) {
                                                log("==?$list");
                                                Container(
                                                  height: 100,
                                                  color: Colors.orange,
                                                  child: Image.asset("images/no_data.gif"),
                                                );
                                              } else {
                                                log("655757575$list");
                                                searchList = list;
                                              }
                                            });

                                            setState(() {});
                                          } else {
                                            searchList.addAll(loginData);

                                            setState(() {});
                                          }
                                        },
                                      ),
                                    ),
                              searchList.isEmpty
                                  ? loginData.isNotEmpty
                                      ? Container(
                                          padding: EdgeInsets.only(top: 300),
                                          child: Center(
                                            child: Image.asset("images/no_data.gif"),
                                          ),
                                        )
                                      : Container()
                                  : Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchList.length,
                                          padding: EdgeInsets.only(top: 6),
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                              child: Column(children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      //  bottom: 5,
                                                      // top: 5,
                                                      //     left: 10,
                                                      //     right: 10
                                                      ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(5),
                                                        child: searchList[index].vendorImage.isEmpty
                                                            ? Image.asset(
                                                                "images/placeholder.png",
                                                                width: 65,
                                                                height: 65,
                                                                fit: BoxFit.cover,
                                                              )
                                                            : Image.network(
                                                                "${searchList[index].vendorImage.first.image}",
                                                                width: 65,
                                                                height: 65,
                                                                fit: BoxFit.cover,
                                                              ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            child: Text(searchList[index].name,
                                                                style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 18,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w600)),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.68,
                                                            child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('+91 ${searchList[index].ownerMobile}',
                                                                      style: TextStyle(
                                                                        color: Color(0xff555555),
                                                                        fontSize: 14,
                                                                      )),
                                                                  Center(
                                                                      child: searchList[index].isActive == 2
                                                                          ? Text(
                                                                              "  Pending  ",
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: PendingTextColor,
                                                                              ),
                                                                            )
                                                                          : searchList[index].isActive == 1
                                                                              ? Text(
                                                                                  "  Approved  ",
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: ApproveTextColor,
                                                                                  ),
                                                                                )
                                                                              : searchList[index].isActive == 0
                                                                                  ? Text(
                                                                                      "  Rejected  ",
                                                                                      style: TextStyle(
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: RejectedBoxTextColor,
                                                                                      ),
                                                                                    )
                                                                                  : Text(
                                                                                      "  Rejected  ",
                                                                                      style: TextStyle(
                                                                                        fontSize: 15,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: RejectedBoxTextColor,
                                                                                      ),
                                                                                    )),
                                                                ]),
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Image.asset('images/g-pin.png', width: 13),
                                                              Container(
                                                                width: MediaQuery.of(context).size.width * 0.60,
                                                                child: Text(' ${searchList[index].address}',
                                                                    style: TextStyle(
                                                                      color: Color(0xff555555),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      fontSize: 14,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                  color: Colors.grey.shade300,
                                                )
                                              ]),
                                              onTap: () {
                                                FocusScope.of(context).requestFocus(new FocusNode());
                                                FocusScopeNode currentFocus = FocusScope.of(context);
                                                if (!currentFocus.hasPrimaryFocus) {
                                                  currentFocus.unfocus();
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => UpdateVendorDetail(
                                                            title: widget.title,
                                                            id: widget.id,
                                                            vendordata: searchList[index])));
                                              },
                                            );
                                          })),

                              //dhaba-list
                            ]),
                ),
              ))),
    );
  }
}
