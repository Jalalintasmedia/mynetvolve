import UIKit
import Flutter
import GoogleMaps
import Firebase // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate  {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    Messaging.messaging().delegate = self
    GMSServices.provideAPIKey("AIzaSyAa8Jh5JbAe7MUGdnE_x8wMmsEM004MBws")
    GeneratedPluginRegistrant.register(with: self)
    
    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}