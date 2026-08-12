import 'package:flutter/material.dart';

class SearchEmptyWidget extends StatelessWidget {
  final VoidCallback? onClearSearch;

  const SearchEmptyWidget({
    super.key,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'asset/images/no_result.png',
              width: 120,
              height: 120,
              errorBuilder: (_, __, ___) => Icon(
                Icons.search_off_rounded,
                size: 100,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No characters found',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Try a different name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            if (onClearSearch != null) ...[
              const SizedBox(height: 24),
              TextButton(
                onPressed: onClearSearch,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white70,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Text('Clear search'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}