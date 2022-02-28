import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/home/presentation/pages/home_layout.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:salla/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    SettingsBloc.get(context).add(GetSettingsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    var settingBloc = SettingsBloc.get(context);
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoadedState) {
          if (settingBloc.settings?.data != null) {
            nameController.text = settingBloc.settings!.data!.name;
            emailController.text = settingBloc.settings!.data!.email;
            phoneController.text = settingBloc.settings!.data!.phone;
          }
        }
        if (state is ChangeLanguageSuccessState) {
          Widget startingWidget;

          if (UserData.onBoardingState) {
            startingWidget = OnBoarding();
          } else {
            if (UserData.token.isNotEmpty) {
              startingWidget = const HomeLayout();
            } else {
              startingWidget = const ShopLoginHome();
            }
          }
          navigateAndReplacementAll(
              context, MyApp(startingWidget: startingWidget));
        }
      },
      builder: (context, state) {

        if (settingBloc.settings?.data != null) {
          nameController.text = settingBloc.settings!.data!.name;
          emailController.text = settingBloc.settings!.data!.email;
          phoneController.text = settingBloc.settings!.data!.phone;
        }
        return settingBloc.settings?.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            settingBloc.settings!.data!.image,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        textEditingController: nameController,
                        label: UserData.language == Language.english
                            ? 'Name'
                            : 'الاسم',
                        prefixIcon: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        textEditingController: emailController,
                        label: UserData.language == Language.english
                            ? 'Email'
                            : 'البريد الالكتروني',
                        prefixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        textEditingController: phoneController,
                        label: UserData.language == Language.english
                            ? 'Phone'
                            : 'الرقم',
                        prefixIcon: const Icon(Icons.phone_android),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            UserData.language == Language.english
                                ? const Text('Dark Mode')
                                : const Text('الوضع الداكن'),
                            const Spacer(),
                            Switch(
                              activeColor: Theme.of(context).primaryColor,
                              value:
                                  UserData.themeMode == ThemeModeSetting.dark,
                              onChanged: (value) {
                                print(value);
                                settingBloc
                                    .add(ChangeThemeModeEvent(value: value));
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            UserData.language == Language.english
                                ? const Text('Language')
                                : const Text('اللغة'),
                            const Spacer(),
                            Row(
                              children: [
                                UserData.language == Language.english
                                    ? const Text('English')
                                    : const Text('الانجليزية'),
                                Radio(
                                  value: Colors.green,
                                  groupValue:
                                      UserData.language == Language.english
                                          ? Colors.green
                                          : Colors.white,
                                  onChanged: (value) {
                                    settingBloc
                                        .add(ChangeLanguageEvent(value: 'en'));
                                    print(value);
                                  },
                                  activeColor: Colors.green,
                                ),
                                UserData.language == Language.english
                                    ? const Text('Arabic')
                                    : const Text('العربية'),
                                Radio(
                                  value: Colors.green,
                                  groupValue:
                                      UserData.language == Language.english
                                          ? Colors.white
                                          : Colors.green,
                                  onChanged: (value) {
                                    settingBloc
                                        .add(ChangeLanguageEvent(value: 'ar'));

                                    print(value);
                                  },
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
