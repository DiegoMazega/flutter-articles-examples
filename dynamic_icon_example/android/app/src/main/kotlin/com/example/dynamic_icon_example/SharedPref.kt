package com.example.dynamic_icon_example.helper

import android.content.Context
import android.content.Context.MODE_PRIVATE
import android.content.SharedPreferences

open class AppSharedPref {

    companion object {
        const val CONFIGURATION_PREF = "configurationPreference"

        /*launcher icon*/
        private const val KEY_LAUNCHER_IMAGE = "launcherIcon"
        private const val KEY_LAUNCHER_COUNT = "count"
        private const val KEY_LAUNCHER_SAVED_COUNT = "savedCount"

        fun getSharedPreference(context: Context, preferenceFile: String): SharedPreferences {
            return context.getSharedPreferences(preferenceFile, MODE_PRIVATE)
        }

        fun getSharedPreferenceEditor(
            context: Context,
            preferenceFile: String
        ): SharedPreferences.Editor {
            return context.getSharedPreferences(preferenceFile, MODE_PRIVATE).edit()
        }

        /* Settings Related functions */

        fun getLauncherIcon(context: Context): String? {
            return getSharedPreference(context, CONFIGURATION_PREF)
                .getString(KEY_LAUNCHER_IMAGE, "launcherAlias.DefaultLauncherAlias")
        }

        fun setLauncherIcon(context: Context, launcherIcon: String) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putString(KEY_LAUNCHER_IMAGE, launcherIcon)
                .apply()
        }

        fun getCount(context: Context): Int {
            return getSharedPreference(context, CONFIGURATION_PREF).getInt(KEY_LAUNCHER_COUNT, 0)
        }

        fun setCount(context: Context, count: Int) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putInt(KEY_LAUNCHER_COUNT, count)
                .apply()
        }

        fun getSavedCount(context: Context): Int {
            return getSharedPreference(context, CONFIGURATION_PREF)
                .getInt(KEY_LAUNCHER_SAVED_COUNT, 0)
        }

        fun setSavedCount(context: Context, count: Int) {
            getSharedPreferenceEditor(context, CONFIGURATION_PREF)
                .putInt(KEY_LAUNCHER_SAVED_COUNT, count)
                .apply()
        }
    }
}