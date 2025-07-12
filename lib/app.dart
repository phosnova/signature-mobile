import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_config.dart';
import 'core/themes/input_decoration_theme.dart';
import 'injection.dart';
import 'presentation/bloc/pdf/pdf_bloc.dart';
import 'presentation/bloc/share_pdf/share_pdf_bloc.dart';
import 'presentation/bloc/sign/sign_bloc.dart';
import 'router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignBloc>()..add(const SignEvent.started())),
        BlocProvider(create: (context) => getIt<PdfBloc>()..add(const PdfEvent.started())),
        BlocProvider(create: (context) => getIt<SharePdfBloc>()..add(const SharePdfEvent.started())),
      ],
      child: MaterialApp.router(
        title: MyAppConfig.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          inputDecorationTheme: inputDecorationTheme,
        ),
        debugShowCheckedModeBanner: false, // default: true or other best partice: !kReleaseMode
        routerConfig: goRouter,
        // locale: const Locale('id', 'ID'),
      ),
    );
  }
}
