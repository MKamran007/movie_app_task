import 'package:get/get.dart';
import 'package:movie_app_task/data/response/status.dart';
import 'package:movie_app_task/models/movie_model.dart';
import 'package:movie_app_task/repository/home_repository.dart';

class HomeViewModel extends GetxController {
  final _myRepo = HomeRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final movieList = MovieListModel().obs;
  RxList favoriteMovieList = [].obs;
  final RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setMovieList(MovieListModel _value) => movieList.value = _value;
  void setError(String _value) => error.value = _value;

  void fetchMoviesListApi() {

    _myRepo.fetchMoviesList().then((value){

      setRxRequestStatus(Status.COMPLETE);
      setMovieList(value);

    }).onError((error, stackTrace){
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);

    });

  }

  addToFavourite(dynamic value){
    favoriteMovieList.add(value);
  }

  removeFromFavourite(dynamic value){
    favoriteMovieList.remove(value);
  }
}