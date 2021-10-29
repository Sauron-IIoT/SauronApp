# Sauron - Mobile Flutter App

Flutter app for Android & iOS

#### Add keytool to environment variable ```Path```

C:\Program Files\Java\jdk1.8.0_251\bin

#### Generating Key for signing app

keytool -genkey -v -keystore c:\Users\<USER>\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

#### Create ```key.properties``` file

Create a file named ```[project]/android/key.properties``` that contains a reference to your keystore:

```
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```

Follow tutorial on https://flutter.dev/docs/deployment/android