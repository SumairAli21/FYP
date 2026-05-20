
import 'package:englify_app/UI/views/forgatepassword/forpass_view_model.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isLandscape;
    final isSmall = context.isShort;
    final isTablet = context.isTablet;

    return ViewModelBuilder<ForgotPasswordViewmodel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.2)),
              ),

              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              // Top bar
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 32 : 20,
                                  vertical: isLandscape ? 8 : 16,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: model.onBack,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.arrow_back,
                                            color: Colors.black, size: 20),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isTablet ? 22 : 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(),

                              // Card
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 48 : 20,
                                ),
                                child: model.emailSent
                                    ? _buildSuccessCard(model, isTablet)
                                    : _buildFormCard(
                                        model, isTablet, isSmall, isLandscape),
                              ),

                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Email sent success card
  Widget _buildSuccessCard(
      ForgotPasswordViewmodel model, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2F6BFF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: Color(0xFF2F6BFF),
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Check Your Email',
            style: TextStyle(
              fontSize: isTablet ? 24 : 20,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              fontFamily: 'heading',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'We sent a password reset link to\n${model.emailController.text.trim()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 15 : 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check your inbox and follow the link to reset your password.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isTablet ? 13 : 12,
              color: Colors.grey[400],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: model.onSignIn,
              child: Text(
                'Back to Sign In',
                style: TextStyle(
                  fontSize: isTablet ? 17 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Email input form card
  Widget _buildFormCard(ForgotPasswordViewmodel model, bool isTablet,
      bool isSmall, bool isLandscape) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RESET PASSWORD',
                style: TextStyle(
                  fontSize: isTablet ? 22 : 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                  fontFamily: 'heading',
                  letterSpacing: 0.5,
                ),
              ),
              GestureDetector(
                onTap: model.onBack,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close,
                      color: Colors.white, size: 16),
                ),
              ),
            ],
          ),

          SizedBox(height: isSmall ? 8 : 12),

          Text(
            'Enter your registered email address. We\'ll send you a link to reset your password.',
            style: TextStyle(
              fontSize: isTablet ? 14 : 13,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: isSmall ? 16 : 20),

          // Email label
          Text(
            'Email Address',
            style: TextStyle(
              fontSize: isTablet ? 15 : 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),

          // Email field
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: model.errorMessage != null
                    ? Colors.red
                    : Colors.grey.shade300,
              ),
            ),
            child: TextField(
              cursorColor: Colors.black,
              controller: model.emailController,
              onChanged: (_) => model.onEmailChanged(),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle:
                    TextStyle(color: Colors.grey[400], fontSize: 13),
                prefixIcon: Icon(Icons.email_outlined,
                    color: Colors.grey[400], size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 14),
              ),
            ),
          ),

          // Error message
          if (model.errorMessage != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.error_outline,
                    color: Colors.red, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    model.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],

          SizedBox(height: isSmall ? 16 : 24),

          // Submit button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2F6BFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: model.isBusy ? null : model.onContinue,
              child: model.isBusy
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      'Send Reset Link',
                      style: TextStyle(
                        fontSize: isTablet ? 17 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          SizedBox(height: isSmall ? 12 : 16),

          // Back to sign in
          Center(
            child: GestureDetector(
              onTap: model.onSignIn,
              child: RichText(
                text: TextSpan(
                  text: 'Remember your password? ',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: isTablet ? 14 : 13,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: Color(0xFF2F6BFF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}