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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();
  final userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (_) => counterBloc),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
      child: BlocProvider<CounterBloc>(
        create: (context) => counterBloc,
        child: Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  counterBloc.add(CounterIncEvent());
                },
                icon: const Icon(Icons.plus_one),
              ),
              IconButton(
                onPressed: () {
                  counterBloc.add(CounterDecEvent());
                },
                icon: const Icon(Icons.exposure_minus_1),
              ),
              IconButton(
                onPressed: () {
                  userBloc.add(UserGetUserEvent(counterBloc.state));
                },
                icon: const Icon(Icons.supervised_user_circle_outlined),
              ),
              IconButton(
                onPressed: () {
                  userBloc.add(UserGetUserJob(counterBloc.state));
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
                  bloc: counterBloc,
                  builder: (context, state) {
                    return Text(state.toString(),
                        style: TextStyle(fontSize: 33));
                  },
                ),
                BlocBuilder<UserBloc, UserState>(
                  bloc: userBloc,
                  builder: (context, state) {
                    final users = state.users;
                    final jobs = state.job;

                    return Column(
                      children: [
                        if (state.isLoading) const CircularProgressIndicator(),
                        if (users.isNotEmpty)
                          ...users.map((el) => Text(el.name + "use")),
                        if (jobs.isNotEmpty) ...jobs.map((el) => Text(el.id + "job"))
                      ],
                    );
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
