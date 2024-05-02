import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixabay/helper/bytes_converter.dart';
import 'package:pixabay/src/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:pixabay/src/data/models/image_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteCubit favoriteCubit;
  @override
  void initState() {
    favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
              leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: Hero(
                          tag: "floatingActionButton",
                          child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.green.shade700,
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 20,
                              ))))),
              title: const Text("Favorite Images")),
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
          final List<ImageDatum> imageData = state.favoriteImages;
          return imageData.isEmpty
              ? const Center(child: Text("No data to show."))
              : GridView.builder(
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      crossAxisCount: 2),
                  itemCount: imageData.length,
                  itemBuilder: (context, index) {
                    final ImageDatum imageDatum = imageData[index];
                    return BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, favSate) {
                      return InkWell(
                          onTap: () async {
                            bool confirm = await _showAlertDialog(context);
                            if (confirm) {
                              favoriteCubit.removeFromFav(imageDatum);
                            }
                          },
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
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
                                                        imageDatum.image)))))),
                            ListTile(
                                title: Text(imageDatum.ownerName),
                                subtitle:
                                    Text(imageDatum.imageSize.formatBytes()),
                                trailing: Icon(Icons.favorite,
                                    color: Colors.red.shade900),
                                contentPadding:
                                    const EdgeInsets.only(right: 10))
                          ]));
                    });
                  });
        }));
  }

  Future<bool> _showAlertDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.of(context).pop());
    Widget continueButton = TextButton(
        child: const Text("Continue"),
        onPressed: () => Navigator.of(context).pop(true));
    AlertDialog alert = AlertDialog(
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2))),
        title: const Text(
            "Do you really want to remove from your favorite items?"),
        content: const Text("This action is necessary."),
        actions: [cancelButton, continueButton]);
    final result = await showDialog<bool>(
        context: context, builder: (BuildContext context) => alert);
    return result ?? false;
  }
}
