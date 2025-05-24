import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokemonworld/common/app_theme/theme.dart';
import 'package:pokemonworld/common/routes/routes.dart';
import 'package:pokemonworld/common/utils/utils.dart';
import 'package:pokemonworld/controller/data_controller.dart';
import 'package:pokemonworld/network/apis/network_api.dart';
import 'package:pokemonworld/network/constants/endpoints.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller controller = Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListApi();
  }

  getListApi() {
    Endpoints.hasConnectivity().then(
      (value) => {
        if (value)
          {
            NetworkApi()
                .getPokemonData()
                .then(
                  (value) => {
                    if (value.data.isNotEmpty)
                      {
                        controller.pokemonList.clear(),
                        for (int i = 0; i < value.data.length; i++)
                          {
                            controller.pokemonList.add(value.data[i]),
                            if (i == value.data.length)
                              {
                                setState(() {
                                  controller.setLoadingFalse();
                                }),
                              },
                          },
                      }
                    else
                      {
                        setState(() {
                          controller.setLoadingFalse();
                        }),
                      },
                  },
                )
                .whenComplete(() {
                  setState(() {
                    controller.setLoadingFalse();
                  });
                }),
          }
        else
          {
            setState(() {
              controller.setLoadingFalse();
            }),
          },
      },
    );
  }

  getSearchData(String name) {
    Endpoints.hasConnectivity().then(
      (value) => {
        if (value)
          {
            NetworkApi()
                .getSearchData(name)
                .then(
                  (value) => {
                    if (value.data.isNotEmpty)
                      {
                        controller.pokemonList.clear(),
                        for (int i = 0; i < value.data.length; i++)
                          {
                            controller.pokemonList.add(value.data[i]),
                            if (i == value.data.length)
                              {
                                setState(() {
                                  controller.setLoadingFalse();
                                  controller.setSearchingFalse();
                                }),
                              },
                          },
                      }
                    else
                      {
                        setState(() {
                          controller.setLoadingFalse();
                          controller.setSearchingFalse();
                        }),
                      },
                  },
                )
                .whenComplete(() {
                  setState(() {
                    controller.setLoadingFalse();
                    controller.setSearchingFalse();
                  });
                }),
          }
        else
          {
            setState(() {
              controller.setLoadingFalse();
              controller.setSearchingFalse();
            }),
          },
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(controller.returnSearchingValue() ? 'Pokemon Search' : "Pokemon", style: Utils.headline1TextStyle),
        backgroundColor: AppTheme.primaryColorLight1,
        actions: <Widget>[
          controller.returnSearchingValue()
              ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    controller.setSearchingFalse();
                  });
                  getListApi();
                },
              )
              : IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    controller.setSearchingTrue();
                  });
                },
              ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child:
            controller.returnLoadingValue()
                ? Center(
                  child: Container(
                    color: AppTheme.secondaryColorLight,
                    width: 200.0,
                    height: 150.0,
                    alignment: Alignment.center,
                    child: Column(
                      children: [CircularProgressIndicator(color: AppTheme.darkFillColor, padding: EdgeInsets.all(30)), Text("Loading...")],
                    ),
                  ),
                )
                : controller.pokemonList.isEmpty
                ? Center(
                  child: Container(
                    color: AppTheme.secondaryColorLight,
                    width: 200.0,
                    height: 150.0,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.info, size: 28), SizedBox(height: 8), Text("Data Not Found.", style: Utils.title2TextStyle)],
                    ),
                  ),
                )
                : controller.returnSearchingValue()
                ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 4 / 3,
                    children: List.generate(controller.pokemonList.length, (int index) {
                      return InkWell(
                        onTap: () {
                          // getSearchData(controller.pokemonList[index].set.name.toString());
                          getSearchData("generations");
                        },
                        child: Card(
                          color: AppTheme.secondaryContainerColorLight,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 25,
                                  child: Center(
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(child: CircularProgressIndicator(value: progress.progress)),
                                      imageUrl: controller.pokemonList[index].set.images.values.first,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1, child: Text(controller.pokemonList[index].set.name, style: Utils.title2TextStyle)),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                )
                : pokemonDataView(),
      ),
    );
  }

  Widget pokemonDataView() {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(controller.pokemonList.length, (int index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(seconds: 2),
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.details, arguments: {'index': index});
                    },
                    child: Card(
                      elevation: 1,
                      child: Container(
                        color: AppTheme.secondaryContainerColorLight,
                        height: 150,
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: CachedNetworkImage(
                                width: MediaQuery.sizeOf(context).width,
                                height: 125,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(child: CircularProgressIndicator(value: progress.progress)),
                                imageUrl: controller.pokemonList[index].images.values.first,
                              ),
                            ),
                            Expanded(flex: 1, child: Align(alignment: Alignment.center,child: Text(controller.pokemonList[index].name, style: Utils.headline2TextStyle),)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
