import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_sub2_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_sub2_app/provider/preferences_provider.dart';
import 'package:restaurant_sub2_app/provider/scheduling_provider.dart';
import 'package:restaurant_sub2_app/screens/bookmark_page.dart';
import 'package:restaurant_sub2_app/screens/detail_page.dart';
import 'package:restaurant_sub2_app/screens/setting_page.dart';
import 'package:restaurant_sub2_app/utils/notification_helper.dart';
import 'package:restaurant_sub2_app/widgets/restaurant_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/second_screen';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _home = 'Home';
  static const String _bookmarks = 'Home';
  static const String _settings = 'Home';

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantPage(),
    const BookmarkPage(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider <SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance()),
          ),
        ),
      ],
      child: const SettingPage(),
    )
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _home,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmarks),
      label: _bookmarks,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: _settings,
    ),
  ];
  void _onBottomNavTaped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTaped,
        items: _bottomNavBarItems,
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }
}
