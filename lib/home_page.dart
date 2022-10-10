import 'package:flutter/material.dart';

import 'cal_tax.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _thuNhapController = TextEditingController();
  final TextEditingController _soNgPhuThuocController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _thuNhapController.text = '0';
    _soNgPhuThuocController.text = '0';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text('App Tinh Thue'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thu nhập cá nhân (1 tháng):'),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: _thuNhapController,
                    )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    const Text('VND'),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Số người phụ thuộc:'),
                TextField(
                  controller: _soNgPhuThuocController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  child: const Text(
                    'Tính thuế',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => setState(() {}),
                  style: TextButton.styleFrom(backgroundColor: Colors.blue),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                      const TextSpan(text: 'Thuế TNCN phải nộp: '),
                      CalTax.calculateYourTax(
                          totalIncome: _thuNhapController.text.trim(),
                          dependent: _soNgPhuThuocController.text.trim()),
                    ])),
              ],
            ),
          ),
        ),
      );
}
