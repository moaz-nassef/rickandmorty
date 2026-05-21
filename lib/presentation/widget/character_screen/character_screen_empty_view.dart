import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';

class CharacterScreenEmptyView extends StatelessWidget {
  const CharacterScreenEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.manage_search_rounded,
              color: Mycoloer.myyellow,
              size: 56,
            ),
            const SizedBox(height: 14),
            const Text(
              'No characters found',
              style: TextStyle(
                color: Mycoloer.mywhite,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try another name in the portal search.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Mycoloer.mywhite.withValues(alpha: .62),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
