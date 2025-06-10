import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_bar_cubit/cubit/navigation_cubit.dart';
import 'package:navigation_bar_cubit/home.dart';
import 'package:navigation_bar_cubit/profile.dart';
import 'package:navigation_bar_cubit/wishlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<NavigationCubit>(
        create: (context) => NavigationCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
        switch(state.selectedIndex){
          case 0: 
          return Home();
          case 1 : 
          return Wishlist();
          case 2: 
          return Profile();
          default:return Container();
        }
      },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return NavigationBar(
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_max_outlined),
                label: 'Home',
                selectedIcon: Icon(Icons.home),
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                label: 'Wishlist',
                selectedIcon: Icon(Icons.favorite),
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
                selectedIcon: Icon(Icons.person),
              ),
            ],
            selectedIndex: state.selectedIndex,
            onDestinationSelected: (value) => context.read<NavigationCubit>().setSelectedIndex(value),
          );
        },
      ),
    );
  }
}
