import 'package:go_router/go_router.dart';
import 'package:nft_market_app_ui/presentation/screens/bookmark_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/collection_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/detail_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/home_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/main_shell_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/onboarding_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/profile_screen.dart';
import 'package:nft_market_app_ui/presentation/screens/search_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(
      path: NamedRoutes.onboarding.routeName,
      builder: (ctx, state) => const OnboardingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) => MainShellScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.home.routeName,
              builder: (ctx, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.search.routeName,
              builder: (ctx, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.bookmark.routeName,
              builder: (ctx, state) => const BookmarkScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.profile.routeName,
              builder: (ctx, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: NamedRoutes.detail.routeName,
      builder: (ctx, state) => const DetailScreen(),
    ),
    GoRoute(
      path: NamedRoutes.collection.routeName,
      builder: (ctx, state) => const CollectionScreen(),
    ),
  ],
);

enum NamedRoutes {
  onboarding('/onboarding'),
  home('/home'),
  search('/search'),
  bookmark('/bookmark'),
  profile('/profile'),
  detail('/detail'),
  collection('/collection');

  final String routeName;

  const NamedRoutes(this.routeName);
}
