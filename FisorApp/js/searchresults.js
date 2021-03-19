const searchresultdata = [
    {
      img: "images/pexels-giftpunditscom-1310522.jpg",
      name: "Helena Janson",
      email: "helena@gmail.com",
      tag1: "Financial coach",
      tag2: "Broker",
      tag3: "Accountant",
      price: "80 euro",
      rating: "7/10",
      sessions: "248",
      location: "189km",
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
  
  document.getElementById("searchresults").innerHTML = `
  ${searchresultdata
    .map(function (advisors) {
      return `
      <div class="advisors"> <!--Flex column-->
    <div class="advisor-card"> <!--Flex row-->
    <div class="imgcontainer"><img src="${advisors.img}"></div>
    <div class="information"> <!--Flex column--> 
    <div class="information-heading"> <!--Flex row-->
    <h2>${advisors.name}</h2>
    </div>
    <p>
    Lorem ipsum dolor, sit amet consectetur adipisicing elit. Vel culpa consequatur facere suscipit,
    a voluptate maxime veritatis obcaecati ad dolor, placeat eaque, possimus odit deserunt quis ipsum 
    nisi illum reprehenderit.
    </p>

    <div class="information-bubbles"> <!--Flex row-->
    <h3>${advisors.tag1}</h3>
    <h3>${advisors.tag2}</h3>
    <h3>${advisors.tag3}</h3>
    </div>
    <div class="information-metrics"> <!--Flex row-->
    <div class="metrics-price">
    <h4>Price</h4>
    <h6>${advisors.price}</h6>
    </div>
    <div class="metrics-ratings">
    <h4>Ratings</h4>
    <h6>${advisors.rating}</h6>
    </div>
    <div class="metrics-sessions">
    <h4>Sessions</h4>
    <h6>${advisors.sessions}</h6>
    </div>
    </div>
    </div>
    <!--Final coulumn-->
    
    <a href="advisorprofile.html">
    <i style="margin-top: 0.5rem; margin-right:0.5rem;"class="fas fa-arrow-right" ></i>
    </a>
    </div>
      `;
    })
    .join("")}
  `;