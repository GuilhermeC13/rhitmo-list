import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/controllers/login_controller.dart';
import 'package:rhitmo_list/ui/pages/home_page.dart';

import '../../utils/button_styles.dart';
import 'register_page.dart';
import '../widgets/loaging_overlay_widget.dart';
import '../widgets/text_form_widget.dart';

class LoginPage extends StatelessWidget {
  static const id = '/login_page';
  final LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Entre com a sua conta',
                style: TextStyle(
                  color: Color(0xFF0A0A3A),
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
                    return 'Insira um e-mail';
                  }
                  return null;
                },
                onChanged: (value) {
                  loginController.emailLogin.value = value;
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              TextFormWidget(
                label: 'Senha',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma senha';
                  } else if (value.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }
                  return null;
                },
                onChanged: (value) {
                  loginController.passwordLogin.value = value;
                },
                obscureText: true,
              ),
              const SizedBox(
                height: 32.0,
              ),
              FilledButton(
                style: filledButtonLargeStyle,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    loginController.logIn();
                    LoadingOverlayWidget.show(message: 'Entrando...');
                    try {
                      await loginController.logIn();
                      Get.offAllNamed(HomePage.id);
                    } catch (err, _) {
                      printError(info: err.toString());
                      LoadingOverlayWidget.hide();
                      Get.snackbar(
                        "Erro",
                        err.toString(),
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.red.withOpacity(.75),
                        colorText: Colors.white,
                        icon: const Icon(Icons.error, color: Colors.white),
                        shouldIconPulse: true,
                        barBlur: 20,
                      );
                    } finally {}
                  }
                },
                child: const Text(
                  'Entrar',
                ),
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
                        style: TextStyle(
                          color: Color(0xFF0A0A3A),
                        ),
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
      ),
    );
  }
}
