import 'package:englify_app/UI/views/changepassword/chnagepassword_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
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
          resizeToAvoidBottomInset: true, // ✅ keyboard se resize ho
          body: Stack(
            children: [
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
                    return SingleChildScrollView( // ✅ scroll enable
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              // ── Top bar
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.rs(20),
                                    vertical: context.rs(16)),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: model.onBack,
                                      child: Container(
                                        padding: EdgeInsets.all(context.rs(8)),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.close,
                                            color: Colors.black,
                                            size: context.rs(20)),
                                      ),
                                    ),
                                    SizedBox(width: context.rs(16)),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: context.rf(20),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Spacer(), // ✅ flexible space

                              // ── Card
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.rs(20)),
                                child: Container(
                                  padding: EdgeInsets.all(context.rs(24)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'CREATE PASSWORD',
                                            style: TextStyle(
                                              fontSize: context.rf(20),
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black87,
                                              fontFamily: 'heading',
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: model.onBack,
                                            child: Container(
                                              padding:
                                                  EdgeInsets.all(context.rs(4)),
                                              decoration: const BoxDecoration(
                                                color: Colors.black87,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: context.rs(16)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: context.rs(20)),

                                      _buildLabel(context, 'Old Password'),
                                      SizedBox(height: context.rs(6)),
                                      _buildTextField(
                                        context: context,
                                        controller:
                                            model.oldPasswordController,
                                        hint: 'Enter your old password',
                                        obscure: !model.showOldPassword,
                                        onToggle: model.toggleOldPassword,
                                      ),
                                      SizedBox(height: context.rs(14)),

                                      _buildLabel(context, 'New Password'),
                                      SizedBox(height: context.rs(6)),
                                      _buildTextField(
                                        context: context,
                                        controller:
                                            model.newPasswordController,
                                        hint: 'Enter your new password',
                                        obscure: !model.showNewPassword,
                                        onToggle: model.toggleNewPassword,
                                      ),
                                      SizedBox(height: context.rs(14)),

                                      _buildLabel(context, 'Confirm  Password'),
                                      SizedBox(height: context.rs(6)),
                                      _buildTextField(
                                        context: context,
                                        controller:
                                            model.confirmPasswordController,
                                        hint: 'Enter your confirm password',
                                        obscure: !model.showConfirmPassword,
                                        onToggle: model.toggleConfirmPassword,
                                      ),
                                      SizedBox(height: context.rs(8)),

                                      if (model.errorMessage != null)
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: context.rs(8)),
                                          child: Text(
                                            model.errorMessage!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: context.rf(13),
                                            ),
                                          ),
                                        ),
                                      SizedBox(height: context.rs(8)),

                                      SizedBox(
                                        width: double.infinity,
                                        height: context.rs(50),
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
                                              : () =>
                                                  model.changePassword(context),
                                          child: model.isBusy
                                              ? SizedBox(
                                                  width: context.rs(22),
                                                  height: context.rs(22),
                                                  child:
                                                      const CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 2.5,
                                                  ),
                                                )
                                              : Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    fontSize: context.rf(16),
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

                              const Spacer(), // ✅ flexible bottom space
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

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.rf(14),
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
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
        style: TextStyle(color: Colors.black87, fontSize: context.rf(14)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.grey[400], fontSize: context.rf(13)),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey[500],
              size: context.rs(20),
            ),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.rs(14), vertical: context.rs(12)),
        ),
      ),
    );
  }
}