import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employee/model/notfication_list.dart';
import 'package:employee/model/update-notification.dart';
import 'package:employee/model/vendor_send_notification.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/src/ui/home/notification_screen/bloc/notification_state.dart';
import 'package:employee/src/ui/home/notification_screen/bloc/notofication_event.dart';
import 'package:employee/utils/network.dart';
import 'package:employee/utils/sharedpref.dart';

class NotificationBloc extends Bloc<NotificationEvents, NotificationStates> {
  NotificationBloc() : super(GetNotificationInitialState());
  @override
  Stream<NotificationStates> mapEventToState(NotificationEvents event) async* {
    if (event is GetNotificationEvent) {
      yield GetNotificationLoadingState();
      yield* getNotifications(event);
    }
    if (event is MarkAsReadEvent) {
      yield* markAsRead(event);
    }
  }

  Stream<NotificationStates> getNotifications(
      GetNotificationEvent event) async* {
    log("message");
    String userId = await SharedPref.getStringPreference(SharedPref.VENDORID);
    Map input = HashMap();
    input["employee_id"] = userId;
    log("$input");
    if (await Network.isConnected()) {
      VendorNotificationResponse response =
          await ApiProvider().getNotifications(input);
      if (response.success) {
        yield GetNotificationSuccessState(data: response.data!);
      } else {
        yield GetNotificationFailureState(message: response.message);
      }
    } else {
      yield GetNotificationFailureState(message: "Please turn on  internet");
    }
  }

  Stream<NotificationStates> markAsRead(MarkAsReadEvent event) async* {
    if (await Network.isConnected()) {
      UpdateNotificationStatus response =
          await ApiProvider().markAsReadNotification(event.input);
      if (response.success) {
        yield MarkAsReadSucessState(message: response.message);
      } else {
        yield MarkAsReadFailureState(message: response.message);
      }
    } else {
      yield MarkAsReadFailureState(
        message: "Please turn on  internet",
      );
    }
  }
}
