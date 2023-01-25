class AppConstance
{
  //https://accept.paymob.com/api/auth/tokens
  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String authEndPoint = '$baseUrl/auth/tokens';
  static const String orderIdPoint = '$baseUrl/ecommerce/orders';
  static const String getPaymentRequest = '$baseUrl/acceptance/payment_keys';
  static const String apiKey = 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnVZVzFsSWpvaU1UWTNORFUyTXpFd05TNDJPVEV4TWpNaUxDSndjbTltYVd4bFgzQnJJam8yT0RFeE1qY3NJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlmUS5kb3J1QXFfMTg3eHlvZFJVNzZvY2N2VENnamJpMDhaLWZUSFBkSGsxbllQSXFOQXd2OXo2YzFCdzdiNWVCOU5XWmROaUdOR0lvQnpoLVFSMXZJM3Rodw==';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/724618?payment_token=$finalToken';

  static String? paymentFirstToken = '';
  static String finalToken = '';
  static String paymentOrderId = '';
  static String refCode = '';
  static const String integrationIdCard = '3327151';
  static const String integrationIdKiosk = '3327171';
}

class AppImages {
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
}