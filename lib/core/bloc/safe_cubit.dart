import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for every Cubit in the app.
///
/// A Cubit is closed when its route is popped. Any `emit` after that point
/// throws `StateError: Cannot emit new states after calling close`. This is
/// easy to hit because most Cubit methods `await` a repository call and then
/// emit: if the user navigates away while the request is in flight, the
/// response arrives after `close()`.
///
/// [safeEmit] drops such a late state instead of throwing, so callers do not
/// need an `if (isClosed) return;` before every emit.
///
/// Use [safeEmit] for any emit that happens *after* an `await`. A synchronous
/// emit at the start of a method (before the first await) can still use plain
/// `emit` — the Cubit cannot be closed between the call and that line.
abstract class SafeCubit<State> extends Cubit<State> {
  SafeCubit(super.initialState);

  /// Emits [state] unless this Cubit is already closed.
  ///
  /// Returns `true` when the state was emitted, `false` when it was dropped
  /// because the Cubit had been closed.
  bool safeEmit(State state) {
    if (isClosed) return false;
    emit(state);
    return true;
  }
}
