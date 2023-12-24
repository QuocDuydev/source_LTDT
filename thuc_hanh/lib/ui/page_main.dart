import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/providers/mainviewmodel.dart';
import 'package:thuc_hanh/providers/menubarviewmodel.dart';
import 'package:thuc_hanh/ui/AppConstant.dart';
import 'package:thuc_hanh/ui/page_dklop.dart';
import 'package:thuc_hanh/ui/page_login.dart';

import '../models/profile.dart';
import 'subpagediemdanh.dart';
import 'subpagedshocphan.dart';
import 'subpagedslop.dart';
import 'subpageprofile.dart';
import 'subpagetimkiem.dart';
import 'subpagehpdadk.dart';

class PageMain extends StatelessWidget {
  static String routename = '/home';

  PageMain({super.key});
  final List<String> menuTitles = [
    "Profile",
    "Ds HP đã DK",
    "Điểm danh",
    "Tìm kiếm",
    "Ds lớp",
    "Ds học phần"
  ];
  final menuBar = MenuItemlist();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if (profile.token == "") {
      return PageLogin();
    }
    if (profile.student.mssv == "") {
      return PageDangKyLop();
    }
    Widget body = SubPageProfile();
    if (viewmodel.activemenu == SubPageHPdaDK.idpage) {
      body = SubPageHPdaDK();
    } else if (viewmodel.activemenu == SubPageDiemdanh.idpage)
      body = SubPageDiemdanh();
    else if (viewmodel.activemenu == SubPageTimkiem.idpage)
      body = SubPageTimkiem();
    else if (viewmodel.activemenu == SubPageDslop.idpage)
      body = SubPageDslop();
    else if (viewmodel.activemenu == SubPageDshocphan.idpage)
      body = SubPageDshocphan();

    menuBar.initialize(menuTitles);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: GestureDetector(
          onTap: () => viewmodel.toggleMenu(),
          child: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<MenuBarViewModel>(
              builder: (context, menuBarModel, child) {
                return Container(
                  color: Colors.lightBlue[100],
                  child: Center(
                    child: body,
                  ),
                );
              },
              child: GestureDetector(
                onTap: () {
                  viewmodel.closeMenu();
                },
                child: Container(
                  color: Colors.lightBlue[100],
                  child: const Center(
                    child: Text(
                      'Wellcome Page Home',
                    ),
                  ),
                ),
              ),
            ),
            viewmodel.menustatus == 1
                ? Consumer<MenuBarViewModel>(
                    builder: (context, menuBarModel, child) {
                      return GestureDetector(
                          onPanUpdate: (details) {
                            menuBarModel.setOffset(details.localPosition);
                          },
                          onPanEnd: (details) {
                            menuBarModel.setOffset(Offset(0, 0));
                            viewmodel.closeMenu();
                          },
                          child: Stack(
                            children: [CustomMenuSideBar(size: size), menuBar],
                          ));
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });

  final List<MenuBarItem> menuBarItems = [];
  void initialize(List<String> menuTitles) {
    menuBarItems.clear();
    for (int i = 0; i < menuTitles.length; i++) {
      menuBarItems.add(MenuBarItem(
        idpage: i,
        containerkey: GlobalKey(),
        title: menuTitles[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.20,
          width: size.width * 0.65,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              endRadius: size.height * 0.15,
              glowColor: AppConstant.appbarcolor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * 0.16,
                  width: size.height * 0.16,
                  child: const Image(
                    image: AssetImage('assets/images/avatar.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 2,
          width: size.width * 0.65,
          color: AppConstant.appbarcolor,
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: menuBarItems.length,
                itemBuilder: (context, index) {
                  return menuBarItems[index];
                }),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title,
    required this.containerkey,
    required this.idpage,
  });

  final int idpage;
  final String title;
  final GlobalKey containerkey;
  TextStyle style = AppConstant.textbody;

  void onPanmove(Offset offset) {
    if (offset.dy == 0) {
      style = AppConstant.textbody;
    }
    if (containerkey.currentContext != null) {
      RenderBox box =
          containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (offset.dy < position.dy - 40 && offset.dy > position.dy - 80) {
        style = AppConstant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      } else {
        style = AppConstant.textbody;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanmove(menuBarModel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

class CustomMenuSideBar extends StatelessWidget {
  const CustomMenuSideBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);
    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawerCustomPaint(offset: sizeBarModel.offset),
    );
  }
}

class DrawerCustomPaint extends CustomPainter {
  final Offset offset;

  DrawerCustomPaint({super.repaint, required this.offset});
  double generatePointX(double width) {
    double kq = 0;
    if (offset.dx == 0) {
      kq = width;
    } else if (offset.dx < width) {
      kq = width + 75;
    } else {
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
      ..color = Colors.lightBlue[50]!
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
        generatePointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }
}
