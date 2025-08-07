import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/campaign/campaign_event.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/membership/membership_event.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/points/point_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/points/point_event.dart';
import '../presentation/bloc/campaign/campaign_bloc.dart';
import '../presentation/bloc/membership/membership_bloc.dart';
import '../presentation/screens/main_navigation.dart';
import '../core/constants/app_themes.dart';
import 'core/utils/shared_preferences_helper.dart';
import 'data/repositories/campaign_repository.dart';
import 'data/repositories/point_repository.dart';
import 'data/repositories/user_repository.dart';


Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();

  // ⭐ Initialize SharedPreferences
  await SharedPreferencesHelper.init();

  runApp(const JenosizeApp());
}

class JenosizeApp extends StatelessWidget {
  const JenosizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ⭐ Create repositories (ต้องสร้างไว้ก่อน)
    final campaignRepository = CampaignRepository();
    final userRepository = UserRepository();
    final pointsRepository = PointsRepository();

    return MultiBlocProvider(
      providers: [
        // ⭐ CampaignBloc - ต้องส่ง pointsRepository ด้วย
        BlocProvider(
          create: (context) => CampaignBloc(
            campaignRepository: campaignRepository,
            pointsRepository: pointsRepository, // ⭐ เพิ่มบรรทัดนี้
          )..add(LoadCampaigns()),
        ),

        // ⭐ MembershipBloc - ต้องส่ง pointsRepository ด้วย
        BlocProvider(
          create: (context) => MembershipBloc(
            userRepository: userRepository,
            pointsRepository: pointsRepository, // ⭐ เพิ่มบรรทัดนี้
          )..add(CheckMembershipStatus()),
        ),

        // ⭐ PointsBloc
        BlocProvider(
          create: (context) => PointsBloc(
            pointsRepository: pointsRepository,
          )..add(LoadUserPoints()),
        ),
      ],
      child: MaterialApp(
        title: 'Jenosize Loyalty',
        theme: AppThemes.lightTheme,
        home: const MainNavigation(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
