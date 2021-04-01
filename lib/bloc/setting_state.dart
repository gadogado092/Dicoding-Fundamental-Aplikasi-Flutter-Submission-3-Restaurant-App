import 'package:equatable/equatable.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class Initial extends SettingState {}

class Loading extends SettingState {}

class LoadData extends SettingState {
  final bool isActive;

  LoadData(this.isActive);
}