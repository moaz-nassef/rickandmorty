import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _heroController;
  late final AnimationController _staggerController;
  late final Animation<double> _imageScale;
  late final Animation<double> _contentFade;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _imageScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeOutBack),
    );

    _contentFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _heroController.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          _staggerController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = characterScreenCardStatusColor(widget.character.status);

    return Scaffold(
      backgroundColor: Mycoloer.mygray,
      body: SafeArea(
        child: Skeletonizer(
          enabled: _isLoading,
          effect: ShimmerEffect(
            baseColor: const Color(0xff1e282f),
            highlightColor: const Color(0xff2c3842),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(statusColor),
                _buildBody(statusColor),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color statusColor) {
    final width = MediaQuery.of(context).size.width;
    final imageSize = ((width * 0.45).clamp(120.0, 260.0));
    // Make header height equal to image size so there's virtually no gap
    final headerHeight = imageSize;

    return AnimatedBuilder(
      animation: _heroController,
      builder: (context, child) {
        return Transform.scale(scale: _imageScale.value, child: child);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: headerHeight - (headerHeight * 0.50),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildBackButton(),
                  ),
                ),
                const Spacer(),
                // Portal glow ring (scaled)
                _buildPortalRing(statusColor, imageSize),
                const SizedBox(height: 16),
              ],
            ),
          ),
          // Character image (responsive)
          Positioned(
            left: 0,
            right: 0,
            top: headerHeight / 2 - imageSize / 2,
            child: Hero(
              tag: 'character-image-${widget.character.charid}',
              child: _buildCharacterImage(imageSize),
            ),
          ),
          // Floating status badge
          Positioned(
            top:
                headerHeight / 2 -
                imageSize / 2 +
                math.max(8.0, imageSize * 0.06),
            right: math.max(12.0, width * 0.06),
            child: AnimatedBuilder(
              animation: _staggerController,
              builder: (context, child) {
                return Opacity(
                  opacity: _contentFade.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - _contentFade.value)),
                    child: child,
                  ),
                );
              },
              child: _buildStatusBadge(statusColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xff243037).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
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

  Widget _buildPortalRing(Color statusColor, double imageSize) {
    final ringSize = imageSize * 1.8;
    final borderWidth = math.max(18.0, imageSize * 0.18);

    return Container(
      width: ringSize,
      height: ringSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: statusColor.withValues(alpha: 0.15),
          width: borderWidth,
        ),
      ),
    );
  }

  Widget _buildCharacterImage([double size = 190]) {
    final borderRadius = BorderRadius.circular(size * 0.12);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff9dff35).withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 3,
        ),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          widget.character.image,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) {
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

  Widget _buildStatusBadge(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xff1e282f),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStatusDot(statusColor),
          const SizedBox(width: 8),
          Text(
            widget.character.status.toUpperCase(),
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

  Widget _buildStatusDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.7),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Name
          _buildName(),
          const SizedBox(height: 24),
          // Info cards
          _buildInfoCard(
            icon: Icons.public_rounded,
            label: 'Origin',
            value: widget.character.originName,
            delay: 0.1,
          ),
          const SizedBox(height: 10),
          _buildInfoCard(
            icon: Icons.location_on_rounded,
            label: 'Location',
            value: widget.character.locationName,
            delay: 0.2,
          ),
          const SizedBox(height: 24),
          // Pills row
          _buildPillsRow(statusColor),
          const SizedBox(height: 24),
          // Extra info
          _buildExtraInfo(),
        ],
      ),
    );
  }

  Widget _buildName() {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        return Opacity(
          opacity: _contentFade.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _contentFade.value)),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Text(
            '#${widget.character.charid.toString().padLeft(3, '0')}',
            style: TextStyle(
              color: Mycoloer.myyellow.withValues(alpha: 0.5),
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.character.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Mycoloer.mywhite,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required double delay,
  }) {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: _staggerController,
          curve: Interval(delay, delay + 0.4, curve: Curves.easeOutCubic),
        );
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(24 * (1 - curved.value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff1e282f),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Mycoloer.myyellow, size: 22),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Mycoloer.mywhite.withValues(alpha: 0.4),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Mycoloer.mywhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillsRow(Color statusColor) {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: _staggerController,
          curve: const Interval(0.35, 0.75, curve: Curves.easeOutCubic),
        );
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - curved.value)),
            child: child,
          ),
        );
      },
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: [
          _buildPill(widget.character.status, statusColor),
          _buildPill(widget.character.species, const Color(0xff4a5c6b)),
          _buildPill(widget.character.gender, const Color(0xff4a5c6b)),
          _buildPill(widget.character.type, const Color(0xff3d4d5a)),
        ],
      ),
    );
  }

  Widget _buildPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildExtraInfo() {
    return AnimatedBuilder(
      animation: _staggerController,
      builder: (context, child) {
        final curved = CurvedAnimation(
          parent: _staggerController,
          curve: const Interval(0.5, 0.9, curve: Curves.easeOutCubic),
        );
        return Opacity(
          opacity: curved.value,
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - curved.value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xff1e282f),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Mycoloer.myyellow.withValues(alpha: 0.08)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStat('Episodes', widget.character.episodeCount.toString()),
            Container(
              width: 1,
              height: 40,
              color: Colors.white.withValues(alpha: 0.08),
            ),
            _buildStat('Type', widget.character.type),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Mycoloer.myyellow,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: Mycoloer.mywhite.withValues(alpha: 0.4),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
