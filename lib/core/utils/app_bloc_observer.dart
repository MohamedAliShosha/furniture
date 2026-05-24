import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('${bloc.runtimeType} changed: $change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    log('${bloc.runtimeType} closed');
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    log('${bloc.runtimeType} created');
    super.onCreate(bloc);
  }
}
