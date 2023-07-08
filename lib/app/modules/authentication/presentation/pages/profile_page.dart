import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/primary_button.dart';
import '../providers/authentication_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

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
                  content: CustomText(value: error.toString())));
          },
        );
      },
    );
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
            (user.photo?.isNotEmpty ?? false)
                ? Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(user.photo ?? ""),
                      ),
                    ),
                  )
                : const Icon(Icons.account_circle,
                    size: 100, color: AppTheme.deepBrown),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              value: user.name ?? "",
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
              subtitle: CustomText(value: user.email ?? ""),
            ),
            ListTile(
              leading: const Icon(
                Icons.date_range,
                color: AppTheme.tealGreen,
              ),
              title: const CustomText(value: "Account created"),
              subtitle: CustomText(
                value: user.created ?? "",
              ),
            ),
            const Spacer(),
            Consumer(builder: (context, ref, _) {
              final provider = ref.watch(authNotifierProvider);
              return PrimaryButton(
                labelText: "Sign Out",
                onPressed: ref.read(authNotifierProvider.notifier).signOut,
                child: provider.whenOrNull(
                  skipError: true,
                  loading: () => const CircularProgressIndicator(
                    backgroundColor: AppTheme.white,
                    color: AppTheme.amber,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
