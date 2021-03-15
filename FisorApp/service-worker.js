
self.addEventListener("install", event => {
    event.waitUntil(
    caches.open('static-v1')
      .then(cache => cache.addAll([
        "manifest.json",
        'offline.html',
        'css/stylesheet.css',
        "js/scripts.js",
        "images/icons/icon-72x72.png",
        "images/icons/icon-96x96.png",
        "images/icons/icon-128x128.png",
        "images/icons/icon-144x144.png",
        "images/icons/icon-152x152.png",
        "images/icons/icon-192x192.png",
        "images/icons/icon-384x384.png",
        "images/icons/icon-512x512.png",
        "images/favicon.ico"
      ])));
    console.log("Service Worker: I am being installed, hello world!");
  });

  self.addEventListener("activate",(activating)=>{
    console.log("Service Worker: All systems online, ready to go!");
  });

  self.addEventListener("fetch", event =>{
    event.respondWith(
      caches.match(event.request)
      .then(response => response || fetch(event.request))
      .catch(() => {
        if(event.request.mode == 'navigate') {
          return caches.match('offline.html')
        }
      })
    )
    console.log("Service Worker: User threw a ball, I need to fetch it!");
  });

  self.addEventListener("push",(pushing)=>{
    if(pushing.data){
      pushdata=JSON.parse(pushing.data.text());		
      console.log("Service Worker: I received this:",pushdata);
      if((pushdata["title"]!="")&&(pushdata["message"]!="")){			
        const options={ body:pushdata["message"] }
        self.registration.showNotification(pushdata["title"],options);
        console.log("Service Worker: I made a notification for the user");
      } else {
        console.log("Service Worker: I didn't make a notification for the user, not all the info was there :(");			
      }
    }
      console.log("Service Worker: I received some push data, but because I am still very simple I don't know what to do with it :(");
  })

  self.addEventListener("notificationclick",function(clicking){
    const pageToOpen="/";
    const promiseChain=clients.openWindow(pageToOpen);
    event.waitUntil(promiseChain);
  });