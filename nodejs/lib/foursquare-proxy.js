// StateHQ
var LAT = 51.508857899999995;
var LONG = -0.195678;

var foursquare = require("foursquare-js")({
  secrets: {
    clientId: "AV03ZKZYEYRCHDPEIJN4QDMCZV30M5UM14XWSONSNS3YQFNV",
    clientSecret: "HICXJ5YBXQRJGH0GW0DIYXGSNGAKYXWCK5WL00EWMPHRE1CJ",
    redirectUrl: "n/a"
  },

  foursquare: {
    version: "20130606"
  }
});

exports.searchVenues = function(query, callback){
  foursquare.Venues.search(LAT, LONG, null, { query: query }, null, callback);
};
