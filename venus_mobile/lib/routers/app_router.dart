import 'package:go_router/go_router.dart';
import 'package:thebags_mobile/data/homecard.dart';
import 'package:thebags_mobile/screens/bookingtable_screen.dart';

import 'package:thebags_mobile/screens/cart_screen.dart';
import 'package:thebags_mobile/screens/category_screen.dart';
import 'package:thebags_mobile/screens/change_password_screen.dart';
import 'package:thebags_mobile/screens/customerdetail_screen.dart';

import 'package:thebags_mobile/screens/home_screen.dart';
import 'package:thebags_mobile/screens/login_screen.dart';
import 'package:thebags_mobile/screens/menuList/ingredient_list.dart';
import 'package:thebags_mobile/screens/notifications_screen.dart';
import 'package:thebags_mobile/screens/onboarding_screen.dart';
import 'package:thebags_mobile/screens/profile_screen.dart';
import 'package:thebags_mobile/screens/receipt_detail_screen.dart';
import 'package:thebags_mobile/screens/register_screen.dart';
import 'package:thebags_mobile/screens/settings_screen.dart';

import '../models/post.dart';
import '../screens/contact_screen.dart';
import '../screens/detailpost_screen.dart';
import '../screens/payment_failure_screen.dart';
import '../screens/payment_success_screen.dart';
import '../screens/post_screen.dart';
import '../screens/chef_screen.dart';
import '../screens/staff_order_status_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/table_screen.dart';
import '../screens/payment_screen.dart'; // Thêm dòng này

GoRouter router() {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
          path: '/category',
          builder: (context, state) => CategoryScreen(
              suggestionsArray: articlesCards['Music']?['suggestions'],
              imgArray: articlesCards['Music']?['products'])),
      GoRoute(
        path: '/ingredients/:tableId',
        builder: (context, state) {
          final tableId = int.parse(state.pathParameters['tableId']!);
          return IngredientScreen(tableId: tableId);
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => NotificationsScreen(),
      ),
      GoRoute(
        path: '/post',
        builder: (context, state) => PostScreen(),
      ),
      GoRoute(
        path: '/detailpost',
        builder: (context, state) {
          final post = state.extra as Post;
          return DetailPostScreen(post: post);
        },
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => ContactScreen(),
      ),
      GoRoute(
        path: '/chef',
        builder: (context, state) => ChefScreen(),
      ),
      // Thêm route cho StaffOrderStatusScreen
      GoRoute(
        path: '/staff-order-status',
        builder: (context, state) => StaffOrderStatusScreen(),
      ),
      GoRoute(
        path: '/bookingtable',
        builder: (context, state) => BookingTableScreen(),
      ),
      GoRoute(
        path: '/order-history/:tableId',
        builder: (context, state) {
          final tableId = int.parse(state.pathParameters['tableId']!);
          return OrderHistoryScreen(tableId: tableId);
        },
      ),

      GoRoute(
        path: '/tables',
        builder: (context, state) => TableScreen(),
      ),

      GoRoute(
        path: '/cart/:tableId',
        builder: (context, state) {
          final tableId = int.parse(state.pathParameters['tableId']!);
          return CartScreen(tableId: tableId);
        },
      ),
      GoRoute(
        path: '/payment-success',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          return PaymentSuccessScreen(
            amount: extra['amount'],
            points: extra['points'],
            fullName: extra['fullName'],
            email: extra['email'],
          );
        },
      ),
      GoRoute(
        name: 'paymentFailure',
        path: '/payment/failure',
        builder: (context, state) => PaymentFailureScreen(),
      ),
      GoRoute(
        name: 'payment',
        path: '/payment/:tableId',
        builder: (context, state) {
          final tableId = int.parse(state.pathParameters['tableId']!);
          final totalAmount = state.extra as double;
          return PaymentScreen(tableId: tableId, totalAmount: totalAmount);
        },
      ),
      GoRoute(
        name: 'receiptDetail',
        path: '/receipt/:tableId',
        builder: (context, state) {
          final tableId = int.parse(state.pathParameters['tableId']!);
          return ReceiptDetailScreen(tableId: tableId);
        },
      ),
      /////Customer/////
      GoRoute(
        path: '/customers',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/user_detail',
        builder: (context, state) {
          // Replace `123` with the actual `customerId` value you want to pass
          final customerId = 123;
          return CustomerDetailScreen(customerId: customerId);
        },
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) =>
            ChangePasswordScreen(), // Add a route for ChangePasswordScreen
      ),
    ],
  );
}
