import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common/image_paths.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../../core/utils/request_handlers.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../providers/authentication_provider.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  PrimaryButton(
                      labelText: "Continue with Google",
                      onPressed: () {
                        context
                            .read<AuthenticationProvider>()
                            .handleGoogleSignIn(
                              requestHandlers: RequestHandlers(
                                onError: ([message]) =>
                                    Helpers.onErrorSnackbar(message, context),
                                onLoading: () =>
                                    Helpers.onLoadingSnackbar(context),
                                onSuccess: () => ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar(),
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
