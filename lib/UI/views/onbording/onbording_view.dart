import 'package:englify_app/UI/views/onbording/onbording_view_model.dart';
import 'package:englify_app/UI/widgets/onbording_slides.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OnbordingView extends StatelessWidget {
  const OnbordingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnbordingViewModel>.reactive(
      viewModelBuilder: () => OnbordingViewModel(),
      builder: (context, model, child) {
        return PageView(
          controller: model.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            OnbordingSlides(
              image: "assets/images/onbording1.png",
              title: "Learn Practical English",
              subtitle:
                  "Build real-life English skills you can use in class, work, and everyday conversations.",
              oncontinue: model.nextpage,
              onskip: model.onskip,
            ),
            OnbordingSlides(
              image: "assets/images/onbording2.png",
              title: "practice. play. improve",
              subtitle:
                  "Learn through short lessons and tasks designed to keep you engaged. ",
              oncontinue: model.nextpage,
              onskip: model.onskip,
            ),
            OnbordingSlides(
              image: "assets/images/onbording3.png",
              title: "built for teachers too",
              subtitle:
                  "Teachers can create activities, track progress, and support learning in one place.",
              oncontinue: model.oncontinue,
              onskip: model.onskip,
            ),
          ],
        );
      },
    );
  }
}
