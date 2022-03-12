import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/core/widgets/flutter_toast.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:salla/features/home/presentation/pages/home_layout.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';

import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:salla/main.dart';

import '../../../../injection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var settingBloc ;

  @override
  void initState() {
    settingBloc = SettingsBloc.get(context);
    if (settingBloc.settings?.data == null) {
      print('null');
      settingBloc.add(GetSettingsEvent());
    }
    if (settingBloc.settings?.data != null) {
      setState(() {
        nameController.text = settingBloc.settings!.data!.name;
        emailController.text = settingBloc.settings!.data!.email;
        phoneController.text = settingBloc.settings!.data!.phone;
      });

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      // buildWhen: (previous, current) =>
      //     (current is SettingsLoadedState) ||
      //     (current is UpdateProfileIsLoadingState) ||
      //     (current is UpdateProfileSuccessState) ||
      //     (current is UpdateProfileErrorState) ||
      //     (current is ChangeLanguageSuccessState),
      listener: (context, state) {
        if (state is UpdateProfileErrorState) {

          if (settingBloc.settings?.data != null) {
            nameController.text = settingBloc.settings!.data!.name;
            emailController.text = settingBloc.settings!.data!.email;
            phoneController.text = settingBloc.settings!.data!.phone;
          }
        }
        if (state is SettingsLoadedState) {

          nameController.text = settingBloc.settings!.data!.name;
          emailController.text = settingBloc.settings!.data!.email;
          phoneController.text = settingBloc.settings!.data!.phone;
        }
        if (state is UpdateProfileSuccessState) {
          showToast(message: state.message, toastColor: ToastColor.success);
        }
        if (state is UpdateProfileErrorState) {
          showToast(message: state.error, toastColor: ToastColor.error);
        }
        if (state is ChangeLanguageSuccessState) {
          FavoritesBloc favoritesBloc = sl();
          favoritesBloc.add(GetFavoritesEvent());
          // navigateAndReplacementAll(
          //     context, const MyApp(startingWidget: HomeLayout()));
        }
      },
      builder: (context, state) {
        return settingBloc.settings?.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: 600,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: CachedNetworkImageProvider(
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
                                  value: UserData.themeMode ==
                                      ThemeModeSetting.dark,
                                  onChanged: (value) {
                                    print(value);
                                    settingBloc.add(
                                        ChangeThemeModeEvent(value: value));
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
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
                                        settingBloc.add(
                                            ChangeLanguageEvent(value: 'en'));
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
                                        settingBloc.add(
                                            ChangeLanguageEvent(value: 'ar'));

                                        print(value);
                                      },
                                      activeColor: Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        state is UpdateProfileIsLoadingState
                                            ? const SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Icon(Icons.update),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        UserData.language == Language.english
                                            ? const Text('Update')
                                            : const Text('حفظ التعديلات'),
                                      ],
                                    ),
                                    onPressed: () {
                                      settingBloc.add(UpdateProfileEvent(
                                          email: emailController.text,
                                          name: nameController.text,
                                          phoneNum: phoneController.text));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.logout),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        UserData.language == Language.english
                                            ? const Text('Logout')
                                            : const Text('تسجيل الخروج'),
                                      ],
                                    ),
                                    onPressed: () {
                                      SharedPreferencesCache.removeValue(
                                          key: 'token');
                                      navigateAndReplacementAll(
                                          context, const ShopLoginHome());
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
