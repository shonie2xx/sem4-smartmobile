if("serviceWorker" in navigator){
    navigator.serviceWorker.register("service-worker.js").then(function(registering){
      // Registration was successful
      console.log("Browser: Service Worker registration is successful with the scope",registering.scope);
    }).catch(function(error){
      //The registration of the service worker failed
      console.log("Browser: Service Worker registration failed with the error",error);
    });
  }else { 
    //The registration of the service worker failed
    console.log("Browser: I don't support Service Workers :(");
  }
  
  //Asking for permission with the Notification API
if(typeof Notification!==typeof undefined){ //First check if the API is available in the browser
	Notification.requestPermission().then(function(result){ 
		//If accepted, then save subscriberinfo in database
		if(result==="granted"){
			console.log("Browser: User accepted receiving notifications, save as subscriber data!");
			navigator.serviceWorker.ready.then(function(serviceworker){ //When the Service Worker is ready, generate the subscription with our Serice Worker's pushManager and save it to our list
				const VAPIDPublicKey="BAEs7zwEJG5Zx-D2B9eJkwvTytSTzffs24jUR1DXVuxDV3-GEpDl7kjcUVNNqTUroipDIAu622b5D5yhDQ0YCvA"; // Fill in your VAPID publicKey here
				const options={applicationServerKey:VAPIDPublicKey,userVisibleOnly:true} //Option userVisibleOnly is neccesary for Chrome
				serviceworker.pushManager.subscribe(options).then((subscription)=>{
          //POST the generated subscription to our saving script (this needs to happen server-side, (client-side) JavaScript can't write files or databases)
					let subscriberFormData=new FormData();
					subscriberFormData.append("json",JSON.stringify(subscription));
					fetch("data/saveSubscription.php",{method:"POST",body:subscriberFormData});
				});
			});
		}
	}).catch((error)=>{
		console.log(error);
	});
}

// // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // // 

function getLocation() {
	if(navigator.geolocation) {
	  navigator.geolocation.getCurrentPosition(showPosition);
	} else {
	  console.log("Geo Location not supported by browser");
	}
  }

  //function that retrieves the position
  function showPosition(position) {
	var location = {
	  longitude: position.coords.longitude,
	  latitude: position.coords.latitude
	}
	console.log(location)
  }


// function showDistance() 
// {
// 	return haversineDistance(getLocation(),(51.935585763682894, 4.437270865754224),false);

// }

// document.getElementById("locationdistance").textContent=showDistance();

//   function haversineDistance(coords1, coords2, isMiles) {
//   function toRad(x) {
//     return x * Math.PI / 180;
//   }

//   var lon1 = coords1[0];
//   var lat1 = coords1[1];

//   var lon2 = coords2[0];
//   var lat2 = coords2[1];

//   var R = 6371; // km

//   var x1 = lat2 - lat1;
//   var dLat = toRad(x1);
//   var x2 = lon2 - lon1;
//   var dLon = toRad(x2)
//   var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
//     Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) *
//     Math.sin(dLon / 2) * Math.sin(dLon / 2);
//   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
//   var d = R * c;

//   if(isMiles) d /= 1.60934;

//   return d;
// }

