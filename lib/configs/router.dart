import 'package:alofo/classes/pages_uris.dart';
import 'package:alofo/layouts/account.dart';
import 'package:alofo/layouts/front_office.dart';
import 'package:alofo/pages/addresses_page.dart';
import 'package:alofo/pages/home_page.dart';
import 'package:alofo/pages/product_page.dart';
import 'package:alofo/pages/products_page.dart';
import 'package:alofo/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

var router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => FrontOffice(child: child),
      routes: [
        GoRoute(
          path: PagesUris.homePage,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: PagesUris.productPage,
          builder: (context, state) => ProductPage(),
        ),
        GoRoute(
          path: PagesUris.productsPage,
          builder: (context, state) => ProductsPage(),
        ),
        ShellRoute(
          // nested layout under FrontOffice
          builder: (context, state, child) => Account(child: child),
          routes: [
            GoRoute(
              path: PagesUris.settingsPage,
              builder: (context, state) => SettingsPage(),
            ),
            GoRoute(
              path: PagesUris.addressesPage,
              builder: (context, state) => AddressesPage(),
            ),
            // Add more account-related routes here
          ],
        ),
      ],
    ),
  ],
);
