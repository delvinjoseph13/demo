import 'dart:convert';
import 'dart:math';

import 'package:apidemo/model/company.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  String baseUrl = "https://retoolapi.dev/nTYr51/";

  getAllCompany() async {
    try {
      List<Company> allCompany = [];

      var response = await http.get(Uri.parse(baseUrl + 'company'));
      if (response.statusCode == 200) {
        var data = response.body;
        var jsonData = jsonDecode(data);
        print(jsonData);
        for (var company in jsonData) {
          Company newCompany = Company.fromJson(company);
          allCompany.add(newCompany);
        }
        return allCompany;
      } else {
        throw Exception(
            "Error is occured while fetching the data ${response.statusCode}");
      }
    } catch (e) {
      print("This is the error ${e.toString()}");
    }
  }

  createCompany(Company company) async {
    try {
      var response = await http.post(Uri.parse(baseUrl + 'company'),
          body: company.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        print("The company details are ${response.body}");
      } else {
        throw Exception(
            "Error is occured while fetching the data ${response.statusCode}");
      }
    } catch (e) {
      print("This is the error ${e.toString()}");
    }
  }

  updateCompany(Company company, int id) async {
    try {
      var response = await http.put(Uri.parse(baseUrl + 'company' + '/$id'), body: company.toJson());

      

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is suceesfully deleted with the following details:  ${response.body}");
      }else {
        throw Exception(
            "Error is occured while fetching the data ${response.statusCode}");
      }
    } catch (e) {
      print("This is the error ${e.toString()}");
    }
  }

  deleteCompany(int id) async {
    try {
      var response = await http.delete(Uri.parse(baseUrl + 'company' + '/$id'));
      if (response.statusCode == 204 || response.statusCode == 200) {
        print("The company details are  deleted ${response.body}");
      } else {
        throw Exception(
            "Error is occured while fetching the data ${response.statusCode}");
      }
    } catch (e) {
      print("This is the error ${e.toString()}");
    }
  }
}
