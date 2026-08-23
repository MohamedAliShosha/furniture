import 'package:flutter/material.dart';
import '../widgets/profile_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/cubit/user/user_cubit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ProfileViewBody(),
      ),
    );
  }
}
