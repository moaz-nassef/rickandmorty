import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/widget/character_details/character_details_content.dart';
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
          child: CharacterDetailsContent(
            character: widget.character,
            imageScale: _imageScale,
            contentFade: _contentFade,
            staggerController: _staggerController,
            statusColor: statusColor,
          ),
        ),
      ),
    );
  }
}
