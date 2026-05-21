import 'package:flutter/material.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_characters_sliver.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_view_toggle_button.dart';
import 'package:rickandmorty/presentation/widget/character_screen/header/character_screen_header.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final TextEditingController searchController = TextEditingController();
  CharacterScreenLayoutMode layoutMode = CharacterScreenLayoutMode.list;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycoloer.mygray,
      floatingActionButton: CharacterScreenViewToggleButton(
        layoutMode: layoutMode,
        onLayoutModeChanged: (mode) => setState(() => layoutMode = mode),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: CharacterScreenHeader(searchController: searchController),
            ),
            CharacterScreenCharactersSliver(layoutMode: layoutMode),
          ],
        ),
      ),
    );
  }
}
