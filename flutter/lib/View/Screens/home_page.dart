import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter3/Models/home_model.dart';
import 'package:flutter3/Service/delete.dart';
import 'package:flutter3/View/Components/textspan.dart';
import 'package:flutter3/View/Components/button.dart';
import 'package:flutter3/View/Components/modal_bottm_sheet.dart';
import 'package:flutter3/View/Components/snackbar.dart';
import 'package:flutter3/data_operations.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Models/home_model.dart
  HomeModel _model = HomeModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DeleteTokenRequest(),
      child: SafeArea(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Color(0xFFfafafa),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.teal,
                title: Text(
                  'صفحه اصلی',
                  style: TextStyle(fontSize: 24),
                ),
                centerTitle: true,
              ),
              body: Consumer<DeleteTokenRequest>(
                builder: (context, req, child) => Stack(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              'خوش آمدید',
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),

                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(14),
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Color(0x9BDFDDDD),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 24, 8, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: textSpan(
                                            label: 'نام کاربری : ',
                                            data: _model.username,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        RichText(
                                          text: textSpan(
                                            label: 'ایمیل : ',
                                            data: _model.email,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 100),

                            // Button
                            // View/Components/button.dart
                            Button(
                              text: 'تغییر رمز',
                              textColor: Colors.white,
                              buttonColor: Colors.blue,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/changePassword');
                              },
                            ),

                            Button(
                              text: 'خروج از حساب',
                              textColor: Colors.white,
                              onPressed: () {
                                modalBottomSheet(
                                  context: context,
                                  onConfirmed: () {
                                    req.deleteToken(
                                      context: context,
                                      username: _model.username,
                                    );
                                  },
                                );
                              },
                              buttonColor: Colors.red,
                            ),

                            Button(
                              text: 'حذف حساب',
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/deleteAccount');
                              },
                              buttonColor: Color(0xFFB81616),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.5 - 45,
                    top: MediaQuery.of(context).size.height * 0.21 - 45,
                    child: Icon(
                      Icons.account_circle_sharp,
                      size: 90,
                      color: Colors.teal,
                    ),
                  ),
                ]),
              ),
            )),
      ),
    );
  }
}
