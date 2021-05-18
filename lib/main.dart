import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lofi/pages/home.dart';
import 'package:lofi/pages/playing.dart';

import 'bloc/lofi_bloc.dart';
import 'data/lofi_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'BalsamiqSans', backgroundColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<LofiBloc>(
        create: (context) => LofiBloc(LofiRepo()),
        child: Home(),
      ),
    );
  }
}
