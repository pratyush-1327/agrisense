import 'package:agrisense/screens/detetctor_page.dart';
import 'package:agrisense/screens/story_screen.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/providers/chat_provider.dart';
import 'package:agrisense/screens/chat_history_screen.dart';
import 'package:agrisense/screens/chat_screen.dart';
import 'package:agrisense/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list of screens
  final List<Widget> _screens = [
    const StoryScreen(),
    const ChatScreen(),
    DetetctorPage(),
    const ChatHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
          appBar: AppBar( // Add AppBar
            title: Text('appTitle'.tr()), // Use translated title
            actions: [
              IconButton(
                icon: const Icon(Icons.language),
                tooltip: 'selectLanguage'.tr(),
                onPressed: () => _showLanguageDialog(context),
              ),
            ],
          ),
          body: PageView(
            controller: chatProvider.pageController,
            children: _screens,
            onPageChanged: (index) {
              chatProvider.setCurrentIndex(newIndex: index);
              setState(() {});
            },
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: chatProvider.currentIndex,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            indicatorColor: Theme.of(context).colorScheme.primaryContainer,
            onDestinationSelected: (index) {
              chatProvider.setCurrentIndex(newIndex: index);
              chatProvider.pageController.jumpToPage(index);
              setState(() {});
            },
            destinations: [ // Remove const keyword here
              NavigationDestination(
                icon: Icon(CupertinoIcons.money_dollar),
                label: 'Stories'.tr(), // Translate label
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.chat_bubble_2),
                label: 'Chat'.tr(), // Translate label
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.camera),
                label: 'AI Model'.tr(), // Translate label
              ),
              NavigationDestination(
                icon: Icon(Icons.history),
                label: 'Chat History'.tr(), // Translate label
              ),
              NavigationDestination(
                icon: Icon(CupertinoIcons.person),
                label: 'Profile'.tr(), // Translate label
              ),
            ],
          ),
        );
      },
    );
  }

  // Method to show the language selection dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('selectLanguage'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('english'.tr()),
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.of(dialogContext).pop();
                },
              ),
              ListTile(
                title: Text('hindi'.tr()),
                onTap: () {
                  context.setLocale(const Locale('hi'));
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'.tr()),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
