import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'Account/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountInfo extends StatefulWidget {
  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  String _nickname = '...';
  String _realname = '...';
  String _email = '...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAccountInfo();
    });
  }

  Future<void> _fetchAccountInfo() async {
    try {
      String? accessToken = await secureStorage.read(key: 'accessToken');
      if (accessToken == null) {
        print("로그인 정보가 없습니다.");
        return;
      }

      final response = await http.get(
        Uri.parse('http://Soon-Sulleng-Guide-1365335815.ap-northeast-2.elb.amazonaws.com/api/users/info'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          _nickname = data['nickname'] ?? '닉네임 없음';
          _realname = data['realname'] ?? '이름 없음';
          _email = data['email'] ?? '이메일 없음';
        });
      } else if (response.statusCode == 401) {
        print('권한이 없습니다. 로그아웃 필요.');
        _handleSignOut();
      } else {
        print('계정 정보를 가져오지 못했습니다. 상태 코드: ${response.statusCode}');
      }
    } catch (error) {
      print('계정 정보를 가져오는 중 오류 발생: $error');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      await secureStorage.delete(key: 'accessToken');
      await secureStorage.delete(key: 'refreshToken');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginWidget()),
      );
    } catch (error) {
      print('로그아웃 에러: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '순슐랭가이드',
                    style: TextStyle(
                      color: Color(0xFF0367A6),
                      fontSize: 30,
                      fontFamily: 'Yangjin',
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/swapped_dishs.png',
                      width: 75,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  _buildInfoCard('사용자 닉네임', _nickname),
                  SizedBox(height: 10),
                  _buildInfoCard('사용자 이름', _realname),
                  SizedBox(height: 10),
                  _buildInfoCard('이메일', _email),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: _handleSignOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // primary 대신 backgroundColor 사용
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  '로그아웃',
                  style: TextStyle(
                    fontFamily: 'Yangjin',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Yangjin',
                color: Color(0xFF0367A6),
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Yangjin',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
