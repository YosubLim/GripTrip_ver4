function checkBox(num) {
    // 체크박스 갯수만큼 반복문을 돌면서
    for (i=0; i<8;i++) {
       // 체크박스가 선택되어 있으면
         if (eval("document.storyFrm.storyIsPublic[" + i + "].checked") == true) {
              // 우선 체크박스의 속성을 선택되지 않음으로 하고
              document.storyFrm.storyIsPublic[i].checked = false;

              // 사용자가 클릭한 체크박스와 프로그래밍적으로 돌고 있는
            // 체크박스의 번호가 같으면
              if (i == num) {
                   // 이런 경우만 체크박스가 선택되도록 한다...
                   document.storyFrm.storyIsPublic[i].checked = true;
              }
        }
    }
 }



    function initMap() {
       var map = new google.maps.Map(document.getElementById('map'), {
         center: {lat: -33.8688, lng: 151.2195},
         zoom: 13
       });
       var input = /** @type {!HTMLInputElement} */(
           document.getElementById('pac-input'));

       var types = document.getElementById('type-selector');
       map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
       map.controls[google.maps.ControlPosition.TOP_LEFT].push(types);

       var autocomplete = new google.maps.places.Autocomplete(input);
       autocomplete.bindTo('bounds', map);

       var infowindow = new google.maps.InfoWindow();
       var marker = new google.maps.Marker({
         map: map,
         anchorPoint: new google.maps.Point(0, -29)
       });

       autocomplete.addListener('place_changed', function() {
         infowindow.close();
         marker.setVisible(false);
         var place = autocomplete.getPlace();
         if (!place.geometry) {
           // User entered the name of a Place that was not suggested and
           // pressed the Enter key, or the Place Details request failed.
          window.alert("No details available for input: '" + place.name + "'");
           return;
         }

         // If the place has a geometry, then present it on a map.
         if (place.geometry.viewport) {
           map.fitBounds(place.geometry.viewport);
         } else {
           map.setCenter(place.geometry.location);
           map.setZoom(17);  // Why 17? Because it looks good.
          
         }
         marker.setIcon(/** @type {google.maps.Icon} */({
           url: place.icon,
           size: new google.maps.Size(71, 71),
           origin: new google.maps.Point(0, 0),
           anchor: new google.maps.Point(17, 34),
           scaledSize: new google.maps.Size(35, 35)
         }));
         marker.setPosition(place.geometry.location);
         marker.setVisible(true);

         var address = '';
         if (place.address_components) {
           address = [
             (place.address_components[0] && place.address_components[0].short_name || ''),
             (place.address_components[1] && place.address_components[1].short_name || ''),
             (place.address_components[2] && place.address_components[2].short_name || '')
           ].join(' ');
         }

         infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
         infowindow.open(map, marker);
         //alert("location: "+place.name);
         //alert(place.geometry.location.lng()+" "+place.geometry.location.lat());
         var s = document.storyFrm;
         s.storyLocation.value = place.name;
         s.storyLatitude.value = place.geometry.location.lat();
         s.storyLongitude.value = place.geometry.location.lng();
       });

       // Sets a listener on a radio button to change the filter type on Places
       // Autocomplete.
       function setupClickListener(id, types) {
         var radioButton = document.getElementById(id);
         radioButton.addEventListener('click', function() {
           autocomplete.setTypes(types);
         });
       }
       setupClickListener('changetype-all', []);
       setupClickListener('changetype-address', ['address']);
       setupClickListener('changetype-establishment', ['establishment']);
       setupClickListener('changetype-geocode', ['geocode']);
     }
    

    
    $( function() {
       $('#storyTripDate').datepicker({
          dateFormat: "yy/mm/dd",
          dayNamesMin:['일','월','화','수','목','금','토'],
          monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
       });//datepicker
  });      