import 'package:go_router/go_router.dart';
import 'package:web_extension/core/local_storage/session_manager.dart';
import 'package:web_extension/core/navigation/navigation_path.dart';
import 'package:web_extension/pages/home_page.dart';

GoRouter buildAppRouter(SessionManager sessionManager) {
  return GoRouter(
    initialLocation: NavigationPaths.home.path,
    routes: [
      GoRoute(
        path: NavigationPaths.home.path,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}
