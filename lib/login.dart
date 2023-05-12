import 'package:flutter/material.dart';
import 'package:flutter_juego/menu.dart';
import 'package:flutter_juego/widgets/card_container.dart';
import 'package:flutter_juego/widgets/custom_material_button.dart';
import 'package:flutter_juego/widgets/custom_text_button.dart';
import 'package:flutter_juego/router/app_routes.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  // final _usernameController = TextEditingController();

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
                  ],
                )),
                const SizedBox(height: 20),
                CustomMaterialButton(
                  text: 'Jugar',
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MenuScreen())),
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
              decoration: const InputDecoration(labelText: 'Jugador'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese su nickname';
                }
                return null;
              },
              // controller: _usernameController,
            ),
          ],
        ),
      ),
    );
  }
}
