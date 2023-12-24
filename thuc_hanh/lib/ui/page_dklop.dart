import 'package:flutter/material.dart';
import 'package:thuc_hanh/models/lop.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/repositores/lop_repository.dart';
import 'package:thuc_hanh/repositores/student_repository.dart';
import 'package:thuc_hanh/repositores/user_repository.dart';
import 'package:thuc_hanh/ui/AppConstant.dart';
import 'package:thuc_hanh/ui/custom_control.dart';
import 'package:thuc_hanh/ui/page_login.dart';

class PageDangKyLop extends StatefulWidget {
  PageDangKyLop({super.key});

  @override
  State<PageDangKyLop> createState() => _PageDangKyLopState();
}

class _PageDangKyLopState extends State<PageDangKyLop> {
  List<Lop>? Listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';
  @override
  void initState() {
    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop = profile.student.tenlop;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Profile profile = Profile();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Đăng ký lớp",
                  style: AppConstant.textred,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Bạn không thể quay trở lại trang sau khi rời đi. Hãy kiểm tra kỹ!",
                  style: AppConstant.texterror1,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomInputTextFromField(
                  title: "Tên:",
                  value: ten,
                  width: size.width,
                  callback: (output) {
                    ten = output;
                  },
                ),
                CustomInputTextFromField(
                  title: "Mssv:",
                  value: mssv,
                  width: size.width,
                  callback: (output) {
                    mssv = output;
                  },
                ),
                Listlop!.isEmpty
                    ? FutureBuilder(
                        future: LopRepository().getDsLop(),
                        builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CustomSpinner(
                                size: size,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            Listlop = snapshot.data;
                            return CustomInputDropDown(
                              width: size.width,
                              list: Listlop!,
                              title: "Lớp",
                              valueId: idlop,
                              valueName: tenlop,
                              callback: (ouputId, outputName) {
                                idlop = ouputId;
                                tenlop = outputName;
                              },
                            );
                          } else {
                            return const Text("Lỗi");
                          }
                        },
                      )
                    : CustomInputDropDown(
                        width: size.width,
                        list: Listlop!,
                        title: "Lớp",
                        valueId: idlop,
                        valueName: tenlop,
                        callback: (ouputId, outputName) {
                          idlop = ouputId;
                          tenlop = outputName;
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () async {
                      profile.student.mssv = mssv;
                      profile.student.idlop = idlop;
                      profile.student.tenlop = tenlop;
                      profile.user.first_name = ten;
                      await UserRepository().updateProfile();
                      await StudentRepository().dangkyLop();
                    },
                    child: const CustomButton(
                      textButton: "Lưu thông tin",
                      size: 20,
                    )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, PageLogin.routename);
                  },
                  child: Text(
                    "Rời khỏi trang =>>>",
                    style: AppConstant.texterror1,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
