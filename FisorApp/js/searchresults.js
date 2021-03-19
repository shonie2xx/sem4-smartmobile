const searchresultdata = [
    {
      img: "images/pexels-giftpunditscom-1310522.jpg",
      name: "Helena Janson",
      email: "helena@gmail.com",
      tags: ["VC"],
      tags2: ["Personal Finance"],
      price: "80 euro",
      rating: "7/10",
      sessions: "248",
      location: "189km",
    },
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
    <h3>${advisors.tags}</h3>
    <h3>${advisors.tags2}</h3>
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
    <i style="margin-top: 0.5rem; margin-right:0.5rem;"class="fas fa-arrow-right"></i> <!--Final coulumn-->
    </div>
      `;
    })
    .join("")}
  `;