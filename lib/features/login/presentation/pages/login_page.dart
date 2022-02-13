import 'package:flutter/material.dart';
import 'package:salla/core/widgets/custom_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
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
                        print(value);
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
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                    obscureText: obscurePassword,
                    validator: (value) {
                      if ((value == null) || (value.isEmpty)) {
                        print(value);
                        return 'Please enter valid password';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {}
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
      ),
    );
  }
}
