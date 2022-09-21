import 'package:coffe_shop/bloc/favorite_event.dart';
import 'package:coffe_shop/bloc/favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(isFavorite: false)) {
    on<FavoriteToggleEvent>(_toggle);
  }

  Future _toggle(FavoriteToggleEvent event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }
}
