import 'package:flutter_test/flutter_test.dart';
import 'package:furniture/features/home/data/models/user_model.dart';
import 'package:furniture/features/home/services/user_service.dart';

void main() {
  group('UserService', () {
    late UserService service;

    setUp(() {
      service = UserService();
      service.setUser(
        UserModel(
          id: 'user-1',
          email: 'test@example.com',
          name: 'Test User',
        ),
      );
      service.setPassword('oldPassword123');
    });

    test(
        'changes password when current password matches and new password is valid',
        () {
      final result = service.changePassword(
        currentPassword: 'oldPassword123',
        newPassword: 'newPassword456',
      );

      expect(result, isTrue);
      expect(service.password, 'newPassword456');
    });

    test('rejects invalid current password or weak new password', () {
      expect(
        service.changePassword(
          currentPassword: 'wrongPassword',
          newPassword: 'newPassword456',
        ),
        isFalse,
      );

      expect(
        service.changePassword(
          currentPassword: 'oldPassword123',
          newPassword: '123',
        ),
        isFalse,
      );
    });
  });
}
