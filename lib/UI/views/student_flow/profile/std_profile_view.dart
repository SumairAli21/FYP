import 'package:englify_app/UI/views/student_flow/profile/std_profile_viewmodel.dart';
import 'package:englify_app/utils/responsive.dart';
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
                            padding: EdgeInsets.symmetric(
                              horizontal: context.rs(20),
                              vertical: context.rs(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.rf(24),
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'heading',
                                  ),
                                ),
                                GestureDetector(
                                  onTap: model.onSettings,
                                  child: Container(
                                    padding: EdgeInsets.all(context.rs(8)),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.settings_outlined,
                                      color: const Color(0xFF2F6BFF),
                                      size: context.rs(22),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.rs(20),
                              ),
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  // ── Profile Card
                                  Container(
                                    padding: EdgeInsets.all(context.rs(10)),
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
                                                radius: context.rs(42),
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
                                                        size: context.rs(36),
                                                        color: Colors.grey[400],
                                                      )
                                                    : null,
                                              ),
                                              // Upload indicator
                                              if (model.isUploadingImage)
                                                Positioned.fill(
                                                  child: CircleAvatar(
                                                    radius: context.rs(36),
                                                    backgroundColor: Colors
                                                        .black
                                                        .withOpacity(0.4),
                                                    child: SizedBox(
                                                      width: context.rs(20),
                                                      height: context.rs(20),
                                                      child:
                                                          const CircularProgressIndicator(
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
                                                  padding: EdgeInsets.all(
                                                    context.rs(4),
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Color(
                                                          0xFF2F6BFF,
                                                        ),
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                    size: context.rs(12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: context.rs(14)),

                                        // User info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.username,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: context.rf(18),
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
                                                      size: context.rs(13),
                                                      color: Colors.grey[500],
                                                    ),
                                                    SizedBox(
                                                        width: context.rs(2)),
                                                    Flexible(
                                                      child: Text(
                                                        model.location.isEmpty
                                                            ? 'Add location'
                                                            : model.location,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize:
                                                              context.rf(13),
                                                          color:
                                                              model
                                                                  .location
                                                                  .isEmpty
                                                              ? Colors.blue
                                                              : Colors
                                                                  .grey[600],
                                                        ),
                                                      ),
                                                    ),
                                                    if (model.location.isEmpty)
                                                      Icon(
                                                        Icons.edit,
                                                        size: context.rs(12),
                                                        color: Colors.blue,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: context.rs(6)),
                                              Row(
                                                children: [
                                                  // Level badge
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          horizontal:
                                                              context.rs(8),
                                                          vertical:
                                                              context.rs(3),
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
                                                        Icon(
                                                          Icons.bar_chart,
                                                          color: Colors.white,
                                                          size: context.rs(13),
                                                        ),
                                                        SizedBox(
                                                          width: context.rs(3),
                                                        ),
                                                        Text(
                                                          model.levelText,
                                                          style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    context
                                                                        .rf(12),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: context.rs(8)),

                                                  // Points badge
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/coins.png',
                                                        height: context.rs(16),
                                                        width: context.rs(16),
                                                      ),
                                                      SizedBox(
                                                          width:
                                                              context.rs(3)),
                                                      Text(
                                                        model.pointsText,
                                                        style: TextStyle(
                                                          fontSize:
                                                              context.rf(12),
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
                                  SizedBox(height: context.rs(16)),

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
                                          context: context,
                                          icon: Icons.volume_up_outlined,
                                          iconColor: Colors.blue,
                                          label: 'Sound',
                                          value: model.isSoundEnabled,
                                          onChanged: (_) => model.toggleSound(),
                                        ),
                                        _divider(),

                                        // Notification
                                        _buildToggleItem(
                                          context: context,
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
                                          context: context,
                                          icon: Icons.menu_book_outlined,
                                          iconColor: Colors.green,
                                          label: 'Rules',
                                          onTap: model.onRules,
                                        ),
                                        _divider(),

                                        // Feedback
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.feedback_outlined,
                                          iconColor: Colors.teal,
                                          label: 'Feedback',
                                          onTap: model.onFeedback,
                                        ),
                                        _divider(),

                                        // Terms of Service
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.description_outlined,
                                          iconColor: Colors.indigo,
                                          label: 'Terms of Service',
                                          onTap: model.onTerms,
                                        ),
                                        _divider(),

                                        // Privacy Policy
                                        _buildNavItem(
                                          context: context,
                                          icon: Icons.privacy_tip_outlined,
                                          iconColor: Colors.purple,
                                          label: 'Privacy Policy',
                                          onTap: model.onPrivacy,
                                        ),
                                        _divider(),

                                        // Change Password
                                        _buildNavItem(
                                          context: context,
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
                                  SizedBox(height: context.rs(16)),

                                  // ── Delete / Logout button
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: _buildNavItem(
                                      context: context,
                                      icon: Icons.logout,
                                      iconColor: Colors.red,
                                      label: 'Logout',
                                      labelColor: Colors.red,
                                      onTap: () =>
                                          _showLogoutDialog(context, model),
                                    ),
                                  ),
                                  SizedBox(height: context.rs(30)),
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
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(16), vertical: context.rs(4)),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(context.rs(6)),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: context.rs(20)),
          ),
          SizedBox(width: context.rs(12)),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.rf(15),
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
    required BuildContext context,
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
        padding: EdgeInsets.symmetric(
            horizontal: context.rs(16), vertical: context.rs(12)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(context.rs(6)),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: context.rs(20)),
            ),
            SizedBox(width: context.rs(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.rf(15),
                      fontWeight: FontWeight.w500,
                      color: labelColor ?? Colors.black87,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: context.rf(11), color: Colors.grey[500]),
                    ),
                ],
              ),
            ),
            if (onTap != null && labelColor == null)
              Icon(Icons.chevron_right,
                  color: Colors.grey[400], size: context.rs(20)),
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
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Colors.black,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'e.g. Karachi, Pakistan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
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
        content: const SingleChildScrollView(
          child: Text('Are you sure you want to logout?'),
        ),
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
