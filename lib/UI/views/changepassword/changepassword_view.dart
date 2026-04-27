import 'package:englify_app/UI/views/changepassword/chnagepassword_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChnagepasswordViewmodel>.reactive(
      viewModelBuilder: () => ChnagepasswordViewmodel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // ── Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png', // ← apni background image
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),

              SafeArea(
                child: Column(
                  children: [
                    // ── Top bar — Profile header visible
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
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
                              child: const Icon(Icons.close,
                                  color: Colors.black, size: 20),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // ── Change Password Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.92),
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
                            // ── Header
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'CREATE PASSWORD',
                                  style: TextStyle(
                                    fontSize: 20,
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
                            const SizedBox(height: 20),

                            // ── Old Password
                            _buildLabel('Old Password'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: model.oldPasswordController,
                              hint: 'Enter your old password',
                              obscure: !model.showOldPassword,
                              onToggle: model.toggleOldPassword,
                            ),
                            const SizedBox(height: 14),

                            // ── New Password
                            _buildLabel('New Password'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: model.newPasswordController,
                              hint: 'Enter your new password',
                              obscure: !model.showNewPassword,
                              onToggle: model.toggleNewPassword,
                            ),
                            const SizedBox(height: 14),

                            // ── Confirm Password
                            _buildLabel('Confirm  Password'),
                            const SizedBox(height: 6),
                            _buildTextField(
                              controller: model.confirmPasswordController,
                              hint: 'Enter your confirm password',
                              obscure: !model.showConfirmPassword,
                              onToggle: model.toggleConfirmPassword,
                            ),
                            const SizedBox(height: 8),

                            // ── Error message
                            if (model.errorMessage != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  model.errorMessage!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),

                            // ── Save button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF2F6BFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: model.isBusy
                                    ? null
                                    : () => model.changePassword(context),
                                child: model.isBusy
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        cursorColor: Colors.black,
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.grey[500],
              size: 20,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}
