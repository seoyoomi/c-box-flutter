import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import 'post_list_page.dart';      // 내 게시글 화면
import 'rental_status_page.dart'; // 대여현황 화면
import '../widgets/custom_app_bar_title.dart';
import '../widgets/bottom_nav_bar.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String userName = '사용자'; // 초기값 설정

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? '이름 없음';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBarTitle(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          // 프로필 영역
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Divider(),

          // 대여현황
          _buildMenuTile(
            context,
            icon: Icons.shopping_bag_outlined,
            title: '대여현황',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RentalStatusPage()),
              );
            },

          ),
          const Divider(height: 1),

          // 내 게시글
          _buildMenuTile(
            context,
            icon: Icons.article_outlined,
            title: '내 게시글',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostListPage()),
              );
            },
          ),
          const Divider(height: 1),

          // 설정
          _buildMenuTile(
            context,
            icon: Icons.settings_outlined,
            title: '설정',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
          const Divider(height: 1),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  Widget _buildMenuTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minVerticalPadding: 12,
    );
  }
}