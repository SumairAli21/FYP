import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/quiz_attempt_detail_viewmodel.dart';
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart'
    show trackerScoreColor;
import 'package:englify_app/models/quiz_attempt_model.dart';
import 'package:englify_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class QuizAttemptDetailView extends StatelessWidget {
  final QuizAttemptRecord attempt;
  const QuizAttemptDetailView({super.key, required this.attempt});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuizAttemptDetailViewmodel>.reactive(
      viewModelBuilder: () => QuizAttemptDetailViewmodel(attempt),
      builder: (context, model, child) {
        final a = model.attempt;
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.25)),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ── App bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.rs(16),
                          vertical: context.rs(12)),
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
                              child: Icon(Icons.arrow_back,
                                  color: Colors.black, size: context.rs(20)),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Quiz Result',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: context.rf(20)),
                              ),
                            ),
                          ),
                          SizedBox(width: context.rs(36)),
                        ],
                      ),
                    ),

                    // ── Body
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(context.rs(16),
                            context.rs(4), context.rs(16), context.rs(24)),
                        children: [
                          _ScoreHeader(attempt: a),
                          SizedBox(height: context.rs(14)),
                          if (!a.hasAnswerDetail)
                            const _NoDetailCard()
                          else
                            ...List.generate(
                              a.answers.length,
                              (i) => Padding(
                                padding:
                                    EdgeInsets.only(bottom: context.rs(12)),
                                child: _QuestionCard(
                                  number: i + 1,
                                  answer: a.answers[i],
                                ),
                              ),
                            ),
                        ],
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
}

// ───────────────────────────── Score header ─────────────────────────────

class _ScoreHeader extends StatelessWidget {
  final QuizAttemptRecord attempt;
  const _ScoreHeader({required this.attempt});

  @override
  Widget build(BuildContext context) {
    final color = trackerScoreColor(attempt.percent);

    return Container(
      padding: EdgeInsets.all(context.rs(18)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attempt.lessonTitle,
            style: TextStyle(
              fontSize: context.rf(18),
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          if (attempt.studentName.isNotEmpty) ...[
            SizedBox(height: context.rs(3)),
            Text(
              'Attempted by ${attempt.studentName}',
              style: TextStyle(
                  fontSize: context.rf(12), color: Colors.grey[600]),
            ),
          ],
          SizedBox(height: context.rs(16)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${attempt.score}',
                style: TextStyle(
                  fontSize: context.rf(36),
                  fontWeight: FontWeight.w900,
                  color: color,
                  height: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: context.rs(4)),
                child: Text(
                  ' / ${attempt.totalPoints} pts',
                  style: TextStyle(
                      fontSize: context.rf(15), color: Colors.grey[600]),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.rs(12), vertical: context.rs(7)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${attempt.percent.round()}%',
                  style: TextStyle(
                    fontSize: context.rf(15),
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          if (attempt.hasAnswerDetail) ...[
            SizedBox(height: context.rs(14)),
            const Divider(height: 1),
            SizedBox(height: context.rs(12)),
            Row(
              children: [
                Icon(Icons.check_circle_rounded,
                    size: context.rs(16), color: trackerScoreColor(100)),
                SizedBox(width: context.rs(5)),
                Text(
                  '${attempt.correctCount} of ${attempt.answers.length} correct',
                  style: TextStyle(
                      fontSize: context.rf(12), color: Colors.black54),
                ),
                const Spacer(),
                if (attempt.attemptedAt != null) ...[
                  Icon(Icons.event_rounded,
                      size: context.rs(16), color: Colors.grey[500]),
                  SizedBox(width: context.rs(5)),
                  Text(
                    _formatDate(attempt.attemptedAt!),
                    style: TextStyle(
                        fontSize: context.rf(12), color: Colors.black54),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ──────────────────────────── Question card ────────────────────────────

class _QuestionCard extends StatelessWidget {
  final int number;
  final QuizAnswerRecord answer;

  const _QuestionCard({required this.number, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.rs(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.rs(10), vertical: context.rs(4)),
                decoration: BoxDecoration(
                  color: const Color(0xFF2F6BFF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Question $number',
                  style: TextStyle(
                    fontSize: context.rf(11),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2F6BFF),
                  ),
                ),
              ),
              const Spacer(),
              if (!answer.wasAnswered)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.rs(10), vertical: context.rs(4)),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5484D).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Not answered',
                    style: TextStyle(
                      fontSize: context.rf(11),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFE5484D),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.rs(10)),
          Text(
            answer.questionText,
            style: TextStyle(
              fontSize: context.rf(15),
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          SizedBox(height: context.rs(12)),
          ...List.generate(
            answer.options.length,
            (i) => Padding(
              padding: EdgeInsets.only(bottom: context.rs(8)),
              child: _OptionRow(
                text: answer.options[i],
                isCorrect: i == answer.correctIndex,
                isSelected: i == answer.selectedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final bool isSelected;

  const _OptionRow({
    required this.text,
    required this.isCorrect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF22A45D);
    const red = Color(0xFFE5484D);

    late final Color bg;
    late final Color border;
    late final IconData icon;
    late final Color iconColor;
    String? tag;
    Color tagColor = Colors.transparent;

    if (isCorrect) {
      bg = green.withOpacity(0.10);
      border = green.withOpacity(0.55);
      icon = Icons.check_circle_rounded;
      iconColor = green;
      tag = isSelected ? 'Your answer' : 'Correct answer';
      tagColor = green;
    } else if (isSelected) {
      bg = red.withOpacity(0.10);
      border = red.withOpacity(0.55);
      icon = Icons.cancel_rounded;
      iconColor = red;
      tag = 'Your answer';
      tagColor = red;
    } else {
      bg = Colors.grey.withOpacity(0.08);
      border = Colors.grey.withOpacity(0.25);
      icon = Icons.radio_button_unchecked_rounded;
      iconColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.rs(12), vertical: context.rs(11)),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, size: context.rs(18), color: iconColor),
          SizedBox(width: context.rs(10)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.rf(13.5),
                color: Colors.black87,
              ),
            ),
          ),
          if (tag != null) ...[
            SizedBox(width: context.rs(8)),
            Text(
              tag,
              style: TextStyle(
                fontSize: context.rf(11),
                fontWeight: FontWeight.w700,
                color: tagColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NoDetailCard extends StatelessWidget {
  const _NoDetailCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.rs(20)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.96),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(Icons.history_toggle_off_rounded,
              size: context.rs(40), color: Colors.grey[400]),
          SizedBox(height: context.rs(10)),
          Text(
            'Per-question detail wasn\'t recorded for this attempt.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.rf(13), color: Colors.black54),
          ),
          SizedBox(height: context.rs(4)),
          Text(
            'It will appear for quizzes attempted from now on.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.rf(12), color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}

String _formatDate(DateTime d) {
  final dd = d.day.toString().padLeft(2, '0');
  final mm = d.month.toString().padLeft(2, '0');
  return '$dd/$mm/${d.year}';
}
