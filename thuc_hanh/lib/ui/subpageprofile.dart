import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/providers/profileviewmodel.dart';
import 'package:thuc_hanh/providers/diachimodel.dart';
import 'package:thuc_hanh/ui/custom_control.dart';
import '../providers/mainviewmodel.dart';
import 'AppConstant.dart';

// ignore: must_be_immutable
class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  XFile? image;
  static int idpage = 0;

  Future<void> init(DiaChiModel dcModel, ProfileViewModel viewModel) async {
    Profile profile = Profile();
    if (dcModel.listCity.isEmpty ||
        dcModel.curCityId != profile.user.provinceid ||
        dcModel.curDisId != profile.user.districtid ||
        dcModel.curWardId != profile.user.wardid) {
      viewModel.displaySpinner();
      await dcModel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      print('------finish ---- init -------');
      viewModel.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context);
    final dcModel = Provider.of<DiaChiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcModel, viewModel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  // -- Start header --
                  createHeader(size, profile, viewModel),
                  // -- End header --
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomInputTextFromField(
                                  title: 'Điện thoại',
                                  value: profile.user.phone,
                                  width: size.width * 0.42,
                                  callback: (output) {
                                    profile.user.phone = output;
                                    viewModel.setModified();
                                    viewModel.updateScreen();
                                  },
                                  type: TextInputType.phone,
                                ),
                                CustomInputTextFromField(
                                  title: 'Ngày sinh',
                                  value: profile.user.birthday,
                                  width: size.width * 0.45,
                                  callback: (output) {
                                    if (AppConstant.isDate(output)) {
                                      profile.user.birthday = output;
                                    }
                                    viewModel.setModified();
                                    viewModel.updateScreen();
                                  },
                                  type: TextInputType.datetime,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPlaceDropDown(
                                    width: size.width * 0.42,
                                    title: "Thành phố/Tỉnh",
                                    valueId: profile.user.provinceid,
                                    valueName: profile.user.provincename,
                                    callback: ((outputId, inputName) async {
                                      viewModel.displaySpinner();
                                      profile.user.provinceid = outputId;
                                      profile.user.provincename = inputName;
                                      await dcModel.setCity(outputId);
                                      profile.user.districtid = 0;
                                      profile.user.wardid = 0;
                                      profile.user.districtname = '';
                                      profile.user.wardname = '';
                                      viewModel.setModified();
                                      viewModel.hideSpinner();
                                    }),
                                    list: dcModel.listCity),
                                CustomPlaceDropDown(
                                    width: size.width * 0.45,
                                    title: "Quận/huyện",
                                    valueId: profile.user.districtid,
                                    valueName: profile.user.districtname,
                                    callback: ((outputId, inputName) async {
                                      viewModel.displaySpinner();
                                      profile.user.districtid = outputId;
                                      profile.user.districtname = inputName;
                                      await dcModel.setDistrict(outputId);
                                      profile.user.wardid = 0;
                                      profile.user.wardname = '';
                                      viewModel.setModified();
                                      viewModel.hideSpinner();
                                    }),
                                    list: dcModel.listDistrict),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomPlaceDropDown(
                                    width: size.width * 0.42,
                                    title: "Xã/phường",
                                    valueId: profile.user.wardid,
                                    valueName: profile.user.wardname,
                                    callback: ((outputId, outputName) async {
                                      viewModel.displaySpinner();
                                      profile.user.wardid = outputId;
                                      profile.user.wardname = outputName;
                                      await dcModel.setWard(outputId);
                                      viewModel.setModified();
                                      viewModel.hideSpinner();
                                    }),
                                    list: dcModel.listWard),
                                CustomInputTextFromField(
                                  title: 'Tên đường/số nhà',
                                  value: profile.user.address,
                                  width: size.width * 0.45,
                                  callback: (output) {
                                    profile.user.address = output;
                                    viewModel.setModified();
                                    viewModel.updateScreen();
                                  },
                                  type: TextInputType.streetAddress,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomInputTextFromField(
                                  title: 'Tên',
                                  value: profile.user.first_name,
                                  width: size.width * 0.42,
                                  callback: (output) {
                                    profile.user.first_name = output;
                                    viewModel.setModified();
                                    viewModel.updateScreen();
                                  },
                                  type: TextInputType.text,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: size.width * 0.3,
                              width: size.width * 0.3,
                              child: QrImageView(
                                data: '{userid:${profile.user.id}}',
                                version: QrVersions.auto,
                                gapless: false,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  Profile profile = Profile();
                                  profile.onLogout();
                                  print({profile.token});
                                  // Profile profile = Profile();

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login', // Route name for LoginPage
                                    (Route<dynamic> route) => false,
                                  );
                                  // Navigator.popAndPushNamed(
                                  //     context, PageLogin.routename);

                                  // Profile profile = Profile();
                                  // await profile.clearToken(); // Xóa token
                                  // profile
                                  //     .resetUsernamePassword(); // Reset username và password về rỗng
                                  // ignore: use_build_context_synchronously
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => PageLogin()));
                                  // Navigator.pushAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           PageLogin()), // Màn hình đăng nhập
                                  //   (Route<dynamic> route) =>
                                  //       false, // Xóa tất cả các màn hình còn lại trong ngăn xếp
                                  // );
                                },
                                child: Text(
                                  "Đăng xuất =>>>",
                                  style: AppConstant.texterror1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              viewModel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          )),
    );
  }

  Padding createHeader(Size size, Profile profile, ProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: size.height * 0.20,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppConstant.appbarcolor,
          borderRadius: BorderRadius.all(Radius.circular(60)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text(
                          profile.student.diem.toString(),
                          style: AppConstant.textbody,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: viewModel.updateavatar == 1 && image != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(
                                      File(image!.path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      viewModel.uploadAvatar(image!);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Icon(size: 30, Icons.save),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                viewModel.setUpdateAvatar();
                              },
                              child: CustomAvatarProfile(size: size)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tên: ",
                          style: AppConstant.textbody,
                        ),
                        Text(
                          profile.user.first_name,
                          style: AppConstant.textlink,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Mssv: ",
                          style: AppConstant.textbody,
                        ),
                        Text(
                          profile.student.mssv,
                          style: AppConstant.textlink,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Lớp: ",
                          style: AppConstant.textbody,
                        ),
                        Text(
                          profile.student.tenlop,
                          style: AppConstant.textlink,
                        ),
                        profile.student.duyet == 0
                            ? Text(
                                " (Chưa duyệt)",
                                style: AppConstant.textlink,
                              )
                            : Text("")
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Vai trò: ",
                          style: AppConstant.textbody,
                        ),
                        Text(
                          profile.user.role_id == 4
                              ? "Sinh viên"
                              : "Giảng viên",
                          style: AppConstant.textlink,
                        )
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: viewModel.modified == 1
                            ? GestureDetector(
                                onTap: () {
                                  viewModel.updateProfile();
                                },
                                child: Icon(Icons.save))
                            : Container(),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
