import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _companyController = TextEditingController();

  PasswordRevealMode _passwordRevealMode = PasswordRevealMode.hidden;
  PasswordRevealMode _confirmPasswordRevealMode = PasswordRevealMode.hidden;
  String? _selectedRole;
  bool _acceptTerms = false;

  final List<String> _roles = ['Administrator', 'Manager', 'User', 'Viewer'];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: InfoLabel(
                  label: 'First Name',
                  child: TextFormBox(
                    controller: _firstNameController,
                    placeholder: 'First name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InfoLabel(
                  label: 'Last Name',
                  child: TextFormBox(
                    controller: _lastNameController,
                    placeholder: 'Last name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Email Address',
            child: TextFormBox(
              controller: _emailController,
              placeholder: 'your.email@company.com',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!value.contains('@') || !value.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Company',
            child: TextFormBox(
              controller: _companyController,
              placeholder: 'Your company name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your company name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Role',
            child: ComboBox<String>(
              value: _selectedRole,
              placeholder: const Text('Select your role'),
              items: _roles.map((role) {
                return ComboBoxItem<String>(value: role, child: Text(role));
              }).toList(),
              onChanged: (value) => setState(() => _selectedRole = value),
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Password',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordBox(
                  controller: _passwordController,
                  placeholder: 'Create a password',
                  revealMode: _passwordRevealMode,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ToggleSwitch(
                      content: const Text('Show password'),
                      checked:
                          _passwordRevealMode == PasswordRevealMode.visible,
                      onChanged: (value) {
                        setState(() {
                          _passwordRevealMode = value
                              ? PasswordRevealMode.visible
                              : PasswordRevealMode.hidden;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Confirm Password',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasswordBox(
                  controller: _confirmPasswordController,
                  placeholder: 'Confirm your password',
                  revealMode: _confirmPasswordRevealMode,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ToggleSwitch(
                      content: const Text('Show password'),
                      checked:
                          _confirmPasswordRevealMode ==
                          PasswordRevealMode.visible,
                      onChanged: (value) {
                        setState(() {
                          _confirmPasswordRevealMode = value
                              ? PasswordRevealMode.visible
                              : PasswordRevealMode.hidden;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                checked: _acceptTerms,
                onChanged: (value) =>
                    setState(() => _acceptTerms = value ?? false),
                content: const Text('I accept the terms and conditions'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _acceptTerms ? _register : null,
                  child: const Text('Create Account'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              const SizedBox(width: 8),
              HyperlinkButton(
                onPressed: () => context.go('/login'),
                child: const Text('Sign in'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _register() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty) {
      _showErrorDialog('Please create a password');
      return;
    }

    if (password.length < 8) {
      _showErrorDialog('Password must be at least 8 characters');
      return;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      _showErrorDialog('Password must contain uppercase letters');
      return;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      _showErrorDialog('Password must contain numbers');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Passwords do not match');
      return;
    }

    if (_formKey.currentState!.validate()) {
      _showSuccessDialog(context);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Validation Error'),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Registration Successful'),
        content: const Text(
          'Your account has been created successfully. You can now sign in.',
        ),
        actions: [
          FilledButton(
            child: const Text('Sign In'),
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
