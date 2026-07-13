import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';
import '../../../home/presentation/cubit/user/user_state.dart';

class UserInfoBlocBuilder extends StatelessWidget {
  const UserInfoBlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        final isLoggedIn = userState is UserSuccess && userState.isLoggedIn;
        final displayName = isLoggedIn
            ? (userState).user?.name ?? AppTexts.guestUser
            : AppTexts.guestUser;
        final displayEmail = isLoggedIn
            ? (userState).user?.email ?? AppTexts.noEmail
            : AppTexts.notSignedIn;

        return Column(
          children: [
            Text(
              displayName,
              style: AppConstants.headingStyle,
            ),
            const Gap(8),
            Text(
              displayEmail,
              style: AppConstants.bodyStyle.copyWith(color: Colors.grey),
            ),
          ],
        );
      },
    );
  }
}
