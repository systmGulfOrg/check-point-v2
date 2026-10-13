package com.systmgulf.checkpoint

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private lateinit var locationIntegrityHandler: LocationIntegrityHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        locationIntegrityHandler = LocationIntegrityHandler(applicationContext)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LocationIntegrityHandler.CHANNEL,
        ).setMethodCallHandler { call, result ->
            locationIntegrityHandler.handle(call, result)
        }
    }
}
