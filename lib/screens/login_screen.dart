import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormBox(
            controller: _usernameController,
            placeholder: 'Username or Email',
            prefix: const Icon(FluentIcons.contact),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormBox(
            controller: _passwordController,
            placeholder: 'Password',
            obscureText: true,
            prefix: const Icon(FluentIcons.password_field),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 3) {
                return 'Password must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          authProvider.isLoading
              ? const ProgressRing()
              : FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await authProvider.login(
                        _usernameController.text,
                        _passwordController.text,
                      );

                      if (success && context.mounted) {
                        context.go('/dashboard');
                      } else if (context.mounted) {
                        showDialog(
                          context: context,
                          builder: (context) => ContentDialog(
                            title: const Text('Login Failed'),
                            content: const Text(
                              'Invalid credentials. Please try again.',
                            ),
                            actions: [
                              Button(
                                child: const Text('OK'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
          const SizedBox(height: 16),
          Button(
            onPressed: () {
              _usernameController.text = 'admin@dusidash.com';
              _passwordController.text = 'password';
            },
            child: const Text('Use Demo Credentials'),
          ),
        ],
      ),
    );
  }
}
