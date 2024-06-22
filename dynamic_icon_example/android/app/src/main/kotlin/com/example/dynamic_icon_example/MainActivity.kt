package com.example.dynamic_icon_example

import android.content.ComponentName
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import com.example.dynamic_icon_example.helper.AppSharedPref

class MainActivity: FlutterActivity() {

    private val CHANNEL = "app.com.get.change.icon"
    var methodChannelResult: MethodChannel.Result? = null
    // Add all aliases without the initial dot
    val aliases = listOf("launcherAlias.Default", "launcherAlias.One", "launcherAlias.Two") 

    @Override
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result
                if (call.method.equals("changeIcon")) {
                    val targetIcon = call.argument<String>("targetIcon") as String 
                    AppSharedPref.setLauncherIcon(this, "launcherAlias.$targetIcon")
                    AppSharedPref.setCount(this, 0)
                } else {
                    result.success(-1)
                }
            } catch (e: Exception) {
                print(e)
            }
        }
    }

    override fun onDestroy() {
        setIcon(AppSharedPref.getLauncherIcon(this).toString())
        super.onDestroy()
    }

    private fun setIcon(targetIcon: String) {
        try {
            val packageManager: PackageManager = applicationContext!!.packageManager
            val packageName = applicationContext!!.packageName
            val className = StringBuilder()
            className.append(packageName)
            className.append(".")
            className.append(targetIcon)


            aliases.forEach { alias ->
                val state =
                    if (alias == targetIcon) PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                    else PackageManager.COMPONENT_ENABLED_STATE_DISABLED

                packageManager.setComponentEnabledSetting(
                    ComponentName(packageName, "com.example.dynamic_icon_example.$alias"),
                    state,
                    PackageManager.DONT_KILL_APP
                )
            }
        } catch (e: Exception) {
            print(e)
        }
    }
}
