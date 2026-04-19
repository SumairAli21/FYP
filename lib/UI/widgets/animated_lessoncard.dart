import 'package:flutter/material.dart';

class AnimatedLessonCard extends StatefulWidget {
  final String? imageUrl;
  final String lessonTitle;
  final bool isLandscape;

  const AnimatedLessonCard({
    super.key,
    required this.imageUrl,
    required this.lessonTitle,
    required this.isLandscape,
  });

  @override
  State<AnimatedLessonCard> createState() => AnimatedLessonCardState();
}

class AnimatedLessonCardState extends State<AnimatedLessonCard>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _slideAnims;
  late List<Animation<double>> _fadeAnims;
  late List<Animation<double>> _scaleAnims;

  final int _cardCount = 3;

  @override
  @override
void initState() {
  super.initState();

  _controllers = List.generate(
    _cardCount,
    (i) => AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + (i * 120)),
    ),
  );

  // 🔹 SLIDE
  _slideAnims = List.generate(
    _cardCount,
    (i) => Tween<Offset>(
      begin: Offset(1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controllers[i],
        curve: Curves.easeOutCubic,
      ),
    ),
  );

  // 🔹 FADE
  _fadeAnims = List.generate(
    _cardCount,
    (i) => Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controllers[i],
        curve: Curves.easeIn,
      ),
    ),
  );

  // 🔥 IMPORTANT (ye missing tha ya wrong place pe tha)
  _scaleAnims = List.generate(
    _cardCount,
    (i) => Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controllers[i],
        curve: Curves.easeOutBack,
      ),
    ),
  );

  _playAnimation();
}

  Future<void> _playAnimation() async {
    for (int i = _cardCount - 1; i >= 0; i--) {
      _controllers[i].forward();
      await Future.delayed(const Duration(milliseconds: 140));
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ✅ smaller card size (better UI)
    final cardWidth =
        widget.isLandscape ? size.height * 0.38 : size.width * 0.55;
    final cardHeight =
        widget.isLandscape ? size.height * 0.52 : size.width * 0.70;

    return SizedBox(
      width: cardWidth + 40,
      height: cardHeight + 30,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// 🔹 Background cards
          for (int i = _cardCount - 1; i >= 1; i--)
            FadeTransition(
              opacity: _fadeAnims[i],
              child: SlideTransition(
                position: _slideAnims[i],
                child: AnimatedBuilder(
                  animation: _controllers[i],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(i * 12, i * 8),
                      child: Transform.rotate(
                        angle:
                            (i * 0.06) * (1 - _controllers[i].value),
                        child: Transform.scale(
                          scale: _scaleAnims[i].value - (i * 0.05),
                          child: child,
                        ),
                      ),
                    );
                  },
                  child:
                      _buildCard(cardWidth, cardHeight, isMain: false),
                ),
              ),
            ),

          /// 🔹 MAIN CARD (🔥 HERO animation)
          FadeTransition(
            opacity: _fadeAnims[0],
            child: SlideTransition(
              position: _slideAnims[0],
              child: AnimatedBuilder(
                animation: _controllers[0],
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnims[0].value,
                    child: Transform.translate(
                      offset: Offset(
                          0, (1 - _controllers[0].value) * 50),
                      child: child,
                    ),
                  );
                },
                child: _buildCard(cardWidth, cardHeight,
                    isMain: true),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(double width, double height,
      {required bool isMain}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isMain ? 0.35 : 0.15),
            blurRadius: isMain ? 22 : 10,
            offset: Offset(0, isMain ? 12 : 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            /// Image
            Positioned.fill(
              child: widget.imageUrl != null &&
                      widget.imageUrl!.isNotEmpty
                  ? Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(color: Colors.black87),
            ),

            /// Title (only main card)
            if (isMain)
              Positioned(
                bottom: 14,
                left: 14,
                right: 14,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    widget.lessonTitle.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}