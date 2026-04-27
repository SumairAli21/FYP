import 'package:englify_app/UI/views/student_flow/profile/std_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StdProfileView extends StatelessWidget {
  const StdProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewmodel>.reactive(
      viewModelBuilder: () => ProfileViewmodel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // ── Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.15)),
              ),

              SafeArea(
                child: model.isBusy
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Column(
                        children: [
                          // ── Top bar
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'heading',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: model.onSettings,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.settings_outlined,
                                      color: Color(0xFF2F6BFF),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  // ── Profile Card
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        // Profile image
                                        GestureDetector(
                                          onTap: model.pickAndUploadImage,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 42,
                                                backgroundColor:
                                                    Colors.grey[200],
                                                backgroundImage:
                                                    model.profileImageUrl !=
                                                        null
                                                    ? NetworkImage(
                                                        model.profileImageUrl!,
                                                      )
                                                    : null,
                                                child:
                                                    model.profileImageUrl ==
                                                        null
                                                    ? Icon(
                                                        Icons.person,
                                                        size: 36,
                                                        color: Colors.grey[400],
                                                      )
                                                    : null,
                                              ),
                                              // Upload indicator
                                              if (model.isUploadingImage)
                                                Positioned.fill(
                                                  child: CircleAvatar(
                                                    radius: 36,
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.4),
                                                    child: const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 2,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              // Camera icon
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    4,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Color(
                                                          0xFF2F6BFF,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: const Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                    size: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 14),

                                        // User info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.username,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    _showLocationDialog(
                                                      context,
                                                      model,
                                                    ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 13,
                                                      color: Colors.grey[500],
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      model.location.isEmpty
                                                          ? 'Add location'
                                                          : model.location,
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            model
                                                                .location
                                                                .isEmpty
                                                            ? Colors.blue
                                                            : Colors.grey[600],
                                                      ),
                                                    ),
                                                    if (model.location.isEmpty)
                                                      Icon(
                                                        Icons.edit,
                                                        size: 12,
                                                        color: Colors.blue,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Row(
                                                children: [
                                                  // Level badge
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 3,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                        0xFF2F6BFF,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.bar_chart,
                                                          color: Colors.white,
                                                          size: 13,
                                                        ),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          model.levelText,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),

                                                  // Points badge
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/coins.png',
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        model.pointsText,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // ── Settings Card
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Sound
                                        _buildToggleItem(
                                          icon: Icons.volume_up_outlined,
                                          iconColor: Colors.blue,
                                          label: 'Sound',
                                          value: model.isSoundEnabled,
                                          onChanged: (_) => model.toggleSound(),
                                        ),
                                        _divider(),

                                        // Notification
                                        _buildToggleItem(
                                          icon: Icons.notifications_outlined,
                                          iconColor: Colors.orange,
                                          label: 'Notification',
                                          value: model.isNotificationEnabled,
                                          onChanged: (_) =>
                                              model.toggleNotification(),
                                        ),
                                        _divider(),

                                        // Rules
                                        _buildNavItem(
                                          icon: Icons.menu_book_outlined,
                                          iconColor: Colors.green,
                                          label: 'Rules',
                                          onTap: model.onRules,
                                        ),
                                        _divider(),

                                        // Feedback
                                        _buildNavItem(
                                          icon: Icons.feedback_outlined,
                                          iconColor: Colors.teal,
                                          label: 'Feedback',
                                          onTap: model.onFeedback,
                                        ),
                                        _divider(),

                                        // Terms of Service
                                        _buildNavItem(
                                          icon: Icons.description_outlined,
                                          iconColor: Colors.indigo,
                                          label: 'Terms of Service',
                                          onTap: model.onTerms,
                                        ),
                                        _divider(),

                                        // Privacy Policy
                                        _buildNavItem(
                                          icon: Icons.privacy_tip_outlined,
                                          iconColor: Colors.purple,
                                          label: 'Privacy Policy',
                                          onTap: model.onPrivacy,
                                        ),
                                        _divider(),

                                        // Change Password
                                        _buildNavItem(
                                          icon: Icons.lock_outline,
                                          iconColor: model.isGoogleAccount
                                              ? Colors.grey
                                              : Colors.red,
                                          label: 'Change Password',
                                          onTap: model.isGoogleAccount
                                              ? null
                                              : model.onChangePassword,
                                          subtitle: model.isGoogleAccount
                                              ? 'Not available for Google accounts'
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // ── Delete / Logout button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _buildNavItem(
                                      icon: Icons.logout,
                                      iconColor: Colors.red,
                                      label: 'Logout',
                                      labelColor: Colors.red,
                                      onTap: () =>
                                          _showLogoutDialog(context, model),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch(
              value: value,
              onChanged: onChanged,

              // white thumb
              thumbColor: MaterialStateProperty.all(Colors.white),

              // custom track color
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF2F6BFF);
                }
                return Colors.grey.shade400;
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ── Nav item
  Widget _buildNavItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback? onTap,
    String? subtitle,
    Color? labelColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: labelColor ?? Colors.black87,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                    ),
                ],
              ),
            ),
            if (onTap != null && labelColor == null)
              Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Divider(height: 1, color: Colors.grey[200]),
  );

  void _showLocationDialog(BuildContext context, ProfileViewmodel model) {
    final controller = TextEditingController(text: model.location);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Add Location'),
        content: TextField(
          cursorColor: Colors.black,
          controller: controller,
          decoration: InputDecoration(
            hintText: 'e.g. Karachi, Pakistan',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F6BFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              model.updateLocation(controller.text.trim());
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Logout dialog
  void _showLogoutDialog(BuildContext context, ProfileViewmodel model) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              model.logout(context);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
