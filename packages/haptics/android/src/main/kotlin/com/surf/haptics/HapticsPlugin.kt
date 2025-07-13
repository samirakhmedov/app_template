package com.surf.haptics

import android.app.Activity
import android.os.Build
import android.util.Log
import android.view.HapticFeedbackConstants
import android.view.View
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class HapticsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {

    // The companion object with all constants remains the same.
    private companion object {
        const val CHANNEL_NAME = "com.surf/haptics"

        object Methods {
            const val INIT = "init"
            const val DISPOSE = "dispose"
            const val IMPACT = "impact"
            const val NOTIFICATION = "notification"
            const val SELECTION = "selection"
            const val FEEDBACK = "feedback"
        }

        object Keys {
            const val STYLE = "style"
            const val TYPE = "type"
        }

        object Impact {
            const val LIGHT = "light"
            const val MEDIUM = "medium"
            const val HEAVY = "heavy"
            const val SOFT = "soft"
            const val RIGID = "rigid"
        }

        object Notification {
            const val SUCCESS = "success"
            const val WARNING = "warning"
            const val ERROR = "error"
        }

        object Feedback {
            const val CONTEXT_CLICK = "contextClick"
            const val DRAG_START = "dragStart"
            const val GESTURE_END = "gestureEnd"
            const val GESTURE_START = "gestureStart"
            const val TEXT_HANDLE_MOVE = "textHandleMove"
            const val VIRTUAL_KEY_RELEASE = "virtualKeyRelease"
        }
    }

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        val view = activity?.window?.decorView

        if (view == null) {
            // Если view недоступен (приложение в фоне или activity еще не привязана),
            // логируем это и тихо завершаем. Тактильный отклик - не критичная функция.
            Log.w("Haptics", "Cannot trigger haptic feedback: View is not available.")
            result.success(null)
            return
        }

       when (call.method) {
            Methods.INIT -> { /* Initialization is not needed on Android */ }
            Methods.DISPOSE -> { /* Disposing is not needed on Android */ }
            Methods.IMPACT -> triggerImpact(view, call.argument<String>(Keys.STYLE))
            Methods.NOTIFICATION -> triggerNotification(view, call.argument<String>(Keys.TYPE))
            Methods.SELECTION -> triggerSelection(view)
            Methods.FEEDBACK -> triggerFeedback(view, call.argument<String>(Keys.TYPE))
            else -> {
                result.notImplemented()
                return
            }
        }
        // Отправляем success после фактического вызова триггера
        result.success(null)
    }
    
    private fun triggerImpact(view: View, style: String?) {
        val feedbackConstant = when (style) {
            Impact.LIGHT -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) HapticFeedbackConstants.KEYBOARD_TAP else null
            Impact.MEDIUM -> HapticFeedbackConstants.VIRTUAL_KEY
            Impact.HEAVY -> HapticFeedbackConstants.LONG_PRESS
            Impact.SOFT -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) HapticFeedbackConstants.KEYBOARD_TAP else null
            Impact.RIGID -> HapticFeedbackConstants.LONG_PRESS
            else -> null
        }
        feedbackConstant?.let { view.performHapticFeedback(it) }
    }

    private fun triggerNotification(view: View, type: String?) {
        val feedbackConstant = when (type) {
            Notification.SUCCESS -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) HapticFeedbackConstants.CONFIRM else null
            Notification.ERROR -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) HapticFeedbackConstants.REJECT else null
            else -> null
        }
        feedbackConstant?.let { view.performHapticFeedback(it) }
    }

    private fun triggerSelection(view: View) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            view.performHapticFeedback(HapticFeedbackConstants.CLOCK_TICK)
        }
    }

    private fun triggerFeedback(view: View, type: String?) {
        val feedbackConstant = when (type) {
            Feedback.CONTEXT_CLICK -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) HapticFeedbackConstants.CONTEXT_CLICK else null
            Feedback.DRAG_START -> if (Build.VERSION.SDK_INT >= 34) HapticFeedbackConstants.DRAG_START else null
            Feedback.GESTURE_END -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) HapticFeedbackConstants.GESTURE_END else null
            Feedback.GESTURE_START -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) HapticFeedbackConstants.GESTURE_START else null
            Feedback.TEXT_HANDLE_MOVE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) HapticFeedbackConstants.TEXT_HANDLE_MOVE else null
            Feedback.VIRTUAL_KEY_RELEASE -> if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) HapticFeedbackConstants.VIRTUAL_KEY_RELEASE else null
            else -> null
        }
        feedbackConstant?.let { view.performHapticFeedback(it) }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }
}
