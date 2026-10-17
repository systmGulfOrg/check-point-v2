import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class _CounterCubit extends SafeCubit<int> {
  _CounterCubit() : super(0);

  bool emitAfterClose() => safeEmit(1);

  Future<bool> emitAfterAwait() async {
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return safeEmit(42);
  }
}

void main() {
  group('SafeCubit.safeEmit', () {
    test('emits and reports true while the cubit is open', () {
      final cubit = _CounterCubit();
      addTearDown(cubit.close);

      expect(cubit.safeEmit(5), isTrue);
      expect(cubit.state, 5);
    });

    test('drops the state and reports false after close', () async {
      final cubit = _CounterCubit();
      await cubit.close();

      expect(cubit.emitAfterClose(), isFalse);
      expect(cubit.state, 0, reason: 'state must not change after close');
    });

    test('does not throw when a late response emits after close', () async {
      final cubit = _CounterCubit();
      final pending = cubit.emitAfterAwait();
      await cubit.close();

      // Without safeEmit this throws StateError: Cannot emit new states
      // after calling close.
      await expectLater(pending, completion(isFalse));
      expect(cubit.state, 0);
    });

    test(
      'plain emit after close still throws, proving the guard is needed',
      () async {
        final cubit = _CounterCubit();
        await cubit.close();

        expect(() => cubit.emit(9), throwsStateError);
      },
    );
  });
}
