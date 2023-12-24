import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/providers/registerviewmodel.dart';

import 'package:thuc_hanh/ui/AppConstant.dart';
import 'package:thuc_hanh/ui/custom_control.dart';
import 'package:thuc_hanh/ui/page_login.dart';
import 'package:thuc_hanh/ui/page_main.dart';

// ignore: must_be_immutable
class PageRegister extends StatelessWidget {
  PageRegister({super.key});

  static String routename = '/register';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();

  bool agree = true;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    if (profile.token != "") // kiểm tra đã đăng nhập
    {
      Future.delayed(Duration.zero, () {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PageMain()));
      });
    }
    return Scaffold(
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
            child: viewmodel.status == 3 || viewmodel.status == 4
                ? Column(
                    children: [
                      const Image(
                          image: AssetImage('assets/images/verify.gif')),
                      Text(
                        "Đăng ký thành công",
                        style: AppConstant.textfancyheader,
                      ),
                      viewmodel.status == 3
                          ? const Text(
                              "Bạn cần xác nhận email để hoàn thành đăng ký!")
                          : Text(""),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.popAndPushNamed(
                                context, PageLogin.routename),
                            child: Text(
                              "Bấm vào đây",
                              style: AppConstant.textlink,
                            ),
                          ),
                          const Text(
                            " để đăng nhập",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Applogo(),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Create Account Now",
                                style: AppConstant.textfancyheader,
                              ),
                              Text(
                                "Follow me !!",
                                style: AppConstant.textfancyheader,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextField(
                                  textController: _emailController,
                                  hintText: "Email",
                                  obscureText: false),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  textController: _usernameController,
                                  hintText: "Username",
                                  obscureText: false),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  textController: _pass1Controller,
                                  hintText: "Password",
                                  obscureText: false),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextField(
                                  textController: _pass2Controller,
                                  hintText: "Repassword",
                                  obscureText: false),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                viewmodel.errormessage,
                                style: AppConstant.texterror,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    activeColor: Colors.red,
                                    checkColor: Colors.white,
                                    value: viewmodel.agree,
                                    onChanged: (value) {
                                      viewmodel.setAgree(value!);
                                    },
                                  ),
                                  const Text(
                                    "Đồng ý",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Quy định"),
                                            content: SingleChildScrollView(
                                                child: Text(viewmodel.quydinh)),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        " quy định",
                                        style: AppConstant.textlink,
                                      )),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    final email = _emailController.text.trim();
                                    final username =
                                        _usernameController.text.trim();
                                    final pass1 = _pass1Controller.text.trim();
                                    final pass2 = _pass2Controller.text.trim();

                                    viewmodel.register(
                                        email, username, pass1, pass2);
                                  },
                                  child: const CustomButton(
                                    textButton: "Đăng ký",
                                    size: 25,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .popAndPushNamed(PageLogin.routename),
                                  child: Text(
                                    "Đăng nhập >>",
                                    style: AppConstant.textlink,
                                  ))
                            ]),
                      ),
                      viewmodel.status == 1
                          ? CustomSpinner(size: size)
                          : Container(),
                    ],
                  ),
          ),
        )),
      ),
    );
  }
}
