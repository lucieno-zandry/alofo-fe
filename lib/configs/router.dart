import 'package:alofo/layouts/front_office.dart';
import 'package:alofo/pages/home_page.dart';
import 'package:alofo/pages/product_page.dart';
import 'package:alofo/pages/products_page.dart';
import 'package:go_router/go_router.dart';

var router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => FrontOffice(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(
          path: '/product/:id',
          builder: (context, state) => ProductPage(),
        ),
        GoRoute(path: '/products', builder: (context, state) => ProductsPage()),
      ],
    ),
  ],
);
