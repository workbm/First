class Api {
  static const url = 'https://driverscity.client-excelenciatech.shop/api/';
  static const urlWithoutApi =
      'https://driverscity.client-excelenciatech.shop/';
  static const acceuil = 'accueil';
  static const pagination = 'accueil/allCars?page=';
  static const carsByBrand = 'getCarsByBrand/';
  static const carsByType = 'getCarsByVehicleType/';
  static const search = 'search';
  static const getDataForFilter = 'getDataForFilter';
  static const statistique = 'statistique/';
  static const agency = 'agency/';
  static const uploadImage = 'editProfile';
  static const editProfile = 'editProfile';
  static const login = 'login';
  static const signUP = 'register';
  static const headers = {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };
  static const emailVerification = 'emailVerification';
  static const updatePassword = 'updatePassword';
}
