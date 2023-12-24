import 'package:flutter/material.dart';
import 'package:thuc_hanh/models/lop.dart';
import 'package:thuc_hanh/models/profile.dart';
import 'package:thuc_hanh/repositores/lop_repository.dart';
import 'package:thuc_hanh/ui/custom_control.dart';

import 'AppConstant.dart';

class SubPageDslop extends StatelessWidget {
  const SubPageDslop({super.key});
  static int idpage = 4;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: AppConstant.backgroundcolor,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Danh Sách Lớp',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Dssv>>(
            future: LopRepository().getDssv(Profile().student.idlop),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CustomSpinner(
                  size: size,
                ));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Dssv> dataList = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Tổng số SV: ${dataList.length}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'MSSV                                  Tên Sinh Viên',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return StudentCard(data: dataList[index]);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
