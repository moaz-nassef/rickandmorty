import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';

class CharacterDetailsHeader extends StatelessWidget {
  final Character character;
  final Animation<double> imageScale;
  final Animation<double> contentFade;
  final AnimationController staggerController;
  final Color statusColor;

  const CharacterDetailsHeader({
    super.key,
    required this.character,
    required this.imageScale,
    required this.contentFade,
    required this.staggerController,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageSize = ((width * 0.45).clamp(120.0, 260.0));
    final topSpacing = 50.0;
    final bottomSpacing = 10.0;
    final ringSize = imageSize * 0.8;
    final headerHeight = topSpacing + imageSize + bottomSpacing;

    return AnimatedBuilder(
      animation: imageScale,
      builder: (context, child) {
        return Transform.scale(scale: imageScale.value, child: child);
      },
      child: SizedBox(
        width: double.infinity,
        height: headerHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(top: 0, left: 8, child: _buildBackButton(context)),
            Positioned(
              left: (width - ringSize) / 2,
              top: topSpacing + (imageSize - ringSize) / 2,
              child: _buildPortalRing(statusColor, ringSize),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: topSpacing,
              child: Hero(
                tag: 'character-image-${character.charid}',
                child: _buildCharacterImage(imageSize),
              ),
            ),
            Positioned(
              top: topSpacing + imageSize * 0.06,
              right: math.max(12.0, width * 0.06),
              child: AnimatedBuilder(
                animation: staggerController,
                builder: (context, child) {
                  return Opacity(
                    opacity: contentFade.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - contentFade.value)),
                      child: child,
                    ),
                  );
                },
                child: _buildStatusBadge(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xff243037).withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Mycoloer.mywhite,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildPortalRing(Color statusColor, double ringSize) {
    final borderWidth = math.max(18.0, ringSize * 0.18);

    return Container(
      width: ringSize,
      height: ringSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: statusColor.withOpacity(0.15),
          width: borderWidth,
        ),
      ),
    );
  }

  Widget _buildCharacterImage(double size) {
    final borderRadius = BorderRadius.circular(size * 0.12);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff9dff35).withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 3),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          character.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return Container(
              color: const Color(0xff243037),
              child: Icon(
                Icons.person_rounded,
                color: Mycoloer.mywhite,
                size: math.max(48.0, size * 0.4),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xff1e282f),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: statusColor.withOpacity(0.9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.5),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatusDot(),
          const SizedBox(width: 6),
          Text(
            character.status.toUpperCase(),
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: statusColor,
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.7),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
