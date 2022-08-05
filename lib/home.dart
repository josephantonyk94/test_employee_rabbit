import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_white_rabbit/bloc/employee_bloc.dart';
import 'package:test_white_rabbit/bloc/employee_state.dart';
import 'package:test_white_rabbit/employee_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    context.read<EmployeeBloc>().add(GetAllEmployeesOnline());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (BuildContext context, state) {
          switch (state.runtimeType) {
            case EmployeeListLoading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case EmployeeListLoaded:
              var employeeListLoaded = state as EmployeeListLoaded;
              return Column(
                children: [
                  AppBar(
                    // The search area here
                    title: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: TextField(
                          controller:
                              context.read<EmployeeBloc>().filterController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: state.isFiltered
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        context
                                            .read<EmployeeBloc>()
                                            .add(ClearEmployeeSearch());
                                      },
                                    )
                                  : PopupMenuButton<String>(
                                      initialValue: state.selectedSearch,
                                      itemBuilder: (context) =>
                                          <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: "name",
                                              child: Text('Search By Name'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: "email",
                                              child: Text('Search By Email'),
                                            ),
                                          ],
                                      onSelected: (val) {
                                        context
                                            .read<EmployeeBloc>()
                                            .changeSearchOption(val);
                                      }),
                              hintText: 'Search...',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: employeeListLoaded.isFiltered &&
                            employeeListLoaded.filteredList.isEmpty
                        ? SizedBox.expand(
                            child: Center(
                                child: Text(employeeListLoaded.error ?? "")),
                          )
                        : ListView.builder(
                            itemCount: employeeListLoaded.isFiltered
                                ? employeeListLoaded.filteredList.length
                                : employeeListLoaded.employeeList.length,
                            itemBuilder: (context, index) {
                              var employee = employeeListLoaded.isFiltered
                                  ? employeeListLoaded.filteredList[index]
                                  : employeeListLoaded.employeeList[index];
                              return ListTile(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeDetails(
                                            employee: employee))),
                                leading: Image.network(employee.profileImage ??
                                    "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"),
                                title: Text(employee.name!),
                                subtitle: Text(employee.company?.name ?? ""),
                              );
                            }),
                  )
                ],
              );
            case EmployeeListError:
              return Center(
                child: Text("employyeelist error"),
              );
            case EmployeeInitial:
              return Center(
                child: Text("employyeelist initial"),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
