import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thuc_hanh/models/hocphan.dart';
import 'package:thuc_hanh/providers/dkhocphanviewmodel.dart';
import 'package:thuc_hanh/repositores/dkHP_repository.dart';
import 'package:thuc_hanh/ui/custom_control.dart';

class SubPageHPdaDK extends StatelessWidget {
  SubPageHPdaDK({super.key});
  static int idpage = 1;
  @override
  Widget build(BuildContext context) {
    DangKyHocPhanRepository().getHocPhanDangKy();
    return const HocPhanDangKyPage();
  }
}

class HocPhanDangKyPage extends StatelessWidget {
  const HocPhanDangKyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<DangKyHocPhanViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Học Phần Đã Đăng Ký',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<HocPhanDangKy>>(
          future: viewmodel.getHocPhanDangKy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CustomSpinner(size: size),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<HocPhanDangKy> dataList = snapshot.data!;

              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color.fromARGB(255, 253, 244, 161),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tên môn: ${dataList[index].tenhocphan}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Giáo viên: ${dataList[index].tengv}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Divider(color: Colors.black, height: 20),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Danh sách sinh viên',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 252, 50, 14),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
