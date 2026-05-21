import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/consstant/string.dart';

class CharacterScreenFailureView extends StatelessWidget {
  final String message;

  const CharacterScreenFailureView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            color: Mycoloer.myyellow,
            size: 54,
          ),
          const SizedBox(height: 18),
          const Text(
            'Portal disconnected',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Mycoloer.mywhite,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Mycoloer.mywhite.withValues(alpha: .62),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Mycoloer.myyellow,
              foregroundColor: const Color(0xff132318),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: context.read<CharacterCubit>().getAllCharacters,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
