## Flutter wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -keep class androidx.media.** { *; }
 -keep class com.google.android.exoplayer2.** { *; }
 -keep class com.google.android.gms.** { *; }
 -keep class com.google.android.material.** { *; }
 -dontwarn io.flutter.embedding.**
 -ignorewarnings

 -keepclassmembers class * {
     @android.webkit.JavascriptInterface <methods>;
 }

 -keepattributes JavascriptInterface
 -keepattributes *Annotation*

 -dontwarn com.razorpay.**
 -keep class com.razorpay.** {*;}

 -optimizations !method/inlining/*

 -keepclasseswithmembers class * {
   public void onPayment*(...);
 }