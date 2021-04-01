import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class SetValue extends SettingEvent {
  final bool status;

  SetValue(this.status);
}

class GetValue extends SettingEvent {}
