import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/common/image_paths.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../providers/authentication_providers.dart';

class AuthenticationPage extends ConsumerWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authNotifierProvider,
      (_, next) {
        next.maybeWhen(
          orElse: () => null,
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                  backgroundColor: AppTheme.deepRed,
                  content: CustomText(
                    value: error.toString(),
                    color: AppTheme.white,
                  )));
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 35),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    value: "Welcome!",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  CustomText(
                    value: "Please login or register to continue",
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  ImagePaths.cover,
                  height: 350,
                  width: double.maxFinite,
                ),
              ),
              Column(
                children: [
                  Consumer(builder: (context, ref, _) {
                    final provider = ref.watch(authNotifierProvider);
                    return PrimaryButton(
                      labelText: "Continue with Google",
                      onPressed: ref
                          .read(authNotifierProvider.notifier)
                          .signInWithGoogle,
                      child: provider.whenOrNull(
                        skipError: true,
                        loading: () => const CircularProgressIndicator(
                          backgroundColor: AppTheme.white,
                          color: AppTheme.amber,
                        ),
                      ),
                    );
                  }),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10.0),
                    child: const CustomText(
                      value:
                          "By signing up, you agree to our\nTerms & Conditions",
                      align: TextAlign.center,
                      fontSize: 13,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
