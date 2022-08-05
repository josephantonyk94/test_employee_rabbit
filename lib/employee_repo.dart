import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_white_rabbit/employee.dart';

class EmployeeRepo {
  getAllEmployees() async {
    List<Employee> employyeeList;
    final sharedpref = await SharedPreferences.getInstance();
    String? res = sharedpref.get("employee_list") as String?;

    if (res != null) {
      employyeeList =
          List<Employee>.from(jsonDecode(res).map((e) => Employee.fromJson(e)));
      return employyeeList;
    }
    final response = await http
        .get(Uri.parse("http://www.mocky.io/v2/5d565297300000680030a986"));
    print(response.body);
    sharedpref.setString("employee_list", response.body);
    employyeeList = List<Employee>.from(
        jsonDecode(response.body).map((e) => Employee.fromJson(e)));
    print(employyeeList);
    return employyeeList;
  }
}
