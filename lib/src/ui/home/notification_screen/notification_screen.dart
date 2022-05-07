import 'dart:collection';
import 'dart:developer';

import 'package:employee/model/vendor_send_notification.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../../model/update-notification.dart';
import '../../../../provider/api_provider.dart';
import '../../../../utils/network.dart';

class NotificationScreen extends StatefulWidget {
  List<VendorNotificationData> data;
  NotificationScreen({Key? key, required this.data}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    log("=>${widget.data}");
  }

  int isReadCount = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(isReadCount);
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop(isReadCount);
              },
            ),
            title: Text(
              "notification ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: widget.data.isEmpty
                  ? Center(
                      child: Text("No Notification!"),
                    )
                  : showNotifications(widget.data),
            ),
          ),
        ),
      ),
    );
  }

  Widget showNotifications(List<VendorNotificationData> data) {
    return ListView.separated(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: InkWell(
            onTap: () async {
              setState(() {
                if (data[index].isRead == 0) {
                  isReadCount++;
                }
                data[index].isRead = 1;
              });
              markAsRead(data[index].id);
            },
            child: Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          data[index].notificationDataDetails!.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: data[index].isRead == 1 ? Colors.grey : Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          data[index].notificationDataDetails!.body,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: data[index].isRead == 1 ? Colors.grey : Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat("dd MMM").format(DateTime.parse(data[index].createdAt)) +
                            " " +
                            DateFormat.jm().format(DateTime.parse(data[index].createdAt)),
                        style: TextStyle(
                            color: data[index].isRead == 1 ? Colors.grey : Colors.black54,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.black54,
      ),
    );
  }

  void getNotifications() async {
    log("yha aya hu mai");
  }

  // markAsRead(notificationid) async {}
  void markAsRead(int id) async {
    Map input = HashMap();
    String userId = await SharedPref.getStringPreference(SharedPref.VENDORID);
    input["id"] = id;
    input["employee_id"] = userId;

    if (await Network.isConnected()) {
      UpdateNotificationStatus response = await ApiProvider().markAsReadNotification(input);
      if (response.success) {
      } else {
        Fluttertoast.showToast(msg: "${response.message}");
      }
    } else {
      Fluttertoast.showToast(msg: "Please Turn on  Internet", backgroundColor: ColorPrimary);
    }
  }
}
