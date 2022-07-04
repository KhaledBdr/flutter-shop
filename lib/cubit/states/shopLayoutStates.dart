class ShopLayoutStates {}
class initialState extends ShopLayoutStates{}
// LayOut
class changeBottomNavigationItemState extends ShopLayoutStates{}

// Home Screen
class gettingAllProducts extends ShopLayoutStates{}
class successGettingAllProducts extends ShopLayoutStates{}
class errorGettingAllProducts extends ShopLayoutStates{
  final error;
  errorGettingAllProducts(this.error);
}

class changeIsFavouriteState extends ShopLayoutStates{}

// Category Screen
class gettingAllCategories extends ShopLayoutStates{}
class successGettingAllCategories extends ShopLayoutStates{}
class errorGettingAllCategories extends ShopLayoutStates{
  final error;
  errorGettingAllCategories(this.error);
}

// Favourite screen
class gettingAllFavourite extends ShopLayoutStates{}
class successGettingAllFavourite extends ShopLayoutStates{}
class errorGettingAllFavourite extends ShopLayoutStates{
  final error;
  errorGettingAllFavourite(this.error);
}

class tryingChangeIsFavourite extends ShopLayoutStates{}
class successChangeIsFavourite extends ShopLayoutStates{}
class errorChangeIsFavourite extends ShopLayoutStates{
  final error;
  errorChangeIsFavourite(this.error);
}

// Search Screen
class postingSearch extends ShopLayoutStates{}
class successPostingSearch extends ShopLayoutStates{}
class errorPostingSearch extends ShopLayoutStates{
  final error;
  errorPostingSearch(this.error);
}

// getProduct Screen
class gettingProduct extends ShopLayoutStates{}
class successGettingProduct extends ShopLayoutStates{}
class errorGettingProduct extends ShopLayoutStates{
  final error;
  errorGettingProduct(this.error);
}