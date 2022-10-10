import 'package:flutter/material.dart';
import 'package:flutter_application_1/common/const/colors.dart';
import 'package:flutter_application_1/common/layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;

  // initState()에서 무조건 값이 초기화 된다는걸 알기 떄문에 'late' 사용
  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      bottomNavigationbar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
      child: Center(
        child: TabBarView(
          controller: controller,
          // 좌우 스크롤 방지
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Container(
                child: Text('홈'),
              ),
            ),
            Center(
              child: Container(
                child: Text('음식'),
              ),
            ),
            Center(
              child: Container(
                child: Text('주문'),
              ),
            ),
            Center(
              child: Container(
                child: Text('프로필'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
