import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/providers/forgotviewmodel.dart';
import 'package:thuc_hanh/ui/AppConstant.dart';
import 'package:thuc_hanh/ui/custom_control.dart';
import 'package:thuc_hanh/ui/page_login.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routename = '/forgot';
  final _emailContrller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xfffc466b), Color(0xff3f5efb)],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Center(
          child: viewmodel.status == 1
              ? Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                          image: AssetImage('assets/images/verify.gif')),
                      Text(
                        "Gửi yêu cầu thành công !!\n Truy  cập  Email để biết thêm mọi chi tiết!",
                        style: AppConstant.textheader,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.popAndPushNamed(
                                  context, PageLogin.routename);
                            },
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
                  ),
                )
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                              image: AssetImage('assets/images/key.png')),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Hãy điền email để thực hiện tạo lại mật khẩu!",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                              textController: _emailContrller,
                              hintText: "Email",
                              obscureText: false),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            viewmodel.errormessege,
                            style: AppConstant.texterror,
                          ),
                          GestureDetector(
                              onTap: () {
                                final email = _emailContrller.text.trim();
                                viewmodel.forgotPassword(email);
                              },
                              child: const CustomButton(
                                textButton: "Gửi yêu cầu",
                                size: 20,
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                viewmodel.status = 0;
                                Navigator.of(context)
                                    .popAndPushNamed(PageLogin.routename);
                              },
                              child: Text(
                                "Đăng nhập >>",
                                style: AppConstant.textlink,
                              ))
                        ],
                      ),
                    ),
                    viewmodel.status == 1
                        ? CustomSpinner(size: size)
                        : Container()
                  ],
                ),
        ),
      ),
    );
  }
}
