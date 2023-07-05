import '../../../../widgets/custom_text.dart';

import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../widgets/primary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Icon(Icons.account_circle,
                size: 100,
                // color: AppTheme.lightPink,
                color: AppTheme.deepBrown),
            const SizedBox(
              height: 20,
            ),
            const CustomText(
              value: "Alvis Jerome",
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
            const ListTile(
              leading: Icon(
                Icons.mail,
                color: AppTheme.tealGreen,
              ),
              title: CustomText(
                value: "E-mail ID",
              ),
              subtitle: CustomText(value: "alvisjerome@gmail.com"),
            ),
            const ListTile(
              leading: Icon(
                Icons.date_range,
                color: AppTheme.tealGreen,
              ),
              title: CustomText(value: "Account created"),
              subtitle: CustomText(value: "5th July, 2023"),
            ),
            const Spacer(),
            PrimaryButton(
              labelText: "Log Out",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
