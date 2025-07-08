import 'package:flutter/foundation.dart';


@immutable
class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  

  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      
    );
  }
}