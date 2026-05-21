import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/data/model/characterModel.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/presentation/widget/character_details/character_details_content.dart';
import 'package:rickandmorty/presentation/widget/character_screen/card/character_screen_card_status_color.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final int charId;

  const CharacterDetailsScreen({super.key, required this.charId});

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

  Character? _findCharacter(BuildContext context) {
    return context.read<CharacterCubit>().findCharacterById(widget.charId);
  }

  @override
  Widget build(BuildContext context) {
    final character = _findCharacter(context);

    if (character == null) {
      return _buildError('Character not found');
    }

    final statusColor = characterScreenCardStatusColor(character.status);

    return Scaffold(
      backgroundColor: const Color(0xff343A40),
      body: SafeArea(
        child: Skeletonizer(
          enabled: _isLoading,
          effect: ShimmerEffect(
            baseColor: const Color(0xff1e282f),
            highlightColor: const Color(0xff2c3842),
          ),
          child: CharacterDetailsContent(
            character: character,
            imageScale: _imageScale,
            contentFade: _contentFade,
            staggerController: _staggerController,
            statusColor: statusColor,
          ),
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Scaffold(
      backgroundColor: const Color(0xff343A40),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded,
                  color: Color(0xffffc107), size: 56),
              const SizedBox(height: 16),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xffE5E8EB))),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xffffc107),
                  foregroundColor: Color(0xff132318),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
