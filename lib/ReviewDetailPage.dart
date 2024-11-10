import 'package:flutter/material.dart';

class ReviewDetailPage extends StatelessWidget {
  final String storeName;
  final String reviewTitle;
  final String menuName;
  final String reviewContent;
  final String reviewDateTime;
  final String price;
  final int stars;
  final List<String> images;

  const ReviewDetailPage({
    Key? key,
    required this.storeName,
    required this.reviewTitle,
    required this.menuName,
    required this.reviewContent,
    required this.reviewDateTime,
    required this.price,
    required this.stars,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white, // 흰색 화살표
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          reviewTitle,
          style: TextStyle(
            fontFamily: 'Yangjin',
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0367A6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 슬라이더 섹션
            images.isNotEmpty
                ? SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: InteractiveViewer(
                              panEnabled: true,
                              minScale: 0.5,
                              maxScale: 4.0,
                              child: Image.network(
                                images[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        images[index],
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            )
                : Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.restaurant_menu,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),

            // 식당 정보 섹션
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '식당 이름',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        storeName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '메뉴 이름',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        menuName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 리뷰 내용 섹션
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '리뷰 내용',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        reviewContent,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 추가 정보 섹션
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '리뷰 날짜',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        reviewDateTime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '가격(원)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 별점 섹션
            Container(
              width: double.infinity,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '최고 별점',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Yangjin',
                          color: Color(0xFF0367A6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: stars > 0
                            ? List.generate(
                          stars,
                              (index) => Icon(
                            Icons.star,
                            color: Color(0xFFDAA520),
                            size: 24,
                          ),
                        )
                            : [Icon(Icons.close, color: Colors.red, size: 24)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
