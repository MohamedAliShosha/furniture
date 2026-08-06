import 'package:flutter_test/flutter_test.dart';
import 'package:furniture/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:furniture/features/notification/presentation/cubit/notification_state.dart';
import 'package:furniture/features/notification/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationCubit', () {
    test('loadNotifications emits success with notifications', () async {
      SharedPreferences.setMockInitialValues({});
      final cubit = NotificationCubit(NotificationService());

      await cubit.loadNotifications();

      expect(cubit.state, isA<NotificationSuccess>());
      final state = cubit.state as NotificationSuccess;
      expect(state.notifications, isNotEmpty);
      expect(state.pushEnabled, isTrue);
      expect(state.emailEnabled, isTrue);

      await cubit.close();
    });
  });
}
