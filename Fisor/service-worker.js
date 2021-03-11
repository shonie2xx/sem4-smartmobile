
self.addEventListener("install", event => {
    event.waitUntil(
    caches.open('static-v1')
      .then(cache => cache.addAll([
        'offline.html',
        'css/stylesheet.css'
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
      console.log("Service Worker: I received some push data, but because I am still very simple I don't know what to do with it :(");
  })
