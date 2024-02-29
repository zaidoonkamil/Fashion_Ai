import '../../features/auth/login/login.dart';
import '../local_save_storege/cache_helper.dart';
import 'navigation.dart';

String? token = '';
String? id = '';
String? role = '';
String ip='192.168.0.114' ;

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigateAndFinish(
        context,
        const LoginScreen(),
      );
    }
  });
}