import 'package:flutter/material.dart';
import 'package:friend_app/constants/theme.dart';
import 'package:friend_app/widgets/custom_text_field.dart';
import 'package:friend_app/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isEmailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
      _isEmailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Forgot Password',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _isEmailSent
                      ? 'We have sent a password reset link to your email. Please check your inbox.'
                      : 'Please enter your email address to receive a link to reset your password',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.lightTextColor,
                  ),
                ),
                if (!_isEmailSent) ...[
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    onPressed: _isLoading ? null : _resetPassword,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Send Reset Link'),
                  ),
                ],
                if (_isEmailSent) ...[
                  const SizedBox(height: 32),
                  const Icon(
                    Icons.mark_email_read_outlined,
                    size: 80,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back to Login'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
