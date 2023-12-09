import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator_mobile/app/app.dart';
import 'package:locator_mobile/bootstrap.dart';
import 'package:locator_mobile/home/cubit/home_cubit.dart';
import 'package:locator_mobile/map/cubit/map_cubit.dart';

void main() {
  bootstrap(() =>  BlocProvider(
    lazy: false,
        create: (context) => HomeCubit(),
        child: const App(),
      ),);
}
