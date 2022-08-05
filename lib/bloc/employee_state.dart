import 'package:equatable/equatable.dart';

import '../employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
}

class EmployeeInitial extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeListLoading extends EmployeeState {
  @override
  List<Object> get props => [];
}

class EmployeeListLoaded extends EmployeeState {
  final List<Employee> employeeList;
  final List<Employee> filteredList;
  final bool isFiltered;
  final String selectedSearch;
  final String? error;

  EmployeeListLoaded(this.employeeList, this.filteredList, this.isFiltered,
      this.selectedSearch, this.error);

  @override
  List<Object?> get props =>
      [employeeList, filteredList, isFiltered, selectedSearch, error];
}

class EmployeeListError extends EmployeeState {
  @override
  List<Object> get props => [];
}
