import 'package:flutter/material.dart';

enum TabItem { home, discover, wishlist, cart, settings }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.discover: 'Entdecken',
  TabItem.wishlist: 'wishlist',
  TabItem.cart: 'Cart',
  TabItem.settings: 'Settings',
};

const Map<TabItem, String> routePaths = {
  TabItem.home: 'home',
  TabItem.discover: 'discover',
  TabItem.wishlist: 'wishlist',
  TabItem.cart: 'cart',
  TabItem.settings: 'settings',
};

const Map<TabItem, IconData> routeIcons = {
  TabItem.home: Icons.shop,
  TabItem.discover: Icons.fireplace_rounded,
  TabItem.wishlist: Icons.heart_broken,
  TabItem.cart: Icons.shopping_cart,
  TabItem.settings: Icons.settings,
};
