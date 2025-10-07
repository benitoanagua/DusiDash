import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!_emailSent) ...[
            Icon(FluentIcons.lock, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Reset Your Password',
              style: FluentTheme.of(context).typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your email address and we\'ll send you a link to reset your password.',
              style: FluentTheme.of(context).typography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            InfoLabel(
              label: 'Email Address',
              child: TextFormBox(
                controller: _emailController,
                placeholder: 'your.email@company.com',
                prefix: const Icon(FluentIcons.mail),
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
            const SizedBox(height: 24),
            _isLoading
                ? const ProgressRing()
                : Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: _resetPassword,
                          child: const Text('Send Reset Link'),
                        ),
                      ),
                    ],
                  ),
          ] else ...[
            const Icon(
              FluentIcons.check_mark,
              size: 64,
              color: Colors.successPrimaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Check Your Email',
              style: FluentTheme.of(context).typography.title,
            ),
            const SizedBox(height: 8),
            Text(
              'We\'ve sent a password reset link to ${_emailController.text}',
              style: FluentTheme.of(context).typography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'If you don\'t see the email, check your spam folder or try again.',
              style: FluentTheme.of(context).typography.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Back to Sign In'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Button(
                    onPressed: () => setState(() => _emailSent = false),
                    child: const Text('Resend Email'),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          HyperlinkButton(
            onPressed: () => context.go('/login'),
            child: const Text('Back to Sign In'),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simular envío de email
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }
}
