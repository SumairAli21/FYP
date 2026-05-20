import 'package:englify_app/UI/views/Role_selection/role_selection_view_model.dart';
import 'package:englify_app/UI/widgets/reusable_button_white.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RoleSelection extends StatelessWidget {
  const RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<RoleSelectionViewModel>.reactive(
      viewModelBuilder: () => RoleSelectionViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: LayoutBuilder(
            builder: (context, c) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: c.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      SizedBox(
                        height: context.heightPercent(65),
                        width: size.width,
                        child: Image.asset("assets/images/choserole.png",
                        fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.rs(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: context.rs(13),),
                            Text(
                              "Choose you role".toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "heading",
                                fontSize: context.rf(24),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(height: context.rs(13),),
                            Text(
                              "Choose how you want to use the app.\nYou can change this anytime later.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: "button",
                                color: Colors.white70,
                                fontSize: context.rf(16)
                              ),
                            ),
                            Spacer(),

                            AppButton(title: "Continue as Student", onTap: model.savestudentrole,),

                            SizedBox(height: context.rs(10),),

                            AppButtonWhite(title: "Continue as Teacher", onTap: model.selectteacherrole,),
                            SizedBox(height: context.rs(15),),
                       ],
                        ),

                        )
                      ),
                    ],
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
