import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/default_;layout.dart';
import 'package:flutter_application_2/screen/future_provider_screen.dart';
import 'package:flutter_application_2/screen/state_notifier_provider.dart';
import 'package:flutter_application_2/screen/state_rprovider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StateProviderScreen())));
            },
            child: Text('StateProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => StateNotifierProviderScreen())));
            },
            child: Text('StateNotifierProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => FutureProviderScreen())));
            },
            child: Text('FutureProviderScreen'),
          )
        ],
      ),
    );
  }
}
