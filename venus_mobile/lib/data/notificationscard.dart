final List<Map<String, String>> personalNotificationsList = [
  {
    'text':
        "About your order #45C23B Wifey made the best Father's Day meal ever. So thankful so happy.",
    'time': '15:30',
    'color': 'primary'
  },
  {
    'text':
        'Customize our products. Now you can make the best and perfect clothes just for you.',
    'time': '12:10',
    'color': 'info'
  },
  {
    'text':
        'Breaking News! We have new methods to payment. Learn how to pay off debt fast using the stack method.',
    'time': '11:23',
    'color': 'error'
  },
  {
    'text':
        'Congratulations! Someone just ordered a pair of Yamaha HS8 speakers through your app! Hurry up and ship them!',
    'time': '04:23',
    'color': 'success'
  }
];

final Map<String, List<Map<String, String>>> systemNotificationsList = {
  'Unread notifications': [
    {
      'description': 'The new message from the author.',
      'title': 'New message',
      'time': '2 hrs ago'
    },
    {
      'description': 'A confirmed request by one party.',
      'title': 'New order',
      'time': '3 hrs ago'
    }
  ],
  'Read notifications': [
    {
      'description': "Let's meet at Starbucks at 11:30. Wdyt?",
      'title': 'Last message',
      'time': '1 day ago'
    },
    {
      'description': 'A new issue has been reported for Argon.',
      'title': 'Product issue',
      'time': '2 days go'
    },
    {
      'description': 'Your posts have been liked a lot.',
      'title': 'New likes',
      'time': '4 days ago'
    }
  ]
};
