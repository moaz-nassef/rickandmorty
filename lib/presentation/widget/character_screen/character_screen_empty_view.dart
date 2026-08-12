import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/shared/app_interaction_feedback.dart';

class CharacterScreenEmptyView extends StatelessWidget {
  final VoidCallback onClearSearch;

  const CharacterScreenEmptyView({super.key, required this.onClearSearch});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 176,
              height: 176,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff102126).withValues(alpha: 0.7),
                border: Border.all(
                  color: Mycoloer.myyellow.withValues(alpha: 0.16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff9dff35).withValues(alpha: 0.14),
                    blurRadius: 36,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Image.asset('asset/images/wifi_off.png'),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No portal match found',
              style: TextStyle(
                color: Mycoloer.mywhite,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This character is not in the loaded universe. Try another name.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Mycoloer.mywhite.withValues(alpha: .62),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              key: const Key('clear_search_button'),
              style: FilledButton.styleFrom(
                backgroundColor: Mycoloer.myyellow,
                foregroundColor: const Color(0xff132318),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
              ),
              onPressed: () {
                AppInteractionFeedback.tap();
                onClearSearch();
              },
              icon: const Icon(Icons.close_rounded),
              label: const Text('Clear search'),
            ),
          ],
        ),
      ),
    );
  }
}
