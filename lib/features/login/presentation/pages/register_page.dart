import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/core/data/local_data_source/shared_preferences.dart';
import 'package:salla/core/util/enum.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/core/widgets/flutter_toast.dart';
import 'package:salla/core/widgets/navigator.dart';
import 'package:salla/features/home/presentation/pages/home_layout.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';
import 'package:salla/features/login/presentation/pages/login_page.dart';

class ShopRegisterHome extends StatefulWidget {
  const ShopRegisterHome({Key? key}) : super(key: key);

  @override
  State<ShopRegisterHome> createState() => _ShopRegisterHomeState();
}

class _ShopRegisterHomeState extends State<ShopRegisterHome> {
  bool obscurePassword = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  ShopLoginBloc shopLoginBloc =
      ShopLoginBloc(shopLoginRepo: ShopLoginRepoImp());

  void login() {
    if (loginFormKey.currentState!.validate()) {
      shopLoginBloc.add(ShopUserRegisterEvent(name: nameController.text, email: emailController.text, password: passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    shopLoginBloc = BlocProvider.of<ShopLoginBloc>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<ShopLoginBloc, ShopLoginState>(
          listener: (context, state) {
            if (state is ShopLoginSucceededState) {
              if (state.loginModel.status) {
                showToast(
                    message: state.loginModel.message,
                    toastColor: ToastColor.success);
                SharedPreferencesCache.setValue(
                        key: 'token', value: state.loginModel.data?.token)
                    .then((value) =>
                        navigateAndReplacementAll(context, const HomeLayout()));
              } else {
                showToast(
                    message: state.loginModel.message,
                    toastColor: ToastColor.error);
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Center(
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset('assets/images/shopping-cart.png')),
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Register',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Register now',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextFormField(
                            textEditingController: nameController,
                            label: 'Name',
                            prefixIcon: const Icon(Icons.person),
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if ((value == null) || (value.isEmpty)) {
                                return 'Please enter valid name';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFormField(
                            textEditingController: emailController,
                            label: 'Email Address',
                            prefixIcon: const Icon(Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if ((value == null) || (value.isEmpty)) {
                                return 'Please enter valid email';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextFormField(
                            textEditingController: passwordController,
                            label: 'Password',
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () {
                                shopLoginBloc
                                    .add(LoginChangePasswordVisibilityEvent());
                              },
                              icon: shopLoginBloc.suffixIcon,
                            ),
                            obscureText: shopLoginBloc.obscurePassword,
                            validator: (value) {
                              if ((value == null) || (value.isEmpty)) {
                                return 'Please enter valid password';
                              }
                            },
                            onSubmitted: (value) {
                              login();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: state is ShopLoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      login();
                                    },
                                    child: const Text('REGISTER'),
                                  ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),
                              TextButton(
                                onPressed: () {
                                  navigateAndReplacementAll(context, const ShopLoginHome());
                                },
                                child: const Text('Login'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
