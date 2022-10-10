import 'package:flutter/material.dart';

class CalTax {
  static const GTBT = 11000000; //Giam tru gia canh ban than nguoi nop thue
  static const GTPT = 4400000; //Giam tru gia canh moi nguoi phu thuoc
  static const incomeGaps = [
    5000000,
    10000000,
    18000000,
    32000000,
    52000000,
    80000000,
  ];

  static const List<Map<String, double>> taxLevels = [
    {
      'lvl': 1,
      'percent': 0.05, //thue suat
      'from': 0,
      'to': 5000000,
      'minus': 0,
    },
    {
      'lvl': 2,
      'percent': 0.1,
      'from': 5000000,
      'to': 10000000,
      'minus': 250000,
    },
    {
      'lvl': 3,
      'percent': 0.15,
      'from': 10000000,
      'to': 18000000,
      'minus': 750000,
    },
    {
      'lvl': 4,
      'percent': 0.2,
      'from': 18000000,
      'to': 32000000,
      'minus': 1650000,
    },
    {
      'lvl': 5,
      'percent': 0.25,
      'from': 32000000,
      'to': 52000000,
      'minus': 3250000,
    },
    {
      'lvl': 6,
      'percent': 0.3,
      'from': 52000000,
      'to': 80000000,
      'minus': 5850000,
    },
    {
      'lvl': 7,
      'percent': 0.35,
      'from': 80000000,
      'to': double.infinity,
      'minus': 9850000,
    }
  ]; //Giam tru gia canh doi voi moi nguoi phu thuoc

  static TextSpan calculateYourTax({String? totalIncome, String? dependent}) {
    if (totalIncome == null || totalIncome.isEmpty) {
      return const TextSpan(
        text: 'Vui lòng nhập thu nhập cá nhân!',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    if (dependent == null || dependent.isEmpty) {
      return const TextSpan(
        text: 'Vui lòng nhập số người phụ thuộc!',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    double? convertedIncome = double.tryParse(totalIncome);
    int? convertedDependent = int.tryParse(dependent);

    if (convertedIncome == null ||
        convertedDependent == null ||
        convertedIncome < 0 ||
        convertedDependent < 0) {
      return TextSpan(
        text:
            'Vui lòng nhập ${(convertedIncome == null || convertedIncome < 0) ? "thu nhập cá nhân đúng định dạng số không âm" : "số người phụ thuộc đúng định dạng số nguyên không âm"}',
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    //valid case
    if (convertedIncome >= 0 && convertedDependent >= 0) {
      if (convertedIncome <= GTBT + GTPT * convertedDependent) {
        return const TextSpan(
          text: '0 VND',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      }

      final thuNhapTinhThue =
          convertedIncome - (GTBT + GTPT * convertedDependent);

      late Map<String, double> findedTaxLevel;
      for (int i = 0; i < taxLevels.length; i++) {
        if (thuNhapTinhThue > (taxLevels[i]['from'] as double) &&
            thuNhapTinhThue <= (taxLevels[i]['to'] as double)) {
          findedTaxLevel = taxLevels[i];
          break;
        }
      }

      final taxResult =
          thuNhapTinhThue * (findedTaxLevel['percent'] as double) -
              (findedTaxLevel['minus'] as double);

      return TextSpan(
        text: '$taxResult VND',
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    //unknown exceptional cases
    return const TextSpan(
      text: 'Có lỗi xảy ra, vui lòng thử lại!',
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
