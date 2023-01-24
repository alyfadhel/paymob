import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/bloc/cubit/states.dart';
import 'package:paymob/models/auth.dart';
import 'package:paymob/models/registration_order.dart';
import 'package:paymob/network/constance/constance.dart';
import 'package:paymob/network/remote/dio_helper.dart';

class PayMobCubit extends Cubit<PayMobStates> {
  PayMobCubit() : super(InitialPayMobState());

  static PayMobCubit get(context) => BlocProvider.of(context);

  Auth? auth;

  Future<void> getAuth() async {
    emit(GetAuthPayMobLoadingState());

    await DioHelper.postData(
      url: AppConstance.authEndPoint,
      data: {
        'api_key': AppConstance.apiKey,
      },
    ).then((value) {
      auth = Auth.fromJson(value.data);
      AppConstance.paymentFirstToken = auth!.token;
      debugPrint('First Token : ${AppConstance.paymentFirstToken}');
      emit(GetAuthPayMobSuccessState());
    }).catchError((error) {
      emit(GetAuthPayMobErrorState(error.toString()));
      debugPrint('Error is : ${error.toString()}');
    });
  }



  Future<void> getOrderId({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(GetRegistrationOrderLoadingState());
    await DioHelper.postData(
      url: AppConstance.orderIdPoint,
      data: {
        "auth_token":  AppConstance.paymentFirstToken,
        "delivery_needed": "false",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      },
    ).then((value){
     RegistrationOrder registrationOrder = RegistrationOrder.fromJson(value.data);
      AppConstance.paymentOrderId = registrationOrder.id.toString();
      debugPrint('The Order Id: ${AppConstance.paymentOrderId}');
      emit(GetRegistrationOrderSuccessState());
    }).catchError((error)
    {
      emit(GetRegistrationOrderErrorState(error.toString()));
      debugPrint('The Error is: ${error.toString()}');
    });
  }
}
