# Keep classes for flutter_local_notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Keep Gson TypeToken classes
-keepattributes Signature
-keep class com.google.gson.reflect.TypeToken { *; }

# Keep generic types used in Gson serialization
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
