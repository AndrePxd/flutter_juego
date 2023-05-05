import 'package:flutter/material.dart';
import 'package:flutter_juego/widgets/card_container.dart';
import 'package:flutter_juego/widgets/custom_material_button.dart';
import 'package:flutter_juego/widgets/custom_text_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardContainer(
                  child: Column(
                    children: [
                      const Image(
                          image: AssetImage('assets/images/don-quijote.png'),
                          height: 120),
                      _loginForm(context),
                    ],
                  ),
                ),
                CardContainer(
                    child: Column(
                  children: [
                    CustomTextButton(
                        icon: Icons.login,
                        text: '¿No tienes cuenta? Regístrate',
                        onPressed: () => Navigator.of(context)
                            .pushNamed('/register_user_screen')),
                    CustomTextButton(
                      icon: Icons.key,
                      text: '¿Olvidaste tu contraseña?',
                      onPressed: () => Navigator.of(context)
                          .pushNamed('/password_recover_screen1'),
                    ),
                  ],
                )),
                const SizedBox(height: 20),
                CustomMaterialButton(
                  text: 'Jugar',
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/levels_screen'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Usuario'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un usuario';
                }
                return null;
              },
              controller: _usernameController,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una contraseña';
                }
                return null;
              },
              controller: _passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
