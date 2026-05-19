import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/character_screen_characters_sliver.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/header/character_screen_header.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycoloer.mygray,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: CharacterScreenHeader(searchController: searchController),
            ),
            const CharacterScreenCharactersSliver(),
          ],
        ),
      ),
    );
  }
}
