import 'package:analytics_hms/analytic.dart';
import 'package:analytics_interface/analytics_plugin.dart';
import 'package:location_hms/location.dart';
import 'package:location_interface/location.dart';
import 'package:push_hms/push.dart';
import 'package:push_interface/push.dart';

/// Creates the HMS analytics service.
AnalyticServiceInterface createHmsAnalyticsService() => Analytic();

/// Creates the HMS push notification service.
PushServiceInterface createHmsPushService() => Push();

/// Creates the HMS location service.
LocationServiceInterface createHmsLocationService() => Location();
