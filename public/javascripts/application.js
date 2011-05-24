// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var map;
var geocoder;
var lat = 10.3111111;
var lng = 123.8916667;


function initialize(lat, lng) {
  var latlng = new google.maps.LatLng(lat, lng);
  var options = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
  }
  
  map = new google.maps.Map(document.getElementById("map_canvas"), options);
    
  var marker = new google.maps.Marker({
      position: latlng,
      draggable: true,
      position: latlng
  });
  
  // To add the marker to the map, call setMap();
  marker.setMap(map);
  
        // add listener to marker
  google.maps.event.addListener(marker, "dragend", function() {
    var point = marker.getPosition();
    map.panTo(point);
    document.getElementById("place_latitude").value = point.lat();
    document.getElementById("place_longitude").value = point.lng();
  });
}

function oc(a)
{
  var o = {};
  for(var i=0;i<a.length;i++)
  {
    o[a[i]]='';
  }
  return o;
}

function codeAddress(location) {
    var address = document.getElementById("location").value;
    geocoder = new google.maps.Geocoder();
  
    if (address in oc(locations)) 
    {  
     geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
            map: map,
            position: results[0].geometry.location
        });
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
    
    
    }
    
    else
      alert("Sorry, location not found.");
  }
