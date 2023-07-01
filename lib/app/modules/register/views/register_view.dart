import 'package:blabber_mobile/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 90),
              Text(
                "Register",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Create new account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              TextFormField(
                controller: _lastnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "lastname",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter lastname.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _firstnameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "firstname",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter firstname.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "username",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter username.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                obscureText: controller.obscurePassword.value,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.obscurePassword.value = !controller.obscurePassword.value;
                      },
                      icon: controller.obscurePassword.value
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.pink
                ),
                onPressed: () async {
                  if (_formkey.currentState?.validate() ?? false) {
                    await controller.register(_emailController.text, _passwordController.text, _firstnameController.text, _lastnameController.text, _usernameController.text);
                  }
                },
                child: controller.isLoading.value ? CircularProgressIndicator(color: Colors.white, strokeWidth: 2,) : const Text("Register"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Have you already an account?"),
                  TextButton(
                    onPressed: () {
                      _formkey.currentState?.reset();
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: const Text("Login", style: TextStyle(color: Colors.pink, fontSize: 16),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
