const advisorprofiledata = [
    {
      img: "images/pexels-giftpunditscom-1310522.jpg",
      name: "Helena Janson",
      location: "2025km",
      email: "helana@gmail.com",
      tag1: "Financial coach",
      tag2: "Broker",
      tag3: "Accountant",
      tag4: "Personal",
      tag5: "Business",
      price: "$80/hour",
      rating: "8/10 stars",
      review: "666",
      ongoing: "11",
      sessions: "666",
    //   location: "189km",
      user_review: "John Doe User",
    }
  ];
  
  document.getElementById("advisorprofile").innerHTML = `
  ${advisorprofiledata
    .map(function (advisors) {
      return `
      <div class="container">
        <div class="personal-column">
            <div class="profilepic-row">
            
            <div class="imgcontainer"><img src="${advisors.img}"></div>
                 <div class="icon"><i class="far fa-heart"></i></div>
            </div>
            <h3 id="name">${advisors.name}</h3>
            <div class="city">
                <i class="fas fa-map-marker-alt" id="location"></i>
                <h3 id="city"> ${advisors.location}</h3>
            </div>
            <div class="price-email-rating-row">
                <div class="perr-text" id="price">
                    <h2>Price</h2>
                    <h4>${advisors.price}</h4>
                </div> <!--Flex column-->
                <a href="https://mail.google.com/"><i class="fas fa-address-card fa-4x" id="email-icon"></i></a>
                <div class="perr-text" id="rating">
                    <h2>Rating</h2>
                    <h4>${advisors.rating}</h4>                   
                </div> <!--Flex column-->
            </div>
            <div class="stats-row">
                <div class="review">
                    <div id="stats-review"><h4>${advisors.review} <br> Review</h4></div>
                    <div id="stats-clients"><h4>${advisors.ongoing} <br> Ongoing</h4></div>
                    <div id="stats-sessions"><h4>${advisors.sessions} <br> Sessions</h4> </div>
                </div>
            </div>
            <div class="financial-experience"> <!--Flex column-->
                <h3 id="financial-text">Financial Experience</h3>
                <div class = "experience-bubbles"> <!--Flex row-->
                    <h5>${advisors.tag1}</h5>
                    <h5>${advisors.tag2}</h5>
                    <h5>${advisors.tag3}</h5>
                    <h5>${advisors.tag4}</h5>
                    <h5>${advisors.tag5}</h5>
                </div>
            <div class="about-me"> <!--Flex column-->
                <h3>About me</h3>
                <p>
                    “I believe that the biggest mistake that most people make 
                    when it comes to their retirement is...”
                </p>
            </div>
            <div class="reviews"> <!--Flex column-->
                <h3>Reviews</h3>
                <div class="review">
                    <img class="profile-picture-review" src="./images/picture.jpg">
                    <div class="review-text"> <!--Flex column-->
                        <h4>${advisors.user_review}</h4>
                        <p>“This guy really gave me a                    
                            jumpstart in my career.“
                        </p>
                    </div>
                
                </div>
                <i class="fas fa-chevron-down" id="more-reviews-chevron"></i> 
            </div>
        </div>
    </div>
      `;
    })
    .join("")}
  `;