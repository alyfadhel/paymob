import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob/bloc/cubit/states.dart';
import 'package:paymob/models/auth.dart';
import 'package:paymob/models/payment_request.dart';
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
        "auth_token": AppConstance.paymentFirstToken,
        "delivery_needed": "false",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      },
    ).then((value) {
      RegistrationOrder registrationOrder =
          RegistrationOrder.fromJson(value.data);
      AppConstance.paymentOrderId = registrationOrder.id.toString();
      getPaymentRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        price: price,
      );
      debugPrint('The Order Id: ${AppConstance.paymentOrderId}');
      //emit(GetRegistrationOrderSuccessState());
    }).catchError((error) {
      emit(GetRegistrationOrderErrorState(error.toString()));
      debugPrint('The Error is: ${error.toString()}');
    });
  }

  Future<void> getPaymentRequest({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(GetPaymentRequestLoadingState());
    await DioHelper.postData(
      url: AppConstance.getPaymentRequest,
      data: {
        "auth_token": AppConstance.paymentFirstToken,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": AppConstance.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": AppConstance.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value)
    {
      PaymentRequestModel paymentRequestModel = PaymentRequestModel.fromJson(value.data);
      AppConstance.finalToken = paymentRequestModel.token;
      debugPrint('The Final Token : ${AppConstance.finalToken}');
      emit(GetPaymentRequestSuccessState());
    }).catchError((error)
    {
      emit(GetPaymentRequestErrorState(error.toString()));
      debugPrint('The Error is: ${error.toString()}');
    });
  }
}
//The Final Token : ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnNiMk5yWDI5eVpHVnlYM2RvWlc1ZmNHRnBaQ0k2Wm1Gc2MyVXNJbTl5WkdWeVgybGtJam81TlRrM09EUTNPU3dpWlhod0lqb3hOamMwTmpNNU5URTNMQ0p6YVc1bmJHVmZjR0Y1YldWdWRGOWhkSFJsYlhCMElqcG1ZV3h6WlN3aVpYaDBjbUVpT250OUxDSnBiblJsWjNKaGRHbHZibDlwWkNJNk16TXlOekUxTVN3aVlXMXZkVzUwWDJObGJuUnpJam94TURBc0luQnRhMTlwY0NJNklqUTFMakkwTmk0eU1UQXVNVGN5SWl3aWRYTmxjbDlwWkNJNk1URTFOalEyT0N3aVltbHNiR2x1WjE5a1lYUmhJanA3SW1acGNuTjBYMjVoYldVaU9pSmhiSGtpTENKc1lYTjBYMjVoYldVaU9pSm1ZV1JsYkNJc0luTjBjbVZsZENJNklrNUJJaXdpWW5WcGJHUnBibWNpT2lKT1FTSXNJbVpzYjI5eUlqb2lUa0VpTENKaGNHRnlkRzFsYm5RaU9pSk9RU0lzSW1OcGRIa2lPaUpPUVNJc0luTjBZWFJsSWpvaVRrRWlMQ0pqYjNWdWRISjVJam9pVGtFaUxDSmxiV0ZwYkNJNkltRnNlUzVsYkdWM2FXbEFlV0ZvYjI4dVkyOXRJaXdpY0dodmJtVmZiblZ0WW1WeUlqb2lNREV3T1RnNU1UTXpPVGNpTENKd2IzTjBZV3hmWTI5a1pTSTZJazVCSWl3aVpYaDBjbUZmWkdWelkzSnBjSFJwYjI0aU9pSk9RU0o5TENKamRYSnlaVzVqZVNJNklrVkhVQ0o5LkxJVThGOVN1STlucUNyY243T0o1UkxpVjhodzJBYjFPOWhBajk1aE10Y041SkgzRkFwWEZkUjFnd0VIeDlBUldsY0ZiVXpnc1Jwc1pMaWJ3ZG1Ke