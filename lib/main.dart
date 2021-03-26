import 'package:flutter/material.dart';
import 'package:myshop/helpers/custom_route.dart';
import './screens/splash_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/user_producta_screen.dart';
import './screens/add_edit_product_screen.dart';
import 'providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //provides a listner to the products
    // using .value can help to reduce the code
    //changenotifierdata helps you to cleanup your data after using thr page
    //which helps in reducing the usage of memory
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (ctx, auth, previousOrder) => Orders(auth.token,
              previousOrder == null ? [] : previousOrder.orders, auth.userId),
        ),
      ],
      //to provide screen while login and after login use
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Raleway',
              //to apply transition to all the pages across the app
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder()
                },
              )),
          home: auth.isAuth
              ? ProductOverviewScreen()
              // for autologin
              : FutureBuilder(
                  future: auth.tryAutoLogIn(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            AddEditProductScreen.routeName: (ctx) => AddEditProductScreen(),
          },
        ),
      ),
    );
  }
}
