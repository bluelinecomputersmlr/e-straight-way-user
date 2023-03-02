import 'package:estraightwayapp/payment/confirmation.dart';
import 'package:estraightwayapp/view/auth/login_home.dart';
import 'package:estraightwayapp/view/auth/login_home_service_provider.dart';
import 'package:estraightwayapp/view/auth/login_page.dart';
import 'package:estraightwayapp/view/auth/otp_verification_page.dart';
import 'package:estraightwayapp/view/auth/sign_up_page.dart';
import 'package:estraightwayapp/view/auth/sign_up_service_provider.dart';
import 'package:estraightwayapp/view/home/about_us.dart';
import 'package:estraightwayapp/view/home/booking_successful.dart';
import 'package:estraightwayapp/view/home/business_by_map.dart';
import 'package:estraightwayapp/view/home/business_by_service.dart';
import 'package:estraightwayapp/view/home/businesses_by_date_page.dart';
import 'package:estraightwayapp/view/home/cancellation_and_refund.dart';
import 'package:estraightwayapp/view/home/contact_us.dart';
import 'package:estraightwayapp/view/home/course_details_page.dart';
import 'package:estraightwayapp/view/home/home_page.dart';
import 'package:estraightwayapp/view/home/plan_expired_page.dart';
import 'package:estraightwayapp/view/home/privacy_policy.dart';
import 'package:estraightwayapp/view/home/profile_page.dart';
import 'package:estraightwayapp/view/home/sub_category_page.dart';
import 'package:estraightwayapp/view/home/terms_conditions.dart';
import 'package:estraightwayapp/view/home/verify_order.dart';
import 'package:estraightwayapp/view/home/video_player_page.dart';
import 'package:estraightwayapp/view/service_provider/add_service_page.dart';
import 'package:estraightwayapp/view/service_provider/bank_details.dart';
import 'package:estraightwayapp/view/service_provider/customer_reviews.dart';
import 'package:estraightwayapp/view/service_provider/direct_booking_service_provider_sign_up_form.dart';
import 'package:estraightwayapp/view/service_provider/edit_date_business.dart';
import 'package:estraightwayapp/view/service_provider/edit_map_and_slot_business.dart';
import 'package:estraightwayapp/view/service_provider/home_service_provider.dart';
import 'package:estraightwayapp/view/service_provider/map_based_booking_service_provider.dart';
import 'package:estraightwayapp/view/service_provider/my_business_page.dart';
import 'package:estraightwayapp/view/service_provider/new_bookings.dart';
import 'package:estraightwayapp/view/service_provider/payment_confirmation_page.dart';
import 'package:estraightwayapp/view/service_provider/payouts_completed_page.dart';
import 'package:estraightwayapp/view/service_provider/payouts_page.dart';
import 'package:estraightwayapp/view/service_provider/received_bookings.dart';
import 'package:estraightwayapp/view/service_provider/select_category.dart';
import 'package:estraightwayapp/view/service_provider/select_location_page.dart';
import 'package:estraightwayapp/view/service_provider/select_sub_category.dart';
import 'package:estraightwayapp/view/service_provider/slot_based_service_provider.dart';
import 'package:estraightwayapp/view/service_provider/todays_cancelled_orders.dart';
import 'package:estraightwayapp/view/service_provider/todays_confirmed_orders.dart';
import 'package:estraightwayapp/view/splash_page.dart';
import 'package:get/get.dart';

import 'view/auth/login_home_user.dart';
import 'view/home/business_by_date_details.dart';

final pages = [
  //AUTH PAGES
  GetPage(
    name: '/splash',
    page: () => const SplashPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/loginHome',
    page: () => const LoginHomePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/loginHomeUser',
    page: () => const LoginHomeUserPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/loginHomeServiceProvider',
    page: () => const LoginHomeServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/login',
    page: () => LoginPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/otp',
    page: () => OtpVerificationPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/signUp',
    page: () => SignUpPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/signUpServiceProvider',
    page: () => SignUpServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  //HOME PAGE
  GetPage(
    name: '/home',
    page: () => const HomePage(),
    transition: Transition.rightToLeft,
  ),
  //HOME PAGE
  GetPage(
    name: '/profile',
    page: () => const ProfilePage(),
    transition: Transition.rightToLeft,
  ),
  //Plan Expired
  GetPage(
    name: '/expired',
    page: () => const PlanExpiredPage(),
    transition: Transition.rightToLeft,
  ),
  //  COURSE DETAILS PAGE
  GetPage(
    name: '/subCategory',
    page: () => SubCategoryPage(),
    transition: Transition.rightToLeft,
  ),

  //VIDEO PLAYER PAGE
  GetPage(
    name: '/video',
    page: () => const VideoPlayerPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/businessByDate',
    page: () => const BusinessesByDatePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/businessByDateDetails',
    page: () => const BusinessesByDateDetailsPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/bookingsuccessful',
    page: () => BookingSuccesfulPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/businessByService',
    page: () => const BusinessByService(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/businessByMap',
    page: () => const BusinessByMap(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/selectCategoryPage',
    page: () => SelectCategoryPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/selectSubCategoryPage',
    page: () => const SelectSubCategoryPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/directBookingSignUpServiceProvider',
    page: () => const DirectBookingSignUpServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/mapBasedBookingSignUpServiceProvider',
    page: () => const MapBasedBookingSignUpServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/slotBasedBookingSignUpServiceProvider',
    page: () => const SlotBasedBookingSignUpServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/homeServiceProviderPage',
    page: () => const HomeServiceProviderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/successPaymentPage',
    page: () => SuccessPaymentPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/failedPaymentPage',
    page: () => FailedPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/receivedBooking',
    page: () => const ReceivedBookings(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/newBooking',
    page: () => const NewBookings(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/payouts',
    page: () => const PayoutsPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/payoutsCompleted',
    page: () => const PayoutsCompletedPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/myBusiness',
    page: () => const MyBusinesPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/selectLocation',
    page: () => const SelectLocationPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/verifyOrder',
    page: () => const VerifyOrderPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/todaysConfirmedOrder',
    page: () => const TodaysConfirmedOrders(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/todaysCancelledOrder',
    page: () => const TodaysCancelledOrders(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/customerReviews',
    page: () => const CustomerReviews(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/bankDetails',
    page: () => const BankDetails(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/editMapAndSlot',
    page: () => EditMapAndSlotBasedBusiness(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/editDateBusiess',
    page: () => EditDateBasedBusiness(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/addService',
    page: () => AddServicePage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/aboutUs',
    page: () => const AboutUs(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/privacy',
    page: () => const PrivacyPolicy(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/terms',
    page: () => const TermsAndConditions(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/refundPolicy',
    page: () => const CancellationAndRefund(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/contactUs',
    page: () => const ContactUs(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/doPayment',
    page: () => const PaymentConfirmationPage(),
    transition: Transition.rightToLeft,
  ),
];
