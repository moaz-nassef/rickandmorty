import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/shared/app_interaction_feedback.dart';

class PaginationBar extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const PaginationBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
  });

  @override
  State<PaginationBar> createState() => _PaginationBarState();
}

class _PaginationBarState extends State<PaginationBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeSlide = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPrevious = widget.currentPage > 1;
    final hasNext = widget.currentPage < widget.totalPages;

    return FadeTransition(
      opacity: _fadeSlide,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(_fadeSlide),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xff1e282f),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Mycoloer.myyellow.withValues(alpha: 0.12),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PageButton(
                icon: Icons.chevron_left_rounded,
                enabled: hasPrevious,
                onTap: widget.onPrevious,
              ),
              const SizedBox(width: 8),
              _PageIndicator(
                currentPage: widget.currentPage,
                totalPages: widget.totalPages,
              ),
              const SizedBox(width: 8),
              _PageButton(
                icon: Icons.chevron_right_rounded,
                enabled: hasNext,
                onTap: widget.onNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _PageButton({required this.icon, required this.enabled, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: enabled
            ? () {
                AppInteractionFeedback.tap();
                onTap?.call();
              }
            : null,
        child: AnimatedScale(
          scale: enabled ? 1 : 0.85,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: enabled
                  ? Mycoloer.myyellow.withValues(alpha: 0.12)
                  : Colors.transparent,
            ),
            child: Icon(
              icon,
              color: enabled
                  ? Mycoloer.myyellow
                  : Mycoloer.mywhite.withValues(alpha: 0.2),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 18,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(totalPages.clamp(0, 10), (i) {
                  final pageNum = i + 1;
                  final isActive = pageNum == currentPage;
                  final isNearActive = (pageNum - currentPage).abs() <= 1;

                  if (!isNearActive && i > 2 && i < 9) {
                    if (i == 3) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          '...',
                          style: TextStyle(
                            color: Mycoloer.mywhite.withValues(alpha: 0.3),
                            fontSize: 10,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: isActive ? 20 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isActive
                          ? Mycoloer.myyellow
                          : Mycoloer.mywhite.withValues(alpha: 0.15),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Text(
            'Page $currentPage of $totalPages',
            key: ValueKey('$currentPage-$totalPages'),
            style: TextStyle(
              color: Mycoloer.mywhite.withValues(alpha: 0.6),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }
}
