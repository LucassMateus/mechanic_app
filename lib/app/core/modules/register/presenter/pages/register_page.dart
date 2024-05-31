import 'package:flutter/material.dart';
import 'package:mechanic_app/app/core/modules/register/presenter/controllers/register_controller.dart';
import 'package:mechanic_app/app/core/ui/components/custom_text_field.dart';
import 'package:mechanic_app/app/core/ui/components/mechanic_app_logo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.controller});

  final RegisterController controller;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _userEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();
  RegisterController get controller => widget.controller;

  @override
  void dispose() {
    _nameEC.dispose();
    _userEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mechanic App'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: size.width * .45,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: MechanicAppLogo(height: 150),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      label: 'Nome',
                      controller: _nameEC,
                      // validator: Validatorless.multiple([
                      //   Validatorless.required('E-mail obrigatório'),
                      //   Validatorless.email('E-mail inválido'),
                      // ]),
                    ),
                    CustomTextFormField(
                      label: 'E-mail',
                      controller: _emailEC,
                      // validator: Validatorless.multiple([
                      //   Validatorless.required('E-mail obrigatório'),
                      //   Validatorless.email('E-mail inválido'),
                      // ]),
                    ),
                    CustomTextFormField(
                      label: 'Usuário',
                      controller: _userEC,
                      // validator: Validatorless.multiple([
                      //   Validatorless.required('E-mail obrigatório'),
                      //   Validatorless.email('E-mail inválido'),
                      // ]),
                    ),
                    CustomTextFormField(
                      label: 'Senha',
                      controller: _passwordEC,
                      // validator: Validatorless.multiple([
                      //   Validatorless.required('Senha obrigatória'),
                      //   Validatorless.min(
                      //       6, 'Senha deve conter pelo menos 6 caracteres'),
                      // ]),
                    ),
                    CustomTextFormField(
                      label: 'Confirma Senha',
                      controller: _confirmPasswordEC,
                      // validator: Validatorless.multiple([
                      //   Validatorless.required(
                      //       'Senha de confirmação obrigatória'),
                      //   Validators.compare(_passwordEC, 'Senhas diferentes')
                      // ]),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          final formValid =
                              _formKey.currentState?.validate() ?? false;

                          if (formValid) {
                            controller.registerUser(_nameEC.text, _emailEC.text,
                                _userEC.text, _passwordEC.text);
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Salvar'),
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
