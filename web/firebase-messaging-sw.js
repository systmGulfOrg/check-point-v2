// Firebase Cloud Messaging service worker for web push.
// Values mirror DefaultFirebaseOptions.web in lib/firebase_options.dart.
importScripts('https://www.gstatic.com/firebasejs/10.14.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.14.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: 'AIzaSyAHNU8K6opgwgRlAQ8SfA87EHhtUqASPLU',
  appId: '1:647735685057:web:886658348a50ec93a54940',
  messagingSenderId: '647735685057',
  projectId: 'check-point-70fd8',
  authDomain: 'check-point-70fd8.firebaseapp.com',
  storageBucket: 'check-point-70fd8.firebasestorage.app',
});

firebase.messaging();
