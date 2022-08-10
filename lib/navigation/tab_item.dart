import 'package:flutter/material.dart';

enum TabItem { home, listing, settings, cart }

const Map<TabItem, String> tabName = {
  TabItem.home: 'Home',
  TabItem.listing: 'Listing',
  TabItem.settings: 'Settings',
  TabItem.cart: 'Cart',
};

const Map<TabItem, String> routePaths = {
  TabItem.home: 'home',
  TabItem.listing: 'listing',
  TabItem.settings: 'settings',
  TabItem.cart: 'cart',
};

const Map<TabItem, IconData> routeIcons = {
  TabItem.home: Icons.shop,
  TabItem.listing: Icons.layers,
  TabItem.settings: Icons.settings,
  TabItem.cart: Icons.shopping_cart,
};
