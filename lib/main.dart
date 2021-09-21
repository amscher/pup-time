import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_user_provider.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:pup_time/login_page/login_page_widget.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'home_page/home_page_widget.dart';
import 'saved_items/saved_items_widget.dart';
import 'task_list_page/task_list_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<PupTimeFirebaseUser> userStream;
  PupTimeFirebaseUser initialUser;

  @override
  void initState() {
    super.initState();
    userStream = pupTimeFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PupTime',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null
          ? const Center(
              child: LinearProgressIndicator(
                color: FlutterFlowTheme.primaryColor,
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : LoginPageWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'SavedItems': SavedItemsWidget(),
      'TaskListPage': TaskListPageWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 26,
            ),
            activeIcon: Icon(
              Icons.home,
              size: 26,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_outline,
              size: 26,
            ),
            activeIcon: Icon(
              Icons.star_outlined,
              size: 26,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
              size: 26,
            ),
            activeIcon: Icon(
              Icons.check_circle_sharp,
              size: 26,
            ),
            label: 'Home',
          )
        ],
        backgroundColor: Color(0xFF14181B),
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: FlutterFlowTheme.primaryColor,
        unselectedItemColor: FlutterFlowTheme.tertiaryColor,
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
