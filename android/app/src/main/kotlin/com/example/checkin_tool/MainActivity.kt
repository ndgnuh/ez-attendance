package com.example.checkin_tool

import android.os.Environment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.ndgnuh.attendance_tool/storage";

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result -> if (call.method == "getStorageRoot") {
                result.success(Environment.getExternalStorageDirectory().absolutePath);
            }
            else {
                result.notImplemented();
            }
        }
    }
}
