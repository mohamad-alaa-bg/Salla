import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';
import 'package:salla/features/login/data/repositories/shop_login_repo_imp.dart';
import 'package:salla/features/login/presentation/bloc/shop_login_bloc.dart';

class ShopLoginHome extends StatefulWidget {
  const ShopLoginHome({Key? key}) : super(key: key);

  @override
  State<ShopLoginHome> createState() => _ShopLoginHomeState();
}

class _ShopLoginHomeState extends State<ShopLoginHome> {
  bool obscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var loginFormKey = GlobalKey<FormState>();
  ShopLoginBloc shopLoginBloc =
      ShopLoginBloc(shopLoginRepoImp: ShopLoginRepoImp());

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
                Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  timeInSecForIosWeb: 2,
                  fontSize: 20,
                );
              } else {
                print(state.loginModel.message);
                Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  timeInSecForIosWeb: 5,
                  fontSize: 20,
                );
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
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 40,
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
                              if (loginFormKey.currentState!.validate()) {
                                print('alaa');
                                shopLoginBloc.add(ShopUserLoginEvent(
                                    email: emailController.text,
                                    password: passwordController.text));
                              }
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
                                      if (loginFormKey.currentState!
                                          .validate()) {
                                        print('alaa');
                                        shopLoginBloc.add(ShopUserLoginEvent(
                                            email: emailController.text,
                                            password: passwordController.text));
                                      }
                                    },
                                    child: const Text('LOGIN'),
                                  ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Register Now'),
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
