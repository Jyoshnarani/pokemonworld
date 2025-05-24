import 'package:pokemonworld/network/constants/endpoints.dart';
import 'package:pokemonworld/object/object.dart';

class NetworkApi {
  Future<PokemonApiResponse> getPokemonData() async {
    try {
      late PokemonApiResponse response = PokemonApiResponse.fromJson(Endpoints.defaultResponse());
      await Endpoints()
          .doCertificateVerification()
          .get(Endpoints.listURL)
          .then(
            (value) => {
              if (value.statusCode == 200)
                {
                  if (value.data.isNotEmpty)
                    {response = PokemonApiResponse.fromJson(value.data)}
                  else
                    {response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0)},
                }
              else
                {response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0)},
            },
          )
          .catchError(( error) {
            response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0);
            return {
              {response},
            };
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<PokemonApiResponse> getSearchData(String name) async {
    try {
      late PokemonApiResponse response = PokemonApiResponse.fromJson(Endpoints.defaultResponse());
      await Endpoints()
          .doCertificateVerification()
          .get("${Endpoints.searchURL}$name")
          .then(
            (value) => {
              if (value.statusCode == 200)
                {
                  if (value.data.isNotEmpty)
                    {response = PokemonApiResponse.fromJson(value.data)}
                  else
                    {response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0)},
                }
              else
                {response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0)},            },
          )
          .catchError((error) {
            response = PokemonApiResponse(data: [], page: 0, pageSize: 0, count: 0, totalCount: 0);
            return {
              {response},
            };
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
