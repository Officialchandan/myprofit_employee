import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myprofit_employee/model/categories_respnse.dart';
import 'package:myprofit_employee/provider/api_provider.dart';
import 'package:myprofit_employee/src/ui/add_dhaba/add_dhaba.dart';
import 'package:myprofit_employee/src/ui/add_footwear/add_footwear.dart';
import 'package:myprofit_employee/src/ui/login/login.dart';
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
  Future<List<CategoriesResponseData>> getCategories() async {
    result = await ApiProvider().getCategoriess();
    print(result);
    return result!.data!;
  }

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

  List<CategoriesResponseData> searchList = [];
  var setAddFormRoute = [
    AddDhaba(),
  ];

  TextEditingController _searchController = TextEditingController();

  String searchText = "";
  bool searching = false;

  final subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    subject.stream
        .debounceTime(Duration(milliseconds: 50))
        .listen((searchText) {
      this.searchText = searchText;
      if (searchText.isNotEmpty) {
        print("searchText -->$searchText");
        searchList.clear();
        log("ram ${result!.data!}");
        for (int i = 0; i < result!.data!.length; i++) {
          if (result!.data![i].categoryName
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            print("Container -->$searchText");
            searchList.add(result!.data![i]);
            log("ram ${result!.data![i].categoryName}");
          }
        }
      } else {
        searchList.clear();
      }
      setState(() {});
    });
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
                    subject.add(text);
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
                      searching = false;
                      _searchController.clear();
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
        body: FutureBuilder<List<CategoriesResponseData>>(
            future: getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Data Not Found"),
                );
              }
              return categoryListWidget();
            }),
      ),
    );
  }

  Widget categoryListWidget() {
    List<CategoriesResponseData> category = [];
    log("k ${searchList}");
    if (searchList.isEmpty) {
      print("searching -->$searching");
      category = result!.data!;
    } else {
      category = searchList;
    }
    bool someObjects = false;
    return ListView.builder(
        // reverse: true,
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
                    if (await Network.isConnected()) {
                      SystemChannels.textInput.invokeMethod("TextInput.hide");
                      print("kai kroge +");
                      //  getCategories();
                      if (category[index].id == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddDhaba()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFootwear(
                                  title: "${category[index].categoryName}",
                                  id: category[index].id)),
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                          backgroundColor: ColorPrimary,
                          textColor: Colors.white,
                          msg: "Please turn on  internet");
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
