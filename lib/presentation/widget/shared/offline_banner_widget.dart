import 'package:flutter/material.dart';
import 'package:rickandmorty/presentation/widget/shared/app_interaction_feedback.dart';

class OfflineBannerWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const OfflineBannerWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.26)),
      ),
      child: Row(
        children: [
          Icon(Icons.wifi_off_rounded, size: 18, color: Colors.amber[800]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Offline — showing cached data',
              style: TextStyle(
                color: Colors.amber[800],
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              AppInteractionFeedback.tap();
              onRetry();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.amber[800],
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
