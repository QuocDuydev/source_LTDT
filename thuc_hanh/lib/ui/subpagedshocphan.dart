import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/models/hocphan.dart';
import 'package:thuc_hanh/providers/dkhocphanviewmodel.dart';
import 'package:thuc_hanh/repositores/dsHP_repository.dart';
import 'package:thuc_hanh/ui/custom_control.dart';

import 'AppConstant.dart';

class SubPageDshocphan extends StatelessWidget {
  const SubPageDshocphan({super.key});
  static int idpage = 5;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<DangKyHocPhanViewModel>(context);

    if (viewmodel.status == 2) {
      // Hiển thị thông báo khi điều kiện đúng
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => Positioned(
            top: 0.0,
            left: 0.0,
            child: Material(
              color: const Color.fromARGB(0, 255, 255, 255),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: AlertDialog(
                  title: const Center(
                    child: Text(
                      'Thông báo',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  content: Text(
                    viewmodel.message,
                    style: AppConstant.texterror2,
                  ),
                ),
              ),
            ),
          ),
        );

        overlay.insert(overlayEntry);

        // Đóng thông báo sau 5 giây
        Future.delayed(const Duration(seconds: 5), () {
          overlayEntry.remove();
          viewmodel.status = 0;
        });
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Danh Sách Học Phần',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<HocPhan>>(
            future: DSHocPhanRepository().getDsHocPhan(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CustomSpinner(
                    size: size,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<HocPhan> dataList = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.80,
                  ),
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Color.fromARGB(255, 253, 244, 161),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Môn'),
                            Text(
                              dataList[index].tenhocphan,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Text('Giáo viên'),
                            Text(
                              dataList[index].tengv,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                              onPressed: () async {
                                viewmodel.DangKyHocPhan(dataList[index].id);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Đăng ký',
                                style: AppConstant.textlink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
