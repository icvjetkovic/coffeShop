// ignore_for_file: public_member_api_docs, sort_constructors_first
class FavoriteState {
  bool isFavorite;
  FavoriteState({
    required this.isFavorite,
  });

  FavoriteState copyWith({
    bool? isFavorite,
  }) {
    return FavoriteState(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
