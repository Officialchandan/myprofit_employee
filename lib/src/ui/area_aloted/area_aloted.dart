// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:employee/model/get_location_response.dart';
// import 'package:employee/provider/api_provider.dart';

// class AreaAloted extends StatefulWidget {
//   AreaAloted({Key? key}) : super(key: key);

//   @override
//   _AreaAlotedState createState() => _AreaAlotedState();
// }

// class _AreaAlotedState extends State<AreaAloted> {
//   GetAlotedAreaResponse? res;
//   var success;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // success = res!.success;
//     getArea();
//     // log("${res!.}");
//   }

//   getArea() async {
//     res = await ApiProvider().getAlotedArea();
//     setState(() {});
//     success = res!.success;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Container(
//           child: success == true && res != null
//               ? ListView.builder(
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text("${res!.data![index].locationName}"),
//                     );
//                   })
//               : res != null
//                   ? Center(
//                       child: Text("Data Not Found"),
//                     )
//                   : Center(child: CircularProgressIndicator(color: ColorPrimary,))),
//           //
//         ));
//   }
// }
import 'dart:developer';

import 'package:employee/model/get_location_response.dart';
import 'package:employee/provider/api_provider.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/sharedpref.dart';
import 'package:flutter/material.dart';

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.index,
  });

  final String label;
  final EdgeInsets padding;
  final int groupValue;
  final int value;
  final Function onChanged;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<int>(
              groupValue: groupValue,
              value: value,
              onChanged: (int? newValue) {
                onChanged(newValue);
              }),
          Text(
            "$label",
            style: TextStyle(color: ColorPrimary, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class AreaAloted extends StatefulWidget {
  const AreaAloted({Key? key}) : super(key: key);

  @override
  State<AreaAloted> createState() => _AreaAlotedState();
}

class _AreaAlotedState extends State<AreaAloted> {
  int _isRadioSelected = -1;
  GetAlotedAreaResponse? res;
  var success;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // success = res!.success;
    getArea();
    // log("${res!.}");
  }

  getArea() async {
    res = await ApiProvider().getAlotedArea();

    success = res!.success;
    log("====>${await SharedPref.setIntegerPreference(SharedPref.LOCATION, res!.data![0].id)}");
    log("====>${await SharedPref.getIntegerPreference(SharedPref.LOCATION)}");
    await SharedPref.setIntegerPreference(SharedPref.LOCATION, res!.data![0].id);
    _isRadioSelected = res!.data![0].id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: success == true && res != null
              ? res!.data!.isEmpty
                  ? Text("")
                  : ListView.builder(
                      itemCount: res!.data!.length,
                      itemBuilder: (context, index) {
                        return LinkedLabelRadio(
                          label: '${res!.data![index].locationName}',
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          index: index,
                          value: res!.data![index].id,
                          groupValue: _isRadioSelected,
                          onChanged: (int newValue) {
                            setState(() {
                              _isRadioSelected = newValue;
                            });
                          },
                        );
                      })
              : res != null
                  ? Center(
                      child: Text("Area not allocated"),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      color: ColorPrimary,
                    ))),
    );
  }
}
