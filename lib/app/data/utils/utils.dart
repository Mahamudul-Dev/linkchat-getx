// ignore_for_file: constant_identifier_names

const String PLACEHOLDER_IMAGE =
    'https://enamgroup.com/assets/images/defualt.jpeg';
const String placeholderImageFemale =
    'https://www.parkamerica.net/wp-content/uploads/2020/12/placeholder-profile-female.jpg';

// apis
const String BASE_URL = 'http://31.172.83.135:1212';
const String REGISTER = '/api/v1/user/register'; // for register new user
const String LOGIN = '/api/v1/user/login'; // for login a user
const String USER = '/api/v1/user/'; // need to put user id in parameter
const String FOLLOWERS =
    '/api/v1/user/followers/'; // need to put user id in parameter
const String SEARCH =
    '/api/v1/user/search'; // need to put uid & query text as body object
const String UPDATE_PROFILE =
    '/api/v1/user/update/'; // need to put user id in parameter for update profile

const String MULTIPLE_USER = '/api/v1/user/multiple_profile';

const String MAKE_FOLLOW =
    '/api/v1/user/create_follow/'; // need to put id in parameter for make a follower
const String MAKE_LINK = '/api/v1/user/add_link/';
const String UNLINK = '/api/v1/user/unlink/';
const String GET_MATCH =
    '/api/v1/match'; // need to put id in body for finding match profiles
const String GET_PUBLIC_ROOM = '/api/v1/publicGroups';
const String GET_MULTIPLE_ROOM = '/api/v1/getMultipleGroup';
const String JOIN_ROOM = '/api/v1/joinGroup';
const String CREATE_ROOM = '/api/v1/createGroup';

Map<String, String> authorization(String token) {
  return {'Authorization': 'Bearer $token'};
}

const String SOCKET_CONNECTION_URL = 'http://31.172.83.135:3434';
