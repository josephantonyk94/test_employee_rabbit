import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_white_rabbit/employee.dart';
import 'package:test_white_rabbit/employee_repo.dart';

import 'employee_state.dart';

part 'employee_event.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  List<Employee> employeeList = [];
  List<Employee> filteredList = [];
  TextEditingController filterController = TextEditingController();
  String selectedSearch = "name";
  String? error;
  bool isFiltered = false;
  EmployeeBloc() : super(EmployeeInitial()) {
    filterController.addListener(() {
      add(GetEmployeeBySearch(filterController.text));
    });

    on<GetAllEmployeesOnline>((event, emit) async {
      emit(EmployeeListLoading());
      employeeList = await EmployeeRepo().getAllEmployees();
      emit(EmployeeListLoaded(
          employeeList, filteredList, isFiltered, selectedSearch, error));
    });
    on<GetEmployeeBySearch>(
      (event, emit) {
        filteredList = employeeList
            .where((e) => ((selectedSearch == "name" ? e.name! : e.email!)
                .toLowerCase()
                .contains(event.searchKey!.toLowerCase())))
            .toList();
        isFiltered = true;
        if (filteredList.isEmpty) {
          error =
              "No result found for $selectedSearch ${filterController.text}";
        }
        emit(EmployeeListLoaded(
            employeeList, filteredList, isFiltered, selectedSearch, error));
      },
    );
    on<ClearEmployeeSearch>((event, emit) {
      filteredList = [];
      filterController.clear();
      isFiltered = false;
      emit(EmployeeListLoaded(
          employeeList, filteredList, isFiltered, selectedSearch, error));
    });
    on<ToggleEmployeeSearch>((event, emit) {
      if (isFiltered) {
        isFiltered = false;
      } else {
        isFiltered = true;
        filteredList = [];
        filterController.clear();
      }
      emit(EmployeeListLoaded(
          employeeList, filteredList, isFiltered, selectedSearch, error));
    });
  }

  changeSearchOption(String val) {
    selectedSearch = val;
    emit(EmployeeListLoaded(
        employeeList, filteredList, isFiltered, selectedSearch, error));
  }
}
