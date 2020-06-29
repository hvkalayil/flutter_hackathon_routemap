# RouteMap🗺️
A flutter application for the Hack20👨‍💻

# What is it?🤔
RouteMap is a location tracking app. It tracks location and interactions. This data helps to track contacts and isolate them, to stop the spread.😷

# Inspiration💡
The idea for this app came up when the Chief minister of kerala, Mr Pinarai Vijayan urged the people of kerala to keep a diary📗s to record their routes and interactions. 
This app is just a digital implementation of that idea.

# Fututre Scope🔮
We can scale the app as a travel app after the pandemic, helping users to record their memories of their travels.


# Project Setup Instructions:
1. google-services.json.
   You need to obtain and insert your google-services.json file into the  /android/app  directory, otherwise the app won't work properly
   To obtain this google-services.json file:
      * Go to Firebase Console and create a new Project
      * Then goto "Project Settings" and add a Firebase to your Android app
      * Follow the setup instructions to obtain the config file (ie, google-services.json)
 
2. Generate your Google Maps GEO API Key and put it in  /android/app/src/main/AndroidManifest.xml file
   Insert it in the following line in the Android Manifest:
     <meta-data android:name="com.google.android.geo.API_KEY"
      android:value="<YOUR-GEO-API-KEY-HERE>"/>
