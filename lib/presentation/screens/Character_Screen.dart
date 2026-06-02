import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rickandmorty/consstant/string.dart';
import 'package:rickandmorty/presentation/bloc/character/character_cubit.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_characters_sliver.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_layout_mode.dart';
import 'package:rickandmorty/presentation/widget/character_screen/character_screen_view_toggle_button.dart';
import 'package:rickandmorty/presentation/widget/character_screen/header/character_screen_header.dart';
import 'package:rickandmorty/presentation/widget/shared/pagination_bar.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final TextEditingController searchController = TextEditingController();
  CharacterScreenLayoutMode layoutMode = CharacterScreenLayoutMode.list;
  final Set<int> _precachedImagePages = {};

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _precachePageImages(BuildContext context, int page,
      {int limit = 6}) {
    if (_precachedImagePages.contains(page)) return;
    _precachedImagePages.add(page);

    final cubit = context.read<CharacterCubit>();
    final chars = cubit.pageCharacters(page);
    if (chars == null) return;

    final count = chars.length < limit ? chars.length : limit;
    for (int i = 0; i < count; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (context.mounted) {
          precacheImage(CachedNetworkImageProvider(chars[i].image), context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycoloer.mygray,
      floatingActionButton: CharacterScreenViewToggleButton(
        layoutMode: layoutMode,
        onLayoutModeChanged: (mode) => setState(() => layoutMode = mode),
      ),
      body: BlocListener<CharacterCubit, CharacterState>(
        listenWhen: (prev, current) =>
            current is CharactersLoaded &&
            current.errorMessage != null &&
            (prev is! CharactersLoaded ||
                prev.errorMessage != current.errorMessage),
        listener: (context, state) {
          if (state is CharactersLoaded && state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: const Color(0xffc0392b),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Mycoloer.myyellow,
                  onPressed: () =>
                      context.read<CharacterCubit>().loadPage(state.currentPage),
                ),
              ),
            );
          }
        },
        child: Stack(
          children: [
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollCacheExtent: ScrollCacheExtent.pixels(
                    MediaQuery.sizeOf(context).height),
                slivers: [
                  SliverToBoxAdapter(
                    child: CharacterScreenHeader(
                        searchController: searchController),
                  ),
                  CharacterScreenCharactersSliver(layoutMode: layoutMode),
                  SliverToBoxAdapter(
                    child: BlocBuilder<CharacterCubit, CharacterState>(
                      buildWhen: (prev, current) =>
                          current is CharactersLoaded &&
                          current.isLoadingPage !=
                              (prev is CharactersLoaded
                                  ? prev.isLoadingPage
                                  : false),
                      builder: (context, state) {
                        final isLoading = state is CharactersLoaded
                            ? state.isLoadingPage
                            : false;
                        if (isLoading) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Mycoloer.myyellow,
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox(height: 24);
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocBuilder<CharacterCubit, CharacterState>(
                      buildWhen: (prev, current) =>
                          current is CharactersLoaded,
                      builder: (context, state) {
                        if (state is! CharactersLoaded) {
                          return const SizedBox.shrink();
                        }
                        return PaginationBar(
                          currentPage: state.currentPage,
                          totalPages: state.totalPages,
                          onPrevious: state.currentPage > 1
                              ? () => context
                                  .read<CharacterCubit>()
                                  .previousPage()
                              : null,
                          onNext: state.currentPage < state.totalPages
                              ? () =>
                                  context.read<CharacterCubit>().nextPage()
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            BlocListener<CharacterCubit, CharacterState>(
              listenWhen: (_, current) =>
                  current is CharactersLoaded && !current.isLoadingPage,
              listener: (context, state) {
                if (state is CharactersLoaded) {
                  _precachePageImages(context, state.currentPage + 1, limit: 6);
                }
              },
              child: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
