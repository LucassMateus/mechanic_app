import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mechanic_app/app/core/modules/auth/presenter/controllers/auth_controller.dart';
import 'package:mechanic_app/app/core/state/base_state.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/mechanic_app_logo.dart';

import '../../../../ui/alerts/alerts.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.controller});

  final AuthController controller;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthController get controller => widget.controller;

  final formKey = GlobalKey<FormState>();
  final userEC = TextEditingController(text: 'lucas.mateus');
  final passwordEC = TextEditingController(text: 'teste');

  @override
  void initState() {
    controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    return switch (controller.state) {
      SuccessState() => Modular.to.navigate('/home/'),
      ErrorState(:final exception) =>
        Alerts.showFailure(context, exception.toString()),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: constraints.maxHeight, maxWidth: 350),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const MechanicAppLogo(height: 150),
                          const SizedBox(height: 20),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  label: 'Usuario',
                                  controller: userEC,
                                ),
                                const SizedBox(height: 20),
                                CustomTextFormField(
                                  label: 'Senha',
                                  controller: passwordEC,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ValueListenableBuilder(
                            valueListenable: controller,
                            builder: (_, state, child) {
                              return switch (state) {
                                LoadingState() => const SizedBox(
                                  height: 50,
                                  child: Center(
                                      child: CircularProgressIndicator.adaptive(),
                                    ),
                                ),
                                _ => ElevatedButton(
                                    onPressed: () async {
                                      await controller.login(
                                          userEC.text, passwordEC.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(double.maxFinite, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                    ),
                                    child: const Text('Entrar'),
                                  ),
                              };
                            },
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Não tem conta?'),
                              TextButton(
                                onPressed: () {
                                  Modular.to.pushNamed('/register/');
                                },
                                child: const Text('Cadastre-se'),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
