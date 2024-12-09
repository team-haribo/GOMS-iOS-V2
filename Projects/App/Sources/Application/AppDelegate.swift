import UIKit
import Firebase
import UserNotifications
import Feature

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let notificationViewModel = NotificationViewModel()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { granted, _ in
                if granted {
                    self.checkOutingStatusAndScheduleNotifications()
                }
            }
        )

        application.registerForRemoteNotifications()

        Messaging.messaging().delegate = self

        return true
    }

    func checkOutingStatusAndScheduleNotifications() {
            notificationViewModel.getOutingStatus { result in
                switch result {
                case .success(let isOuting):
                    if isOuting {
                        self.scheduleWeeklyNotifications()
                        self.scheduleFiveMinutesBeforeNotification()
                    } else {
                        self.scheduleNoOutingNotification()
                    }
                case .failure(let error):
                    print("외출제 상태를 가져오지 못함: \(error)")
                }
            }
        }

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {}

    func scheduleWeeklyNotifications() {
        let center = UNUserNotificationCenter.current()

        let daysOfWeek = [2, 4]

        for day in daysOfWeek {
            let content = UNMutableNotificationContent()
            content.title = "[GOMS] 개발팀"
            content.body = "외출제 시행하는 날입니다!\n추가사항은 GSM 디코 공지채널을 확인해주세요!"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 16
            dateComponents.minute = 20
            dateComponents.weekday = day

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "weeklyNotification\(day)", content: content, trigger: trigger)

            center.add(request) { (error) in
                if let error = error {
                    print("Error scheduling weekly notification: \(error)")
                }
            }
        }
    }

    func scheduleFiveMinutesBeforeNotification() {
        let center = UNUserNotificationCenter.current()

        let daysOfWeek = [2, 4]

        for day in daysOfWeek {
            let content = UNMutableNotificationContent()
            content.title = "[GOMS] 개발팀"
            content.body = "잠시 후에 외출제가 시작해요!\n외출하시겠어요?"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 18
            dateComponents.minute = 35
            dateComponents.weekday = day

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "weeklyNotification\(day)", content: content, trigger: trigger)

            center.add(request) { (error) in
                if let error = error {
                    print("Error scheduling weekly notification: \(error)")
                }
            }
        }
    }

    func scheduleNoOutingNotification() {
        let center = UNUserNotificationCenter.current()

        let daysOfWeek = [2, 4]

        for day in daysOfWeek {
            let content = UNMutableNotificationContent()
            content.title = "[GOMS] 개발팀"
            content.body = "❌ㅣ오늘은 외출제를 시행하지 않아요!\n외출하시면 무단 외출 처리입니다"
            content.sound = .default

            var dateComponents = DateComponents()
            dateComponents.hour = 16
            dateComponents.minute = 20
            dateComponents.weekday = day

            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "weeklyNotification\(day)", content: content, trigger: trigger)

            center.add(request) { (error) in
                if let error = error {
                    print("Error scheduling weekly notification: \(error)")
                }
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken

        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .sound])
    }
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")

        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
}
