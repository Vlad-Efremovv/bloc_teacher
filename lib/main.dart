import 'package:bloc_teacher/counter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    final bloc = CounterBloc();
    return BlocProvider<CounterBloc>(
      create: (context) => bloc,
      child: BlocBuilder<CounterBloc, int>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    bloc.add(CounterIncEvent());
                  },
                  icon: const Icon(Icons.plus_one),
                ),
                IconButton(
                  onPressed: () {
                    bloc.add(CounterDecEvent());
                  },
                  icon: const Icon(Icons.exposure_minus_1),
                ),
              ],
            ),
            body: Center(
                child: Text(state.toString(), style: TextStyle(fontSize: 33))),
          );
        },
      ),
    );
  }
}
