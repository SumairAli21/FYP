import 'package:englify_app/UI/views/student_flow/bottom_navigation/bottom_navi_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BottomNaviView extends StatelessWidget {
  const BottomNaviView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNaviViewmodel>.reactive(
      viewModelBuilder: () => BottomNaviViewmodel(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          index: model.currentindex,
          children: model.pages,
        ),
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                model: model,
                icon: Icons.school_outlined,
                activeIcon: Icons.school,
                label: 'Learning',
                index: 0,
              ),
              _buildNavItem(
                context: context,
                model: model,
                icon: Icons.bar_chart_outlined,
                activeIcon: Icons.bar_chart,
                label: 'Dashboard',
                index: 1,
              ),
              _buildNavItem(
                context: context,
                model: model,
                icon: Icons.bookmark_outline,
                activeIcon: Icons.bookmark,
                label: 'Favorites',
                index: 2,
              ),
              _buildNavItem(
                context: context,
                model: model,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required BottomNaviViewmodel model,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    bool isSelected = model.currentindex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () {
          model.onindexchange(index);
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? const Color(0xFF4C6FFF) : Colors.grey[400],
                size: 26,
              ),
              if (isSelected) ...[
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4C6FFF),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}