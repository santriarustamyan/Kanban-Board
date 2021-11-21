import 'package:equatable/equatable.dart';
import 'package:kanban_boards/model/card.dart';
import 'package:uuid/uuid.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();
}

class LoadingInitial extends LoadingState {
  @override
  List<Object> get props => [];
}

class UserLoded extends LoadingState {
  const UserLoded({this.card});
  final CardModel? card;
  @override
  List<Object> get props => [card!];
}

class UserNotLoaded extends LoadingState {
  final String key = Uuid().v4();
  @override
  List<Object> get props => [key];
}
