class RegistrationOrder {
  final int id;

  RegistrationOrder({
    required this.id,
  });

  factory RegistrationOrder.fromJson(Map<String, dynamic> json) {
    return RegistrationOrder(
      id: json['id'],
    );
  }
}
