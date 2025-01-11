import 'package:bloc_teacher/counter_bloc.dart';
import 'package:bloc_teacher/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final counterBloc = CounterBloc();
    return MultiBlocProvider(providers: [
      BlocProvider<CounterBloc>(create: (_) => counterBloc),
      BlocProvider<UserBloc>(create: (_) => UserBloc(counterBloc)),
    ], child: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncEvent());
            },
            icon: const Icon(Icons.plus_one),
          ),
          IconButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecEvent());
            },
            icon: const Icon(Icons.exposure_minus_1),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<UserBloc>()
                  .add(UserGetUserEvent(context.read<CounterBloc>().state));
            },
            icon: const Icon(Icons.supervised_user_circle_outlined),
          ),
          IconButton(
            onPressed: () {
              context
                  .read<UserBloc>()
                  .add(UserGetUserJob(context.read<CounterBloc>().state));
            },
            icon: const Icon(Icons.work),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                final users =
                    context.select((UserBloc bloc) => bloc.state.users);

                return Column(
                  children: [
                    Text(state.toString(), style: TextStyle(fontSize: 33)),
                    if (users.isNotEmpty)
                      ...users.map((el) => Text(el.name + "use")),
                  ],
                );
              },
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final jobs = context.select((UserBloc bloc) => bloc.state.job);
                return Column(
                  children: [
                    if (state.isLoading) const CircularProgressIndicator(),
                    if (jobs.isNotEmpty)
                      ...jobs.map((el) => Text(el.id + "job"))
                  ],
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
