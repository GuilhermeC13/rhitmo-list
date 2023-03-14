import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhitmo_list/controllers/register_controller.dart';

import '../utils/button_styles.dart';
import 'login_page.dart';
import 'widgets/text_form_widget.dart';

class RegisterPage extends StatelessWidget {
  static const id = '/register_page';
  final RegisterController registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.deepOrange,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Crie sua conta',
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
                      return 'Insira um e-mail';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    registerController.email.value = value;
                  },
                  initialValue: '',
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextFormWidget(
                  label: 'Senha',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira uma senha';
                    } else if (registerController.password.value !=
                        registerController.confirmPassword.value) {
                      return 'As senhas precisam ser iguais';
                    } else if (value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    registerController.password.value = value;
                  },
                  initialValue: '',
                ),
                const SizedBox(
                  height: 24.0,
                ),
                TextFormWidget(
                  label: 'Confirme sua senha',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirme sua senha';
                    } else if (registerController.password.value !=
                        registerController.confirmPassword.value) {
                      return 'As senhas precisam ser iguais';
                    } else if (value.length < 6) {
                      return 'Mínimo 6 caracteres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    registerController.confirmPassword.value = value;
                  },
                  initialValue: '',
                ),
                const SizedBox(
                  height: 32.0,
                ),
                FilledButton(
                  style: filledButtonLargeStyle,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      registerController.signUp();
                    }
                  },
                  child: Obx(() {
                    switch (registerController.state.value) {
                      case RegisterState.loading:
                        return const Center(
                          child: SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )),
                        );
                      case RegisterState.failed:
                        return const Text('Ocorreu um erro');
                      case RegisterState.success:
                        if (registerController.user.value != null) {
                          return const Text('Sucesso!');
                        } else {
                          return const Text('Ocorreu um erro');
                        }
                      default:
                        return const Text(
                          'Entrar',
                        );
                    }
                  }),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Possui uma conta?',
                      style: TextStyle(color: Colors.black54),
                      children: [
                        TextSpan(
                          text: " Clique aqui",
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
        ),
      ),
    );
  }
}
