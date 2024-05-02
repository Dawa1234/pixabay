import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixabay/config/theme/theme.dart';
import 'package:pixabay/src/bloc/search_bloc/search_bloc.dart';
import 'package:pixabay/src/data/models/image_model.dart';
import 'package:pixabay/src/pages/search_screen/loading_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int page = 1;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late final SearchBloc searchBloc;

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context)
      ..add(SearchItems(query: "", page: page.toString()));
    scrollController.addListener(() {
      if (scrollController.offset >=
          (scrollController.position.maxScrollExtent - 70)) {
        searchBloc.add(SearchItems(
            query: searchController.text, page: (++page).toString()));
      }
    });
    super.initState();
  }

  @override
  void reassemble() {
    searchBloc.add(
        SearchItems(query: searchController.text, page: (++page).toString()));
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
                leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset("assets/images/pixabay.png")),
                title: TextFormField(
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
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 40),
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
                        itemCount: imageData.length + 3,
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
                          return InkWell(
                              onTap: () {},
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.topRight,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    filterQuality:
                                                        FilterQuality.high,
                                                    image:
                                                        CachedNetworkImageProvider(
                                                            imageDatum
                                                                .image))))),
                                    ListTile(
                                        title: Text(imageDatum.ownerName),
                                        subtitle: Text(
                                            _formatBytes(imageDatum.imageSize)),
                                        trailing: Icon(Icons.favorite,
                                            color: Colors.red.shade900),
                                        contentPadding:
                                            const EdgeInsets.only(right: 10))
                                  ]));
                        });
              }
              if (state is SearchLoadError) {
                return Center(child: Text(state.errorMessage));
              }
              return const SizedBox.shrink();
            }));
  }

  String _formatBytes(int bytes) {
    const int KB = 1024;
    const int MB = 1024 * 1024;

    if (bytes >= MB) {
      return '${(bytes / MB).toStringAsFixed(2)} MB';
    } else if (bytes >= KB) {
      return '${(bytes / KB).toStringAsFixed(2)} KB';
    } else {
      return "$bytes bytes";
    }
  }

  OutlineInputBorder get inputBorder => OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(20));

  OutlineInputBorder get focusedBorder => OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.grey),
      borderRadius: BorderRadius.circular(20));
}
