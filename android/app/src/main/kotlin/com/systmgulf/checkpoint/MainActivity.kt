package com.systmgulf.checkpoint

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private lateinit var locationIntegrityHandler: LocationIntegrityHandler
    private lateinit var playIntegrityHandler: PlayIntegrityHandler

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        locationIntegrityHandler = LocationIntegrityHandler(applicationContext)
        playIntegrityHandler = PlayIntegrityHandler(applicationContext)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            LocationIntegrityHandler.CHANNEL,
        ).setMethodCallHandler { call, result ->
            locationIntegrityHandler.handle(call, result)
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            PlayIntegrityHandler.CHANNEL,
        ).setMethodCallHandler { call, result ->
            playIntegrityHandler.handle(call, result)
        }
    }
}
