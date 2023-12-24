import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/ui/AppConstant.dart';
import 'package:thuc_hanh/ui/page_fogot.dart';
import 'package:thuc_hanh/ui/page_main.dart';
import 'package:thuc_hanh/ui/page_register.dart';

import '../providers/loginviewmodel.dart';
import 'custom_control.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;

    if (viewmodel.status == 3) {
      Future.delayed(Duration.zero, () {
        Navigator.popAndPushNamed(context, PageMain.routename);
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xfffc466b), Color(0xff3f5efb)],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Applogo(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome",
                        style: AppConstant.textfancyheader,
                      ),
                      Text(
                        "We miss you!",
                        style: AppConstant.textfancyheader,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        hintText: "Username",
                        textController: _emailController,
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        hintText: "Password",
                        textController: _passwordController,
                        obscureText: true,
                      ),
                      viewmodel.status == 2
                          ? Text(
                              viewmodel.errorMessage,
                              style: AppConstant.texterror,
                            )
                          : const Text(""),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          String username = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: const CustomButton(
                          textButton: "Đăng nhập",
                          size: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(PageForgot.routename),
                          child: Text(
                            "Quên mật khẩu",
                            style: AppConstant.textlink,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Chưa có tài khoản?",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageRegister.routename),
                            child: Text(
                              " Đăng ký",
                              style: AppConstant.textlink,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
