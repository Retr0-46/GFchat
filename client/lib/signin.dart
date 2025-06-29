import 'package:flutter/material.dart';
import 'registration.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController loginController = TextEditingController();
    final TextEditingController passwordController1 = TextEditingController();
    final TextEditingController passwordController2 = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Text("регистрация",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 16),
              
              // Login field
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                  labelText: 'Логин',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // password field
              TextField(
                controller: passwordController1,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "пароль",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // password field
              TextField(
                controller: passwordController2,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "повтор пароля",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),

              // SignIn button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final password1 = passwordController1.text;
                    final password2 = passwordController2.text;

                    if (password1 != password2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пароли не совпадают'),
                          backgroundColor: Colors.red,
                        )
                      );
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: const Color(0xFF4A90E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Зарегестрироваться",
                    style: TextStyle(fontSize: 16),
                  ),
                  ),
              ),
              const SizedBox(height: 12),

              // Have account button
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
                },
                child: const Text(
                  "У меня уже есть аккаунт",
                  style: TextStyle(color: Color(0xFF4A90E2)),
                  ),
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}