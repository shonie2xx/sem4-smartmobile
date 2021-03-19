const advisordata = [
  {
    img: "images/pexels-giftpunditscom-1310522.jpg",
    name: "Helena Janson",
    email: "helena@gmail.com",
    tag1: "Financial coach",
    tag2: "Broker",
    tag3: "Accountant",
    price: "80 euro",
    rating: "8/10 stars",
    sessions: "666",
    location: "2025km",
  },
  {
    img: "images/profilepic2.jpg",
    name: "John Doe",
    email: "john@gmail.com",
    tag1: "Investments",
    tag2: "Financial consultant",
    tag3: "Robo-advisor",
    price: "60 euro",
    rating: "8 stars",
    sessions: "666",
    location: ["", ""],
  },
  {
    img: "images/profilepic3.jpg",
    name: "Johna Doe",
    email: "johna@gmail.com",
    tag1: "CFP Professional",
    tag2: "Wealth advisor",
    tag3: "Financial consultant",
    price: "79 euro",
    rating: "8 stars",
    sessions: "666",
    location: ["", ""],
  }
];

// const advisordata = [];
//   fetch("./advisordata.json")
//   .then((response)=>{
//       return response.text();
//   })
//   .then((response_text)=> {
//     const data = JSON.parse(response_text);
//     data.forEach(item => {
//       advisordata += item;
//     });
//   })


advisordata.map(function (advisors) {
  document.getElementById("wetry").innerHTML += `
   <div class="mySlides">
   <div class="person-info">
       <p> ${advisors.name} </p>
       <p> ${
         //    haversineDistance(getLocation(), advisors.location, false)
         advisors.location
       }</p>
   </div>
   <div class="person-tags">
       <p>${advisors.tag1}</p>
       <p>${advisors.tag2}</p>
       <p>${advisors.tag3}</p>
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
   `
})

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