const advisordata = [
  {
    img: "images/pexels-giftpunditscom-1310522.jpg",
    name: "Helena Doe",
    email: "helena@gmail.com",
    tags: ["Financial coach, Broker, Accountant"],
    price: "80 euro",
    rating: "8 stars",
    sessions: "666",
    location: "2025km",
  },
  {
    img: "images/profilepic2.jpg",
    name: "Daniel V.",
    email: "daniel@gmail.com",
    tags: ["Financial coach, Broker, Accountant"],
    price: "60 euro",
    rating: "8 stars",
    sessions: "666",
    location: ["", ""],
  },
  {
    img: "images/profilepic3.jpg",
    name: "Ufuk A.",
    email: "daniel@gmail.com",
    tags: ["Financial coach, Broker, Accountant"],
    price: "60 euro",
    rating: "8 stars",
    sessions: "666",
    location: ["", ""],
  },
];

document.getElementById("wetry").innerHTML = `
${advisordata
  .map(function (advisors) {
    return `
    <div class="mySlides">
    <div class="person-info">
        <p> ${advisors.name} </p>
        <p> ${
            
        //    haversineDistance(getLocation(), advisors.location, false)
           advisors.location
        }</p>
    </div>
    <div class="person-tags">
        <p>Financial coach</p>
        <p>Accountant</p>
        <p>Broker</p>
      </div>
      <img src="${advisors.img}" style="width:100%">
    <div class="text-boxes-bottom">
        <div class="price">
          <h1>Price</h1>
          <p>${advisors.price}</p>
        </div>
        <div class="rating">
          <h1>Rating</h1>
          <p>${advisors.rating}</p>
        </div>
        <div class="sessions">
          <h1>Sessions</h1>
          <p>${advisors.sessions}</p>
        </div>
        </div>
        
    `;
  })
  .join("")}
`;

var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides((slideIndex += n));
}

function currentSlide(n) {
  showSlides((slideIndex = n));
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  if (n > advisordata.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = slides.length;
  }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slides[slideIndex - 1].style.display = "block";
}

// function getLocation() {
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(showPosition);
//   } else {
//     console.log("Geo Location not supported by browser");
//   }
// }
// function showPosition(position) {
//   var location = {
//     longitude: position.coords.longitude,
//     latitude: position.coords.latitude,
//   };
//    console.log(location);
// }

// function haversineDistance(coords1, coords2, isMiles) {
//   function toRad(x) {
//     return (x * Math.PI) / 180;
//   }

//   var lon1 = coords1[0];
//   var lat1 = coords1[1];

//   var lon2 = coords2[0];
//   var lat2 = coords2[1];

//   var R = 6371; // km

//   var x1 = lat2 - lat1;
//   var dLat = toRad(x1);
//   var x2 = lon2 - lon1;
//   var dLon = toRad(x2);
//   var a =
//     Math.sin(dLat / 2) * Math.sin(dLat / 2) +
//     Math.cos(toRad(lat1)) *
//       Math.cos(toRad(lat2)) *
//       Math.sin(dLon / 2) *
//       Math.sin(dLon / 2);
//   var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
//   var d = R * c;

//   if (isMiles) d /= 1.60934;

//   return d;
// }
