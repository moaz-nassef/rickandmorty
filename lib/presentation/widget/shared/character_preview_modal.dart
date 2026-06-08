import 'dart:async';
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:rickandmorty/presentation/widget/shared/shimmer_placeholder.dart';

void showCharacterPreview(BuildContext context, Character character) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: '',
    transitionDuration: Duration.zero,
    useRootNavigator: true,
    pageBuilder: (ctx, anim1, anim2) =>
        _CharacterPreviewModal(character: character),
  );
}

class _CharacterPreviewModal extends StatefulWidget {
  final Character character;
  const _CharacterPreviewModal({required this.character});

  @override
  State<_CharacterPreviewModal> createState() => _CharacterPreviewModalState();
}

class _CharacterPreviewModalState extends State<_CharacterPreviewModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _contentFade;
  final AudioPlayer _player = AudioPlayer();
  Color? _statusColor;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _statusColor = characterScreenCardStatusColor(widget.character.status);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _contentFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    HapticFeedback.lightImpact();
    unawaited(_playSound());
    _controller.forward();
  }

  Future<void> _playSound() async {
    try {
      await _player.stop();
      await _player.setSource(AssetSource('sounds/click.wav'));
      await _player.resume();
    } catch (_) {}
  }

  void _dismiss() {
    if (_dismissing) return;
    _dismissing = true;
    HapticFeedback.lightImpact();
    unawaited(_playSound());
    _controller.reverse().then((_) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final cardWidth = screenWidth * 0.82;
    final imageSize = 200.0;
    final imageHalf = imageSize * 0.5;

    return Listener(
      onPointerUp: (_) => _dismiss(),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (ctx, _) {
                final val = Curves.easeOut.transform(_controller.value);
                return Opacity(
                  opacity: val,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10 * val,
                      sigmaY: 10 * val,
                    ),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.65),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (ctx, _) {
                final val = _controller.value;
                final cardVal = Curves.easeOutCubic.transform(val);
                final imageVal = Curves.easeOutBack.transform(val);
                final scaleVal = Curves.easeOutBack.transform(val);

                return Transform.translate(
                  offset: Offset(0, 250 * (1 - cardVal)),
                  child: Transform.scale(
                    scale: 0.85 + 0.15 * scaleVal,
                    child: SizedBox(
                      width: cardWidth,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff1e282f),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(28),
                              ),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x66000000),
                                  blurRadius: 40,
                                  offset: Offset(0, 20),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(28),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: imageHalf + 16,
                                  bottom: 20,
                                ),
                                child: _CharacterPreviewContent(
                                  character: widget.character,
                                  statusColor: _statusColor!,
                                  contentFade: _contentFade,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -imageHalf - (1 - imageVal) * 300,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: _buildCharacterImage(imageSize),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterImage(double size) {
    final borderRadius = BorderRadius.circular(size * 0.15);
    final statusColor = _statusColor ?? Colors.green;

    return Hero(
      tag: 'character-image-${widget.character.charid}',
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: statusColor.withValues(alpha: 0.4),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: CachedNetworkImage(
            imageUrl: widget.character.image,
            fit: BoxFit.fill,
            placeholder: (_, _) => const ShimmerPlaceholder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            errorWidget: (_, _, _) => Container(
              color: const Color(0xff243037),
              child: Icon(
                Icons.person_rounded,
                color: Mycoloer.mywhite,
                size: size * 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterPreviewContent extends StatelessWidget {
  final Character character;
  final Color statusColor;
  final Animation<double> contentFade;

  const _CharacterPreviewContent({
    required this.character,
    required this.statusColor,
    required this.contentFade,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: contentFade,
      builder: (ctx, child) {
        return Opacity(
          opacity: contentFade.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - contentFade.value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              character.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  character.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${character.species} • ${character.gender}',
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 10),
            Container(height: 0.5, color: Colors.white12),
            const SizedBox(height: 10),
            _InfoRow(
              icon: Icons.public_rounded,
              label: 'Origin',
              value: character.originName,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.location_on_rounded,
              label: 'Location',
              value: character.locationName,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color.fromARGB(188, 0, 255, 72)),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: const TextStyle(color: Color.fromARGB(155, 50, 254, 14), fontSize: 11),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
