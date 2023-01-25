abstract class PayMobStates{}

class InitialPayMobState extends PayMobStates{}

class GetAuthPayMobLoadingState extends PayMobStates{}
class GetAuthPayMobSuccessState extends PayMobStates{}
class GetAuthPayMobErrorState extends PayMobStates
{
  final String error;

  GetAuthPayMobErrorState(this.error);

}


class GetRegistrationOrderLoadingState extends PayMobStates{}
class GetRegistrationOrderSuccessState extends PayMobStates{}
class GetRegistrationOrderErrorState extends PayMobStates
{
  final String Error;

  GetRegistrationOrderErrorState(this.Error);
}

class GetPaymentRequestLoadingState extends PayMobStates{}
class GetPaymentRequestSuccessState extends PayMobStates{}
class GetPaymentRequestErrorState extends PayMobStates
{
  final String error;

  GetPaymentRequestErrorState(this.error);

}

class GetRefCodeLoadingState extends PayMobStates{}
class GetRefCodeSuccessState extends PayMobStates{}
class GetRefCodeErrorState extends PayMobStates
{
  final String error;

  GetRefCodeErrorState(this.error);
}