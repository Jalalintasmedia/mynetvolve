package com.jlm.mynetvolve

import io.flutter.embedding.android.FlutterFragmentActivity
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.taptalk.taptalklive.TapTalkLive
import io.taptalk.taptalklive.Listener.TapTalkLiveListener

  class MainActivity: FlutterActivity() {
      // ...
      // MethodChannel Result to handle asynchronous call
      private var oneTalkMethodChannelResult: MethodChannel.Result? = null

      // Override configureFlutterEngine
      override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Handle MethodChannel calls
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "io.taptalk.onetalklivechat")
            .setMethodCallHandler {
              call, result ->
              // Save result to variable
              oneTalkMethodChannelResult = result
              when (call.method) {
                // Call native methods
                "initOneTalkLiveChat" -> initOneTalkLiveChat()
                "openLiveChatView" -> openLiveChatView()
                else -> result.notImplemented()
              }
            }
      }

      // Method to initialize OneTalk Live Chat SDK
      private fun initOneTalkLiveChat() {
        TapTalkLive.init(
          applicationContext,
          "9b2ddee308ad354c1f37a9b4117a7f5d2cf362ca3691039a74e90c3e29c04811",
          context.getApplicationInfo().icon,
          // getString(R.string.your_app_name),
          "MyNetvolve",
          object : TapTalkLiveListener() {
            override fun onInitializationCompleted() {
              oneTalkMethodChannelResult?.success(true)
            }
          }
        )
      }

      // Method to open live chat view
      private fun openLiveChatView() {
        val isSuccess = TapTalkLive.openTapTalkLiveView(this)
        oneTalkMethodChannelResult?.success(isSuccess)
      }
  }
