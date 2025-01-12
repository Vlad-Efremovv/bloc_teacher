import 'package:bloc_teacher/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_user_repository/search_user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => SearchUserRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SearchBloc(
                searchUserRepository:
                    RepositoryProvider.of<SearchUserRepository>(context)),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
                // bodyText2: TextStyle(fontSize: 33),
                // subtitle1: TextStyle(fontSize: 22),
                ),
          ),
          home: const Scaffold(
            body: SafeArea(
              child: MyHomePage(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.select((SearchBloc bloc) => bloc.state.users);
    return Column(
      children: [
        const Text('Search User'),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'User name',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<SearchBloc>().add(SearchUserEvent(value));
          },
        ),
        if (users.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.username ?? ""),
                  leading: Hero(
                      tag: user.username ?? '',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.images ?? ""),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserInfoScreen(user: user)));
                  },
                );
              },
              itemCount: users.length,
            ),
          ),
      ],
    );
  }
}

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    print(user.images);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Hero(
              tag: user.username ?? '',
              child: Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(user.images ?? ''))),
              )),
          Text(user.images ?? ''),
          Text(user.username ?? ''),
          Text(user.url ?? ''),
        ],
      ),
    );
  }
}
