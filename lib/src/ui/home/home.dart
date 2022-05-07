import 'dart:collection';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:employee/model/categories_respnse.dart';
import 'package:employee/model/getvenordbyid_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/add_dhaba/add_dhaba.dart';
import 'package:employee/src/ui/added_vendor_list/added_vendor_list.dart';
import 'package:employee/src/ui/login/login.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../model/vendor_send_notification.dart';
import 'notification_screen/notification_screen.dart';

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
  List<VendorNotificationData> notificationList = [];
  int? notifiicationlistlength;
  final PublishSubject<List<CategoriesResponseData>> subject = PublishSubject();
  List<GetVendorByIdResponseData> loginData = [];
  int count = 0, isReadCount = 0, totalnotification = 0;

  @override
  void initState() {
    super.initState();
    getCategories();
    getNotifications();

    _tap = true;
  }

  getNotifications() async {
    log("message");
    String userId = await SharedPref.getStringPreference(SharedPref.VENDORID);
    Map input = HashMap();
    input["employee_id"] = userId;
    log("$input");
    if (await Network.isConnected()) {
      VendorNotificationResponse response = await ApiProvider().getNotifications(input);
      log("=======:> ${response.message}");
      if (response.success) {
        notificationList = response.data!;

        log("=======>$notificationList");
        notifiicationlistlength = response.data!.length;
        log("=====>${isReadCount}");
        log("====>${count}");

        response.data!.forEach((element) {
          log("=====>${element.isRead}");
          if (element.isRead == 0) {
            isReadCount++;
          }
          setState(() {
            count = isReadCount - totalnotification;
          });
        });
      } else {}
      log("=======>$notifiicationlistlength");
      setState(() {});
    } else {
      _displayDialogInternet(context);
    }
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
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

        // if (id == 1) {
        //   //Navigator.pop(context);
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => AddDhaba()),
        //   );
        // } else {
        //Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddedVendor(title: title, id: id)),
        );
        // }
      } else {
        if (id == 1) {
        } else {
          //Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddedVendor(title: title, id: id)));
        }
      }

      // SharedPref.setStringPreference(SharedPref.USERSTATUS, loginData.status);

    } else {
      Fluttertoast.showToast(backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
    }
    _tap = true;
    return loginData;
  }

  // Future<NotificationListResponse> getNotificationCount() async {
  //   try {
  //     var token = await SharedPref.getStringPreference('token');
  //     Response res = await dio.get(
  //       "http://employee.tekzee.in/api/v1/getNotificatonList",
  //       options: Options(headers: {"Authorization": "Bearer ${token}"}),
  //     );
  //     NotificationListResponse count = NotificationListResponse.fromJson(res.toString());
  //     notificationList = count.data!;
  //     setState(() {});
  //     return count;
  //   } catch (error) {
  //     String message = "";
  //     if (error is DioError) {
  //       ServerError e = ServerError.withError(error: error);
  //       message = e.getErrorMessage();
  //     } else {
  //       message = "Please try again later!";
  //     }
  //     print("Exception occurred: $message stackTrace: $error");
  //     return NotificationListResponse(success: false, message: message);
  //   }
  // }

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
                    hintStyle:
                        TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontSize: 12, fontWeight: FontWeight.w600),
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
                        if (result!.data![i].categoryName.toLowerCase().contains(text.toLowerCase())) {
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
              : Text('Home', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          centerTitle: true,
          actions: [
            searching
                ? IconButton(
                    icon: const Icon(Icons.close),
                    iconSize: 25,
                    onPressed: () async {
                      _searchController.clear();
                      subject.add(categorieslist);
                      searching = false;
                      setState(() {});
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.search_outlined),
                    iconSize: 25,
                    onPressed: () async {
                      searching = true;
                      setState(() {});
                    },
                  ),
            Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                  ),
                  onPressed: () {
                    notificationList.isNotEmpty
                        ? Navigator.push(context,
                                MaterialPageRoute(builder: (context) => NotificationScreen(data: notificationList)))
                            .then((value) {
                            setState(() {
                              count -= value as int;
                            });
                          })
                        : Fluttertoast.showToast(msg: "No Notification!", backgroundColor: ColorPrimary);
                  },
                ),
                notificationList.isNotEmpty
                    ? Positioned(
                        right: 10,
                        top: 8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            height: 14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: ColorPrimary, width: 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: Text(
                                  count.toString(),
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: ColorPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    : Container()
              ],
            ),
          ],
        ),
        body: StreamBuilder<List<CategoriesResponseData>>(
            stream: subject.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              //  if(snapshot.connectionState == ConnectionState.)
              if (snapshot.hasError) {
                return Center(
                  child: Text("Data Not Found "),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Image(
                      image: AssetImage("images/no_search.gif"),
                      fit: BoxFit.contain,
                    ),
                  );
                }
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
                  return Container(
                    padding: EdgeInsets.all(5),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image(
                        image: imageProvider,
                        //color: ColorPrimary,
                        height: 20,
                        width: 20,
                        //colorBlendMode: BlendMode.clear,
                        fit: BoxFit.contain),
                  );
                },
                progressIndicatorBuilder: (context, url, downloadProgress) => Icon(
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
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
                      if (category[index].id == 12) {
                        getVendorId(category[index].id, category[index].categoryName);
                      } else {
                        getVendorId(category[index].id, category[index].categoryName);
                      }
                    }
                  },
                  child: Text(
                    "Add Form",
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          );
        });
  }

  _displayDialogInternet(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: RichText(
                text: TextSpan(
                  text: "Check Your Internet Connectivity",
                  style: GoogleFonts.openSans(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              actions: <Widget>[
                Center(
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.40,
                    height: 50,
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: ColorPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      if (await Network.isConnected()) {
                        getCategories();
                        getNotifications();
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                            backgroundColor: ColorPrimary, textColor: Colors.white, msg: "Please turn on  internet");
                      }
                    },
                    child: new Text(
                      "Ok",
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
}
