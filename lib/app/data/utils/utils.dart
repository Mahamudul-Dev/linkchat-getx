// ignore_for_file: constant_identifier_names

const String PLACEHOLDER_IMAGE =
    'https://enamgroup.com/assets/images/defualt.jpeg';
const String placeholderImageFemale =
    'https://www.parkamerica.net/wp-content/uploads/2020/12/placeholder-profile-female.jpg';

// apis
const String BASE_URL = 'https://chat.linkfy.org';
const String REGISTER = '/api/v1/user/register'; // for register new user
const String LOGIN = '/api/v1/user/login'; // for login a user
const String USER = '/api/v1/user/'; // need to put user id in parameter
const String FOLLOWERS =
    '/api/v1/user/followers/'; // need to put user id in parameter
const String SEARCH =
    '/api/v1/user/search'; // need to put uid & query text as body object
const String UPDATE_PROFILE =
    '/api/v1/user/update/'; // need to put user id in parameter for update profile

const String MAKE_FOLLOW =
    '/api/v1/user/create_follow/'; // need to put id in parameter for make a follower
const String LINK_FOLLOWER = '';
const String UNLINK = '';

Map<String, String> authorization(String token) {
  return {'Authorization': 'Bearer $token'};
}
