// import 'package:Employee/model/dhabas_day.dart';
// import 'package:Employee/provider/api_provider.dart';
// import 'package:bloc/bloc.dart';

// class DhabasDayBloc
//     extends Bloc<DhabasDayEvent, DhabasDayState> {
//   DhabasDayBloc() : super(DhabasDayInitialState());

//   @override
//   Stream<DhabasDayState> mapEventToState(
//       DhabasDayEvent event) async* {
//     if (event is GetDhabasDayEvent) {
//       yield* getDhabasDay();
//     }
//   }

//   Stream<DhabasDayState> getDhabasDay() async* {
//     // try {
//     DhabasDayResponse result = await ApiProvider().dhabasDay();
//     if (result.success) {
//       yield GetDhabasDayState(result.data);
//     } else {
//       yield GetDhabasDayFailureState(message: result.message);
//     }
//     // } catch (error) {
//     //   yield GetDhabasDayFailureState(
//     //       message: "internanl server error");
//     // }
//   }
// }
