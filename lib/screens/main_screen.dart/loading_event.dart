import 'package:equatable/equatable.dart';

abstract class LoadingEvent extends Equatable {
  const LoadingEvent();
}

class UserLoadedEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}

class UserNodeEvent extends LoadingEvent {
  @override
  List<Object> get props => [];
}
