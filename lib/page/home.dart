import 'package:chat/page/register.dart';
import 'package:chat/page/widget/logo.dart';
import 'package:chat/theme/color.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List profile = [];
  final TextEditingController textbox = TextEditingController();
  List<Widget> widgets = [];
  Future<void> initFun() async {
    profile = await CosmosFirebase.getProfile();
  }

  @override
  void initState() {
    super.initState();
    initFun();
    CosmosFirebase.dataChanged(
      reference: "chat",
      onTap: (element) {
        List singleElement = element as List;
        widgets.add(
          messageComponent(
            context,
            "image",
            singleElement[0],
            singleElement[1],
            "00:00",
            profile[0] == singleElement[0],
          ),
        );
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JeaColor.bgColor,
      body: SafeArea(
        child: SizedBox(
          width: width(context),
          height: height(context),
          child: Column(
            children: [
              top(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CosmosBody(
                    scrollable: true,
                    scrollDirection: Axis.vertical,
                    children: widgets,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: CosmosTextBox(
                          "Mesaj yaz...",
                          color: JeaColor.textColor,
                          controller: textbox,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Mesaj yaz...",
                            hintStyle: TextStyle(
                              color: JeaColor.textColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          if (CosmosFirebase.isSignedIn() == false) {
                            CosmosTools.to(
                              context,
                              const Register(),
                            );
                          } else {
                            List profile = await CosmosFirebase.getProfile();
                            CosmosFirebase.storeValue(
                              "chat",
                              CosmosRandom.randomTag(),
                              [
                                profile[0],
                                textbox.text,
                              ],
                            );
                            textbox.clear();
                          }
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.send_rounded,
                            color: JeaColor.textColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row messageComponent(
    BuildContext context,
    String image,
    String name,
    String message,
    String time,
    bool sender,
  ) {
    return sender == false
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: ClipOval(
                      child: CosmosImage(
                        "assets/image/user.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: width(context) * 0.6,
                decoration: BoxDecoration(
                  color: JeaColor.cColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: JeaColor.textColor.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: JeaColor.textColor.withOpacity(0.8),
                          fontSize: 16,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                              color: JeaColor.textColor.withOpacity(0.5),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                width: width(context) * 0.6,
                decoration: BoxDecoration(
                  color: JeaColor.cColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: JeaColor.textColor.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        message,
                        style: TextStyle(
                          color: JeaColor.textColor.withOpacity(0.8),
                          fontSize: 16,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                              color: JeaColor.textColor.withOpacity(0.5),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: ClipOval(
                      child: CosmosImage(
                        "assets/image/user.png",
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  Widget top(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoChat(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      CosmosAlert.showCustomAlert(
                        context,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: width(context) * 0.8,
                              decoration: BoxDecoration(
                                color: JeaColor.bgColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Menü",
                                    style: TextStyle(
                                      color: JeaColor.textColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        CosmosFirebase.logout();
                                        CosmosTools.to(context, Register());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: JeaColor.cColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          "Çıkış yap",
                                          style: TextStyle(
                                            color: JeaColor.textColor,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.more_vert_outlined,
                        size: 30,
                        color: JeaColor.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width(context),
            height: 1,
            color: JeaColor.textColor.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
