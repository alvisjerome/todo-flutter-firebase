import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../../../core/utils/request_handlers.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../providers/authentication_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          value: "My Profile",
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppTheme.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            authProvider.mainUser.photo.isNotEmpty
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(authProvider.mainUser.photo))),
                  )
                : const Icon(Icons.account_circle,
                    size: 100, color: AppTheme.deepBrown),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              value: authProvider.mainUser.name,
              align: TextAlign.center,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: CustomText(
                value: "Account Details",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.mail,
                color: AppTheme.tealGreen,
              ),
              title: const CustomText(
                value: "E-mail ID",
              ),
              subtitle: CustomText(
                value: authProvider.mainUser.email,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.date_range,
                color: AppTheme.tealGreen,
              ),
              title: const CustomText(value: "Account created"),
              subtitle: CustomText(
                value: authProvider.mainUser.created,
              ),
            ),
            const Spacer(),
            PrimaryButton(
              labelText: "Log Out",
              onPressed: () {
                context
                    .read<AuthenticationProvider>()
                    .handleSignOut(
                        requestHandlers: RequestHandlers(
                            onError: ([message]) =>
                                Helpers.onErrorSnackbar(message, context),
                            onLoading: () => Helpers.onLoadingSnackbar(context),
                            onSuccess: () {
                              Helpers.onSuccessSnackbar(
                                  context, "Logged out successfully!");
                            }))
                    .then((_) => Navigator.pop(context));
              },
            ),
          ],
        ),
      ),
    );
  }
}
