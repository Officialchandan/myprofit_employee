import 'dart:collection';
import 'dart:developer';

import 'package:employee/model/vendor_send_notification.dart';
import 'package:employee/src/ui/home/notification_screen/bloc/notification_bloc.dart';
import 'package:employee/src/ui/home/notification_screen/bloc/notification_state.dart';
import 'package:employee/src/ui/home/notification_screen/bloc/notofication_event.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  List<VendorNotificationData> data;
  NotificationScreen({Key? key, required this.data}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationBloc notificationBloc = NotificationBloc();
  @override
  void initState() {
    super.initState();
    log("=>${widget.data}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => notificationBloc,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
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
              child: BlocConsumer<NotificationBloc, NotificationStates>(
                listener: (context, state) {
                  if (state is MarkAsReadSucessState) {
                    getNotifications();
                    // Utility.showToast("Notification marked as a read");
                  }
                },
                builder: (context, state) {
                  if (state is GetNotificationLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GetNotificationSuccessState) {
                    return showNotifications(state.data!);
                  }

                  if (state is GetNotificationFailureState) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
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
    notificationBloc.add(GetNotificationEvent());
  }

  void markAsRead(int id) async {
    Map input = HashMap();
    String userId = await SharedPref.getStringPreference(SharedPref.VENDORID);

    input["id"] = id;
    input["employee_id"] = userId;
    notificationBloc.add(MarkAsReadEvent(input: input));

    Navigator.pop(context);
  }
}
