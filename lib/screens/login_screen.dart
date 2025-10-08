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
  bool _rememberMe = false;
  PasswordRevealMode _revealMode = PasswordRevealMode.hidden;

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoLabel(
            label: 'Username or Email',
            child: TextFormBox(
              controller: _usernameController,
              placeholder: 'Enter your username or email',
              prefix: const Icon(FluentIcons.contact),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username or email';
                }
                if (!value.contains('@') && value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Password',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PasswordBox(
                        controller: _passwordController,
                        placeholder: 'Enter your password',
                        revealMode: _revealMode,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        _revealMode == PasswordRevealMode.visible
                            ? FluentIcons.view
                            : FluentIcons.hide3,
                      ),
                      onPressed: () {
                        setState(() {
                          _revealMode =
                              _revealMode == PasswordRevealMode.visible
                              ? PasswordRevealMode.hidden
                              : PasswordRevealMode.visible;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ToggleSwitch(
                  content: const Text('Show password'),
                  checked: _revealMode == PasswordRevealMode.visible,
                  onChanged: (value) {
                    setState(() {
                      _revealMode = value
                          ? PasswordRevealMode.visible
                          : PasswordRevealMode.hidden;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                checked: _rememberMe,
                onChanged: (value) =>
                    setState(() => _rememberMe = value ?? false),
                content: const Text('Remember me'),
              ),
              const Spacer(),
              HyperlinkButton(
                onPressed: () => context.go('/forgot-password'),
                child: const Text('Forgot password?'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          authProvider.isLoading
              ? const Center(child: ProgressRing())
              : FilledButton(
                  onPressed: () async {
                    final username = _usernameController.text;
                    final password = _passwordController.text;

                    if (username.isEmpty) {
                      _showErrorDialog(
                        context,
                        'Please enter your username or email',
                      );
                      return;
                    }

                    if (!username.contains('@') && username.length < 3) {
                      _showErrorDialog(
                        context,
                        'Username must be at least 3 characters',
                      );
                      return;
                    }

                    if (password.isEmpty) {
                      _showErrorDialog(context, 'Please enter your password');
                      return;
                    }

                    if (password.length < 6) {
                      _showErrorDialog(
                        context,
                        'Password must be at least 6 characters',
                      );
                      return;
                    }

                    final success = await authProvider.login(
                      _usernameController.text,
                      _passwordController.text,
                    );

                    if (success && context.mounted) {
                      context.go('/dashboard');
                    } else if (context.mounted) {
                      _showErrorDialog(
                        context,
                        'Invalid credentials. Please try again.',
                      );
                    }
                  },
                  child: const Text('Sign In'),
                ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              const SizedBox(width: 8),
              HyperlinkButton(
                onPressed: () => context.go('/register'),
                child: const Text('Sign up now'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Button(
            onPressed: () {
              _usernameController.text = 'admin@dusidash.com';
              _passwordController.text = 'password123';
            },
            child: const Text('Use Demo Credentials'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Login Failed'),
        content: Text(message),
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
