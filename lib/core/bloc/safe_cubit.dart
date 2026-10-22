import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  bool safeEmit(State state) {
    if (isClosed) return false;
    emit(state);
    return true;
  }
}
