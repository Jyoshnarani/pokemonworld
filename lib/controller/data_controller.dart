import 'package:get/get.dart';
import 'package:pokemonworld/object/object.dart';

class Controller extends GetxController {
  var isLoading = true.obs;
  var isSearching = false.obs;
  List<PokemonCard> pokemonList = <PokemonCard>[].obs;
  List<String> cost = <String>[].obs;
  List<String> retreatCost = <String>[].obs;

  returnPokemonCardList() {
    return pokemonList;
  }

  returnCostList() {
    return cost;
  }

  returnRetreatCostList() {
    return retreatCost;
  }

  returnLoadingValue() {
    return isLoading.value;
  }

  returnSearchingValue() {
    return isSearching.value;
  }

  setLoadingFalse() {
    isLoading = false.obs;
  }

  setLoadingTrue() {
    isLoading = true.obs;
  }

  setSearchingFalse() {
    isSearching = false.obs;
  }

  setSearchingTrue() {
    isSearching = true.obs;
  }
}
