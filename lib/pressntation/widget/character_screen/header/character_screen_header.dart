import 'package:flutter/material.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/header/character_screen_header_branding_row.dart';
import 'package:rickandmorty/pressntation/widget/character_screen/header/character_screen_header_search_field.dart';

class CharacterScreenHeader extends StatelessWidget {
  final TextEditingController searchController;

  const CharacterScreenHeader({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CharacterScreenHeaderBrandingRow(),
          const SizedBox(height: 22),
          CharacterScreenHeaderSearchField(searchController: searchController),
        ],
      ),
    );
  }
}
