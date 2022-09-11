import 'dart:async';

import 'package:employee/model/getEmployee_AssignGift.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/network.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeAsignedGift extends StatefulWidget {
  const EmployeeAsignedGift({Key? key}) : super(key: key);

  @override
  State<EmployeeAsignedGift> createState() => _EmployeeAsignedGiftState();
}

class _EmployeeAsignedGiftState extends State<EmployeeAsignedGift> {
  GetEmployeeAssignGiftResponse? result;
  StreamController<List<GetEmployeeAssignGiftData>> subject = StreamController();
  List<GetEmployeeAssignGiftData> giftlist = [];
  getGift() async {
    if (await Network.isConnected()) {
      result = await ApiProvider().getGift();
      print(result);
      if (result!.success) {
        giftlist = result!.data!;

        subject.add(result!.data!);
      } else {
        // Fluttertoast.showToast(msg: "msg1");
      }
    } else {
      Fluttertoast.showToast(msg: "Please turn on  internet");
    }
  }

  @override
  void initState() {
    super.initState();
    getGift();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gift List"),
      ),
      body: Container(
        child: StreamBuilder<List<GetEmployeeAssignGiftData>>(
            stream: subject.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: ColorPrimary,
                ));
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
              return ListView.builder(
                  itemCount: giftlist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(0.0, 0.0), //(x,y)
                            blurRadius: 7.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: giftlist[index].giftImage.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image(
                                            image: NetworkImage("${giftlist[index].giftImage}"),
                                            height: 55,
                                            width: 55,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset("images/placeholder.png",
                                              height: 55, width: 55, fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: width * 0.38,
                                              child: Text(
                                                "${giftlist[index].giftName} ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              )),
                                          Text(
                                            'Available Qty: ${giftlist[index].availableQty}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, color: ColorPrimary, fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        width: width * 0.71,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${giftlist[index].barcode}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: ColorPrimary, fontSize: 14),
                                            ),
                                            Text(
                                              'Total Qty: ${giftlist[index].totalQty}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: ColorPrimary, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        width: width * 0.71,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Given Qty: ${giftlist[index].givenQty}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: ColorPrimary, fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
