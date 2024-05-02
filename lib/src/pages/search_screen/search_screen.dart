import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:pixabay/config/routes/routes.dart';
import 'package:pixabay/config/theme/theme.dart';
import 'package:pixabay/helper/bytes_converter.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/bloc/search_bloc/search_bloc.dart';
import 'package:pixabay/src/data/models/image_model.dart';
import 'package:pixabay/src/pages/search_screen/loading_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  int page = 1;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late final SearchBloc searchBloc;
  late final FavoriteCubit favoriteCubit;

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context)
      ..add(SearchItems(query: "", page: page.toString()));
    favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    scrollController.addListener(() {
      if (scrollController.offset >=
          (scrollController.position.maxScrollExtent)) {
        if ((page + 1) > 26) {
          FlutterToastr.show("Max Page Reached", context);
          return;
        }
        searchBloc.add(SearchItems(
            query: searchController.text, page: (++page).toString()));
      }
    });
    super.initState();
  }

  // @override
  // void reassemble() {
  //   searchBloc.add(
  //       SearchItems(query: searchController.text, page: (++page).toString()));
  //   super.reassemble();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
              leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Hero(
                      tag: "pixabay",
                      child: Image.asset("assets/images/pixabay.png"))),
              title: TextFormField(
                  onTapOutside: (pointer) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  cursorColor: Colors.green.shade700,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: CustomThemeData.fontFamily,
                      color: CustomThemeData.textColor,
                      letterSpacing: 0),
                  onFieldSubmitted: (value) {
                    searchBloc.add(SearchItems(
                        isRefresh: true,
                        query: searchController.text,
                        page: (++page).toString()));
                  },
                  onChanged: (value) => setState(() {}),
                  controller: searchController,
                  decoration: InputDecoration(
                      suffixIcon: searchController.text.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                searchController.clear();
                                searchBloc.add(SearchItems(
                                    isRefresh: true,
                                    query: searchController.text,
                                    page: (++page).toString()));
                              },
                              child: const Icon(Icons.close))
                          : null,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      prefixIcon: SvgPicture.asset("assets/images/vector.svg",
                          height: 20, color: Colors.grey.shade600),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: "Search Images",
                      contentPadding: const EdgeInsets.only(left: 20),
                      enabledBorder: inputBorder,
                      focusedBorder: focusedBorder)))),
      body: BlocBuilder<SearchBloc, SearchState>(
          bloc: searchBloc,
          builder: (context, state) {
            if (state is SearchLoading) return const LoadingShimmer();
            if (state is SearchLoaded) {
              final List<ImageDatum> imageData = state.imageData;
              return imageData.isEmpty
                  ? const Center(child: Text("No data to show."))
                  : GridView.builder(
                      controller: scrollController,
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              crossAxisCount: 2),
                      itemCount: (page + 1) < 26
                          ? imageData.length + 3
                          : imageData.length,
                      itemBuilder: (context, index) {
                        if (index >= imageData.length) {
                          return Shimmer.fromColors(
                              direction: ShimmerDirection.ttb,
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                  height: 20, color: Colors.grey[200]!));
                        }
                        final ImageDatum imageDatum = imageData[index];
                        return BlocBuilder<FavoriteCubit, FavoriteState>(
                            builder: (context, favSate) {
                          return InkWell(
                              onTap: () {
                                if (favSate.favoriteImages
                                    .contains(imageDatum)) {
                                  return;
                                }
                                favoriteCubit.addToFav(imageDatum);
                              },
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                        child: Hero(
                                            tag: imageDatum.id,
                                            child: Container(
                                                alignment: Alignment.topRight,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        filterQuality:
                                                            FilterQuality.high,
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                imageDatum
                                                                    .image)))))),
                                    ListTile(
                                        title: Text(imageDatum.ownerName),
                                        subtitle: Text(
                                            imageDatum.imageSize.formatBytes()),
                                        trailing: favSate.favoriteImages
                                                .contains(imageDatum)
                                            ? Icon(Icons.favorite,
                                                color: Colors.red.shade900)
                                            : null,
                                        contentPadding:
                                            const EdgeInsets.only(right: 10))
                                  ]));
                        });
                      });
            }
            if (state is SearchLoadError) {
              return Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  InkWell(
                      onTap: () {
                        page = 1;
                        searchBloc.add(SearchItems(
                            query: searchController.text,
                            page: (page).toString()));
                      },
                      child: const Icon(Icons.replay_outlined))
                ],
              ));
            }
            return const SizedBox.shrink();
          }),
      floatingActionButton: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          Navigator.pushNamed(context, Routes.favoriteScreen);
        },
        child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.green.shade700,
            child: const Icon(Icons.favorite, color: Colors.white)),
      ),
    );
  }

  OutlineInputBorder get inputBorder => OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(20));

  OutlineInputBorder get focusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.grey),
      borderRadius: BorderRadius.circular(20));
}
