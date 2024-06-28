final Map<String, String> beauty = {
  'Artists':
      'https://images.unsplash.com/photo-1466150036782-869a824aeb25?fit=crop&w=1350&q=80',
  'Concerts':
      'https://images.unsplash.com/photo-1464375117522-1311d6a5b81f?fit=crop&w=1050&q=80',
  'DJs':
      'https://images.unsplash.com/photo-1485120750507-a3bf477acd63?fit=crop&w=1050&q=80',
  'Hands':
      'https://images.unsplash.com/photo-1556229162-5c63ed9c4efb?fit=crop&w=1534&q=80',
  'Body':
      'https://images.unsplash.com/photo-1556229010-6c3f2c9ca5f8?fit=crop&w=634&q=80',
  'Face':
      'https://images.unsplash.com/photo-1487412912498-0447578fcca8?fit=crop&w=1350&q=80',
  'Trends':
      'https://images.unsplash.com/photo-1524835005923-56700046e4a8?fit=crop&w=1052&q=80',
  'Clothes':
      'https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?fit=crop&w=726&q=80',
  'Accessory':
      'https://images.unsplash.com/photo-1542779632-539b861ee8f9?fit=crop&w=634&q=80',
  'Fashion':
      'https://images.unsplash.com/photo-1479064555552-3ef4979f8908?fit=crop&w=1350&q=80',
  'Garage Sale':
      'https://images.unsplash.com/photo-1484502249930-e1da807099a5?fit=crop&w=1267&q=80',
  'Wedding Dress':
      'https://images.unsplash.com/photo-1519657337289-077653f724ed?fit=crop&w=1350&q=80'
};
final Map<String, String> fashion = {
  'Nike Air Max':
      'https://images.unsplash.com/photo-1511556670410-f6989d6b0766?fit=crop&w=1234&q=80',
  'Blue Adidas':
      'https://images.unsplash.com/photo-1520256788229-d4640c632e4b?fit=crop&w=1350&q=80',
  'Perfect Shoes':
      'https://images.unsplash.com/photo-1525092029632-cb75fe5dd776?fit=crop&w=1350&q=80',
  'Fashion Shoes':
      'https://images.unsplash.com/photo-1523191665038-d75548b1a52a?fit=crop&w=1350&q=80',
  'Orange Sneakers':
      'https://images.unsplash.com/photo-1521774971864-62e842046145?fit=crop&w=1350&q=80',
  'Makeup Kit':
      'https://images.unsplash.com/photo-1527633412983-d80af308e660?fit=crop&w=634&q=80',
  'Lipstick Kit':
      'https://images.unsplash.com/photo-1530863138121-03aea5f46fd4?fit=crop&w=1350&q=80',
  'Premium Brushes':
      'https://images.unsplash.com/photo-1519368358672-25b03afee3bf?fit=crop&w=1002&q=80',
  'Fashion Colors':
      'https://images.unsplash.com/photo-1515688594390-b649af70d282?fit=crop&w=995&q=80',
  'Pink Glitter':
      'https://images.unsplash.com/photo-1526336686748-bd7bb2f1df84?fit=crop&w=1350&q=80',
  'Colorful Hearts':
      'https://images.unsplash.com/photo-1541329164087-0283eda68eda?fit=crop&w=634&q=80',
  'Get purple inspiration':
      'https://images.unsplash.com/photo-1551895889-f1469e75acaa?fit=crop&w=1189&q=80',
  'Favorite high heels':
      'https://images.unsplash.com/photo-1491897554428-130a60dd4757?fit=crop&w=1400&q=80',
  'Pastel Hearts Sunglasses':
      'https://images.unsplash.com/photo-1530832805884-45f17d57a3d8?fit=crop&w=634&q=80',
  'Awesome destination':
      'https://images.unsplash.com/photo-1513149739851-50f01dfcbd9a?fit=crop&w=1350&q=80',
  'A literary journal published by the Black Earth.':
      'https://images.unsplash.com/photo-1551814038-046d8e76f44f?fit=crop&w=1489&q=80',
  'By submitting, you guarantee.':
      'https://images.unsplash.com/photo-1487029413235-e3f7a0e8e140?fit=crop&w=1050&q=80',
  'All About Lights is located in Boie.':
      'https://images.unsplash.com/photo-1516437124483-bb0f86708932?fit=crop&w=800&q=80',
  'Meet our about play staff: click on any.':
      'https://images.unsplash.com/photo-1502048962539-e47cf2fcc9ce?fit=crop&w=1053&q=80',
  'Whether it comes from the Sun.':
      'https://images.unsplash.com/photo-1485001564903-56e6a54d46ef?fit=crop&w=1050&q=80',
};

//fashion == deals
//beauty == categories

final Map<String, List<Map<String, dynamic>>> imgList = {
  'hands': [
    {
      'img':
          'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?crop=entropy&fit=crop&w=840&q=80',
      'price': '125',
      'description':
          'Discover all Tissot® novelties with watches for men and women on the Official Tissot Website.',
      'title': 'Tisson Watch',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
    {
      'img':
          'https://images.unsplash.com/photo-1530518119128-ca0bd1a0643b?crop=entropy&fit=crop&w=840&q=80',
      'price': '150',
      'description':
          'Apple Watch Series 4 features its largest display yet, a re-engineered digital crown, cellular to make calls.',
      'title': 'Apple Watch',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
    {
      'img':
          'https://images.unsplash.com/photo-1539874754764-5a96559165b0?crop=entropy&fit=crop&w=840&q=80',
      'price': '300',
      'description':
          'We have the latest styles & trends of Fossil watches, wallets, bags and accessories. FREE Shipping & Returns.',
      'title': 'Fossil Watch',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'face': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'accessory': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'body': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'clothes': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'trends': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'artists': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'concerts': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'DJs': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'fashion': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'garagesale': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
  'weddingdress': [
    {
      'img': '',
      'price': '',
      'description': '',
      'title': '',
      'suggestions': [
        {'img': '', 'title': ''},
        {'img': '', 'title': ''},
      ],
    },
  ],
};

Map<String, Map> images = {'beauty': beauty, 'fashion': fashion};
