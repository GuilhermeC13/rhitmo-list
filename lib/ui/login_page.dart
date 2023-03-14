import 'package:flutter/material.dart';

import '../utils/button_styles.dart';
import 'register_page.dart';
import 'widgets/text_form_widget.dart';

class LoginPage extends StatelessWidget {
  static const id = '/login_page';
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Column(
          children: [
            const Text(
              'Entre com a sua conta',
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextFormWidget(
              label: 'E-mail',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {},
              initialValue: '',
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextFormWidget(
              label: 'Senha',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (value) {},
              initialValue: '',
            ),
            const SizedBox(
              height: 32.0,
            ),
            FilledButton(
              style: filledButtonLargeStyle,
              onPressed: () {},
              child: Container(),
            ),
            const SizedBox(
              height: 24.0,
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ),
              child: RichText(
                text: const TextSpan(
                  text: 'Não tem uma conta?',
                  style: TextStyle(color: Colors.black54),
                  children: [
                    TextSpan(
                      text: " Cadastre-se",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}
