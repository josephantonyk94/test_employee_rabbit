part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class GetAllEmployeesOnline extends EmployeeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetAllEmployeesLocal extends EmployeeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ClearEmployeeSearch extends EmployeeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ToggleEmployeeSearch extends EmployeeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetEmployeeBySearch extends EmployeeEvent {
  final String? searchKey;

  GetEmployeeBySearch(this.searchKey);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
