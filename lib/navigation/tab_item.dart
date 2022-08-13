import 'package:flutter/material.dart';

enum TabItem { home, discover, listing, cart, settings }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.discover: 'Entdecken',
  TabItem.listing: 'Listing',
  TabItem.cart: 'Cart',
  TabItem.settings: 'Settings',
};

const Map<TabItem, String> routePaths = {
  TabItem.home: 'home',
  TabItem.discover: 'discover',
  TabItem.listing: 'listing',
  TabItem.cart: 'cart',
  TabItem.settings: 'settings',
};

const Map<TabItem, IconData> routeIcons = {
  TabItem.home: Icons.shop,
  TabItem.discover: Icons.fireplace_rounded,
  TabItem.listing: Icons.layers,
  TabItem.cart: Icons.shopping_cart,
  TabItem.settings: Icons.settings,
};
