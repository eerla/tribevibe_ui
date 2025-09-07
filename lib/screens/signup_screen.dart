import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../theme/app_colors.dart';

class SignupSheet extends StatefulWidget {
  const SignupSheet({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SignupSheet(),
    );
  }

  @override
  _SignupSheetState createState() => _SignupSheetState();
}

class _SignupSheetState extends State<SignupSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signup() async {
    setState(() { isLoading = true; error = null; });
    final success = await AuthService().register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );
    setState(() { isLoading = false; });
    if (success) {
      Navigator.pop(context); // Close the sheet
      // Optionally, show a success message or trigger login sheet
    } else {
      setState(() { error = 'Signup failed'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final isDesktop = breakpoints.isDesktop || breakpoints.isTablet;
    final double maxWidth = isDesktop ? 420 : 600;
    final double horizontalPadding = isDesktop ? 48 : 32;
    final double verticalPadding = isDesktop ? 40 : 24;
    final double titleFontSize = isDesktop ? 28 : 32;
    final double fieldFontSize = isDesktop ? 18 : 22;
    final double buttonFontSize = isDesktop ? 18 : 22;
    final double textFontSize = isDesktop ? 16 : 18;
    final double spacingLarge = isDesktop ? 24 : 32;
    final double spacingMedium = isDesktop ? 16 : 24;
    final double spacingSmall = isDesktop ? 12 : 16;

    return DraggableScrollableSheet(
      initialChildSize: isDesktop ? 0.8 : 0.7,
      minChildSize: isDesktop ? 0.6 : 0.5,
      maxChildSize: isDesktop ? 0.95 : 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: isDesktop
                    ? [BoxShadow(color: Colors.black12, blurRadius: 32, spreadRadius: 2)]
                    : [],
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    top: verticalPadding,
                    bottom: MediaQuery.of(context).viewInsets.bottom + verticalPadding,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: EdgeInsets.only(bottom: spacingSmall),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: spacingLarge),
                        CustomTextField(
                          label: 'Name',
                          controller: _nameController,
                          fontSize: fieldFontSize,
                        ),
                        SizedBox(height: spacingMedium),
                        CustomTextField(
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          fontSize: fieldFontSize,
                        ),
                        SizedBox(height: spacingMedium),
                        CustomTextField(
                          label: 'Password',
                          controller: _passwordController,
                          obscureText: true,
                          fontSize: fieldFontSize,
                        ),
                        SizedBox(height: spacingLarge),
                        if (error != null)
                          Text(
                            error!,
                            style: TextStyle(color: Color(0xFFC9ADA7), fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        if (error != null) SizedBox(height: spacingSmall),
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _signup();
                                  }
                                },
                                color: AppColors.button,
                                fontSize: buttonFontSize,
                              ),
                        SizedBox(height: spacingMedium),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close signup sheet
                            // Optionally, show login sheet here
                          },
                          child: Text(
                            'Already have an account? Login',
                            style: TextStyle(fontSize: textFontSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

