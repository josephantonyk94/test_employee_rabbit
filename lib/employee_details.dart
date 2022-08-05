import 'package:flutter/material.dart';
import 'package:test_white_rabbit/employee.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key, required this.employee}) : super(key: key);
  final Employee employee;

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.employee.profileImage ??
                    "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
              ),
            ),
          ),
          Container(
            child: Text(
              widget.employee.name!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(20),
          ),
          Container(
            child: Text(
              "user name : " + (widget.employee.username ?? ""),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(5),
          ),
          Container(
            child: Text(
              "email : " + (widget.employee.email ?? ""),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(5),
          ),
          Container(
            child: Text(
              "phone : " + (widget.employee.phone ?? ""),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(5),
          ),
          Container(
            child: Text(
              "company : " + (widget.employee.company?.name ?? ""),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(5),
          ),
          Container(
            child: Text(
              "address : " +
                  (widget.employee.address?.suite ?? "") +
                  "\n" +
                  (widget.employee.address?.street ?? "") +
                  (widget.employee.address?.city ?? "") +
                  "\n",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.all(5),
          ),
        ],
      ),
    );
  }
}
