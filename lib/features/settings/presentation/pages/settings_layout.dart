import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/constants.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';
import 'package:salla/features/onBoarding/presentation/pages/onBoarding.dart';
import 'package:salla/features/settings/presentation/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    var settingBloc = SettingsBloc.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: false,
        // systemOverlayStyle: const SystemUiOverlayStyle().copyWith(statusBarColor: Colors.blueAccent),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Account Information',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black87),

        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {},
            icon: const Icon(Icons.edit),
            iconSize: 30,
          ),
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              SharedPreferencesCache.removeValue(key: 'token');
              navigateAndReplacementAll(context, const ShopLoginHome());
            },
            icon: const Icon(Icons.logout),
            iconSize: 30,
          ),
        ],
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLoadedState) {
            if (settingBloc.settings?.data != null) {
              nameController.text = settingBloc.settings!.data!.name;
              emailController.text = settingBloc.settings!.data!.email;
              phoneController.text = settingBloc.settings!.data!.phone;
            }
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
                          label: 'Name',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          textEditingController: emailController,
                          label: 'Email',
                          prefixIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          textEditingController: phoneController,
                          label: 'Phone',
                          prefixIcon: const Icon(Icons.phone_android),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Text('Dark Mode'),
                              const Spacer(),
                              Switch(
                                value: settingBloc.settings?.mode ==
                                    ThemeModeSetting.dark,
                                onChanged: (value) {},
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
                              const Text('Language'),
                              Spacer(),
                              Row(
                                children: [
                                  const Text('English'),
                                  Radio(
                                    value: Colors.green,
                                    groupValue: settingBloc.settings?.lang =='en' ? Colors.green : Colors.white,
                                    onChanged: (value) {
                                      print(settingBloc.settings?.lang =='en');
                                      print(value);

                                    },
                                    activeColor: Colors.green,
                                  ),
                                  const Text('Arabic'),
                                  Radio(
                                    value: Colors.green,
                                    groupValue: settingBloc.settings?.lang =='en' ? Colors.white : Colors.green,

                                    onChanged: (value) {
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
      ),
    );
  }
}
