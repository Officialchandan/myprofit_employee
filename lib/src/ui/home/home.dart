import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/model/categories_respnse.dart';
import 'package:myprofit_employee/model/getvenordbyid_response.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/add_dhaba/add_dhaba.dart';
import 'package:myprofit_employee/src/ui/add_footwear/add_footwear.dart';
import 'package:myprofit_employee/src/ui/login/login.dart';
import 'package:myprofit_employee/src/ui/vendor_form/vendor_form.dart';
import 'package:myprofit_employee/utils/colors.dart';
import 'package:myprofit_employee/utils/network.dart';

import 'package:rxdart/rxdart.dart';

class Home extends StatefulWidget {
  final Function onTab;
  Home({
    Key? key,
    required this.onTab,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoriesResponse? result;

  // var categoryList = [
  //   'Dhaba',
  //   'Footwear',
  //   'Clothes Shop',
  //   'Barber',
  //   'Pan/Cigarette shop',
  //   'Electronics',
  //   'Ondoor (Grocery/Kirana)',
  //   'Hardware Shop',
  //   'Stationary',
  //   'Chemist'
  //];
  bool _tap = true;
  List<CategoriesResponseData> categorieslist = [];
  var setAddFormRoute = [
    AddDhaba(),
  ];

  TextEditingController _searchController = TextEditingController();

  String searchText = "";
  bool searching = false;
  int? id;

  final PublishSubject<List<CategoriesResponseData>> subject = PublishSubject();
  List<GetVendorByIdResponseData> loginData = [];
  @override
  void initState() {
    super.initState();
    getCategories();
    // getVendorId(id);
    // subject.stream
    //     .debounceTime(Duration(milliseconds: 50))
    //     .listen((searchText) async {
    //   this.searchText = searchText;
    //   if (await Network.isConnected()) {
    //     if (searchText.isNotEmpty) {
    //       print("searchText -->$searchText");
    //       searchList.clear();
    //       log("ram ${result!.data!}");
    //       for (int i = 0; i < result!.data!.length; i++) {
    //         if (result!.data![i].categoryName
    //             .toLowerCase()
    //             .contains(searchText.toLowerCase())) {
    //           print("Container -->$searchText");
    //           searchList.add(result!.data![i]);
    //           log("ram ${result!.data![i].categoryName}");
    //         } else {
    //           print("Container -->data not found");
    //         }
    //       }
    //     } else {
    //       Fluttertoast.showToast(msg: "msg", backgroundColor: ColorPrimary);
    //       print("Container -->data not found2");
    //       searchList.clear();
    //     }
    //   } else {
    //     Fluttertoast.showToast(
    //         msg: "Please check Your Internet", backgroundColor: ColorPrimary);
    //   }
    //   // setState(() {});
    // });
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  void dispose() {
    super.dispose();
    subject.close();
  }

  getVendorId(id, title) async {
    if (await Network.isConnected()) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      print("kai kroge +");
      GetVendorByIdResponse getVendor = await ApiProvider().getVendorId(id);
      if (getVendor.success) {
        loginData = getVendor.data!;

        if (id == 1) {
          //Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDhaba()),
          );
        } else {
          //Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddFootwear(title: title, id: id)),
          );
        }
      } else {
        if (id == 1) {
        } else {
          //Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VendorForm(title: title, id: id)));
        }
      }

      // SharedPref.setStringPreference(SharedPref.USERSTATUS, loginData.status);

    } else {
      Fluttertoast.showToast(
          backgroundColor: ColorPrimary,
          textColor: Colors.white,
          msg: "Please turn on  internet");
    }
    return loginData;
    _tap = true;
  }

  getCategories() async {
    if (await Network.isConnected()) {
      result = await ApiProvider().getCategoriess();
      print(result);
      if (result!.success) {
        categorieslist = result!.data!;
        id = categorieslist[1].id;
        subject.add(result!.data!);
      } else {
        // Fluttertoast.showToast(msg: "msg1");
      }
    } else {
      Fluttertoast.showToast(msg: "Please turn on  internet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(102, 87, 244, 1),
          leading: Builder(
            builder: (BuildContext context) {
              return InkWell(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 15, 15),
                  child: Image.asset('images/@3x/w-menu.png'),
                ),
                onTap: () {
                  widget.onTab();
                },
              );
            },
          ),
          title: searching
              ? TextFormField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 8, 5, 8),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Category',
                    hintStyle: TextStyle(
                        color: Color.fromRGBO(85, 85, 85, 1),
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (text) {
                    List<CategoriesResponseData> searchList = [];
                    if (text.isNotEmpty) {
                      print("searchText -->$text");

                      log("ram ${result!.data!}");
                      for (int i = 0; i < result!.data!.length; i++) {
                        if (result!.data![i].categoryName
                            .toLowerCase()
                            .contains(text.toLowerCase())) {
                          print("Container -->$text");
                          searchList.add(result!.data![i]);
                          log("ram ${result!.data![i].categoryName}");
                        } else {
                          print("Container -->data not found");
                        }
                      }

                      subject.add(searchList);
                    } else {
                      subject.add(categorieslist);
                    }
                  },
                )
              : Text('Home',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            searching
                ? IconButton(
                    icon: const Icon(Icons.close),
                    iconSize: 25,
                    onPressed: () {
                      _searchController.clear();
                      subject.add(categorieslist);
                      searching = false;
                      setState(() {});
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search_outlined),
                    iconSize: 25,
                    onPressed: () {
                      searching = true;
                      setState(() {});
                    },
                  ),
          ],
        ),
        body: StreamBuilder<List<CategoriesResponseData>>(
            stream: subject.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Data Not Found "),
                );
              }
              return categoryListWidget(snapshot.data!);
            }),
      ),
    );
  }

  Widget categoryListWidget(List<CategoriesResponseData> category) {
    return ListView.builder(
        itemCount: category.length,
        itemBuilder: (context, index) {
          return Container(
            // padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xfff4f4f4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              minLeadingWidth: 20,
              leading: CachedNetworkImage(
                imageUrl: "${category[index].image}",
                imageBuilder: (context, imageProvider) {
                  return Image(
                      image: imageProvider,
                      //color: ColorPrimary,
                      height: 25,
                      //colorBlendMode: BlendMode.clear,
                      fit: BoxFit.contain);
                },
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Icon(
                  Icons.image,
                  color: ColorPrimary,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              // Image.network('${result!.data![index].image}', width: 20),
              title: Container(
                transform: Matrix4.translationValues(0, -2, 0),
                child: AutoSizeText(
                  "${category[index].categoryName}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                  minFontSize: 12,
                  maxFontSize: 14,
                ),
              ),
              trailing: ButtonTheme(
                minWidth: 80,
                height: 32,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  color: Color.fromRGBO(102, 87, 244, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    //int id;
                    if (_tap == true) {
                      _tap = false;
                      getVendorId(
                          category[index].id, category[index].categoryName);
                    }
                  },
                  child: Text(
                    "Add Form",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
