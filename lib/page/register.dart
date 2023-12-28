import 'package:chat/page/home.dart';
import 'package:chat/page/widget/logo.dart';
import 'package:chat/theme/color.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JeaColor.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LogoChat(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    width: width(context) * 0.6,
                    child: Row(
                      children: [
                        Expanded(
                          child: CosmosTextBox(
                            "E-posta",
                            controller: email,
                            color: JeaColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SizedBox(
                    width: width(context) * 0.6,
                    child: Row(
                      children: [
                        Expanded(
                          child: CosmosTextBox(
                            "Parola",
                            controller: password,
                            color: JeaColor.textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (email.text != "" && password.text != "") {
                      List status = await CosmosFirebase.register(
                        email.text,
                        password.text,
                        [
                          email.text.split("@")[0],
                        ],
                      );
                      if (status[0].toString() == "1") {
                        // ignore: use_build_context_synchronously
                        CosmosTools.to(
                          context,
                          const HomePage(),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        CosmosAlert.showIOSStyleAlert(
                          context,
                          "Giriş hatası",
                          status[1].toString(),
                        );
                      }
                    } else {
                      CosmosAlert.showIOSStyleAlert(
                        context,
                        "Hata",
                        "Email ve parolanın boş olmadığından emin olun.",
                      );
                    }
                  },
                  child: const Text(
                    "Kayıt Ol",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
