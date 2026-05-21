import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';

class CharacterScreenPaginationBar extends StatelessWidget {
  const CharacterScreenPaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        if (state is! CharactersLoaded) return const SizedBox.shrink();

        final hasPrev = state.currentPage > 1;
        final hasNext = state.currentPage < state.totalPages;

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 12 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff1e282f),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  icon: Icons.chevron_left_rounded,
                  enabled: hasPrev,
                  onTap: hasPrev
                      ? () => context
                          .read<CharacterCubit>()
                          .goToPage(state.currentPage - 1)
                      : null,
                ),
                _buildPageIndicator(state.currentPage, state.totalPages),
                _buildButton(
                  icon: Icons.chevron_right_rounded,
                  enabled: hasNext,
                  onTap: hasNext
                      ? () => context
                          .read<CharacterCubit>()
                          .goToPage(state.currentPage + 1)
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: enabled
                ? Mycoloer.myyellow.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: enabled
                  ? Mycoloer.myyellow.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Icon(
            icon,
            color: enabled ? Mycoloer.myyellow : Colors.white.withValues(alpha: 0.25),
            size: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int current, int total) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: current, end: current),
      duration: const Duration(milliseconds: 250),
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              children: [
                TextSpan(
                  text: '$current',
                  style: const TextStyle(color: Mycoloer.myyellow),
                ),
                TextSpan(
                  text: ' / $total',
                  style: TextStyle(
                    color: Mycoloer.mywhite.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
