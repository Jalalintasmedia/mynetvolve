// import com.google.firebase.messaging.FirebaseMessagingService
// import com.google.firebase.messaging.RemoteMessage
// import com.zohosalesiq.plugin.MobilistenPlugin

// class MyFirebaseMessagingService : FirebaseMessagingService() {
//     override fun onMessageReceived(remoteMessage: RemoteMessage) {
//         val extras: Map<*, *> = remoteMessage.data
//         MobilistenPlugin.handleNotification(this.application, extras)
//     }

//     override fun onNewToken(token: String) {
//         MobilistenPlugin.enablePush(token, true)
//     }
// }