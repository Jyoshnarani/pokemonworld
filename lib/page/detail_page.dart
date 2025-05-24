import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemonworld/common/app_theme/theme.dart';
import 'package:pokemonworld/common/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pokemonworld/controller/data_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Controller controller = Get.put(Controller());
  final index = Get.arguments['index'];
  List<Widget> attackView = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(controller.pokemonList[index].name, style: Utils.headline1TextStyle),
        backgroundColor: AppTheme.primaryColorLight1,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    width: MediaQuery.sizeOf(context).width,
                    progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator(value: progress.progress)),
                    imageUrl: controller.pokemonList[index].images.values.last,
                  ),
                ),
                SizedBox(height: 20),
                basicDetails(),
                SizedBox(height: 10),
                Text("Attacks:", style: Utils.title1TextStyle),
                Column(children: attacksDetails()),
                SizedBox(height: 10),
                otherData(),
                SizedBox(height: 10),
                Text("Prices (TCGPlayer):", style: Utils.title1TextStyle),
                tcgPlayerDetails(),
                SizedBox(height: 10),
                Text("Prices (CardMarket):", style: Utils.title1TextStyle),
                cardMarketDetails(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget basicDetails() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.pokemonList[index].name, style: Utils.title1TextStyle),
          Text("HP: ${controller.pokemonList[index].hp}", style: Utils.title2TextStyle),
          Text("Supertype: ${controller.pokemonList[index].supertype}", style: Utils.title2TextStyle),
          Text("Supertypes: ${controller.pokemonList[index].subtypes.first}", style: Utils.title2TextStyle),
          SizedBox(height: 20),
          Text("Set: ${controller.pokemonList[index].set.name} (${controller.pokemonList[index].set.releaseDate})", style: Utils.title1TextStyle),
          SizedBox(
            width: 30,
            height: 40,
            child: Center(
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(child: CircularProgressIndicator(value: progress.progress)),
                imageUrl: controller.pokemonList[index].set.images.values.first,
              ),
            ),
          ),
          Text("Series: ${controller.pokemonList[index].set.series}", style: Utils.title2TextStyle),
        ],
      ),
    );
  }

  List<Widget> attacksDetails() {
    attackView.clear();
    if (controller.pokemonList[index].attacks.isNotEmpty) {
      for (int i = 0; i < controller.pokemonList[index].attacks.length; i++) {
        controller.cost = controller.pokemonList[index].attacks[i].cost;
        attackView.add(
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.pokemonList[index].attacks[i].name, style: Utils.title1TextStyle),
                Text("Cost: ${controller.cost.join(", ")}", style: Utils.title2TextStyle),
                Text("Damage: ${controller.pokemonList[index].attacks[i].damage}", style: Utils.title2TextStyle),
                Text("Effect: ${controller.pokemonList[index].attacks[i].text}", style: Utils.title2TextStyle),
              ],
            ),
          ),
        );
      }
    }
    return attackView;
  }

  Widget otherData() {
    if (controller.pokemonList[index].retreatCost != null) {
      controller.retreatCost = controller.pokemonList[index].retreatCost!;
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weakness: ${controller.pokemonList[index].weaknesses.first.type} (${controller.pokemonList[index].weaknesses.first.value})",
            style: Utils.title2TextStyle,
          ),
          controller.pokemonList[index].resistances != null
              ? Text(
                "Resistances: ${controller.pokemonList[index].resistances?.first.type} (${controller.pokemonList[index].resistances?.first.value})",
                style: Utils.title2TextStyle,
              )
              : SizedBox(),
          controller.pokemonList[index].retreatCost != null
              ? Text("Retreat Cost: ${controller.retreatCost.join(", ")}", style: Utils.title2TextStyle)
              : SizedBox(),
          SizedBox(height: 20),
          Text("Artist: ${controller.pokemonList[index].artist}", style: Utils.title2TextStyle),
          controller.pokemonList[index].rarity != null
              ? Text("Rerity: ${controller.pokemonList[index].rarity}", style: Utils.title2TextStyle)
              : SizedBox(),
          controller.pokemonList[index].flavorText != null
              ? Text("Flavor Text: ${controller.pokemonList[index].flavorText}", style: Utils.title2TextStyle)
              : SizedBox(),
        ],
      ),
    );
  }

  Widget tcgPlayerDetails() {
    Map<String, dynamic> prices = {};
    double low = 0.0;
    double mid = 0.0;
    double high = 0.0;
    if (controller.pokemonList[index].tcgplayer != null) {
      prices = controller.pokemonList[index].tcgplayer!.prices[controller.pokemonList[index].tcgplayer!.prices.keys.first];
      prices.forEach((key, value) {
        if (key == "low") {
          low = value;
        } else if (key == "mid") {
          mid = value;
        } else if (key == "high") {
          high = value;
        }
      });
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Low: $low", style: Utils.title2TextStyle),
          Text("Mid: $mid", style: Utils.title2TextStyle),
          Text("High: $high", style: Utils.title2TextStyle),
        ],
      ),
    );
  }

  Widget cardMarketDetails() {
    Map<String, dynamic> prices = {};
    double averageSell = 0.0;
    double trendPrice = 0.0;
    if (controller.pokemonList[index].cardmarket != null) {
      prices = controller.pokemonList[index].cardmarket!.prices;
      prices.forEach((key, value) {
        if (key == "averageSellPrice") {
          averageSell = value;
        } else if (key == "trendPrice") {
          trendPrice = value;
        }
      });
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("Average Sell: $averageSell", style: Utils.title2TextStyle), Text("Trend Price: $trendPrice", style: Utils.title2TextStyle)],
      ),
    );
  }
}
