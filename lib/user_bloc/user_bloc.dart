import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_teacher/counter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final CounterBloc counterBloc;
  late final StreamSubscription counterBlocSubscription;

  UserBloc(this.counterBloc) : super(UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJob>(_onGetUserJob);

    counterBlocSubscription = counterBloc.stream.listen((state) {
      if (state <= 0) {
        add(UserGetUserEvent(0));
        add(UserGetUserJob(0));
      }
    });
  }

  @override
  Future<void> close() async {
    counterBlocSubscription.cancel();
    return super.close();
  }

  _onGetUser(UserGetUserEvent event, Emitter<UserState> emit) async {
    emit(state.coryWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));

    final users = List.generate(
        event.count,
        (index) => User(
              id: index.toString(),
              name: index.toString(),
            ));

    emit(state.coryWith(users: users));
  }

  _onGetUserJob(UserGetUserJob event, Emitter<UserState> emit) async {
    emit(state.coryWith(isLoading: true));
    await Future.delayed(Duration(seconds: 1));

    final job = List.generate(
        event.count,
        (index) => Job(
              id: index.toString(),
              name: index.toString(),
            ));

    emit(state.coryWith(job: job));
  }
}
