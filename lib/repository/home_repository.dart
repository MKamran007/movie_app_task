import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../models/movie_model.dart';
import '../res/app_url.dart';

class HomeRepository{
  BaseApiServices baseApiServices = NetworkApiServices();

  Future<MovieListModel> fetchMoviesList() async{
    try{
      dynamic response = await baseApiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);

    }catch (e){
      throw(e);

    }

  }
}