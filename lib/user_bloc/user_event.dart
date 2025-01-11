part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserGetUserEvent extends UserEvent {
  final int count;

  UserGetUserEvent(this.count);
}

class UserGetUserJob extends UserEvent {
  final int count;

  UserGetUserJob(this.count);
}
