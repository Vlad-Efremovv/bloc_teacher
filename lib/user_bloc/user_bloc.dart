import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserGetUserEvent>(_onGetUser);
    on<UserGetUserJob>(_onGetUserJob);
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
