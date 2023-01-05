ymaps.ready(init);

function init() {
  var myMap = new ymaps.Map('map', {
    center: [55.753994, 37.622093],
    zoom: 7
  });

  var address = document.getElementById('map').getAttribute('data-address');

  ymaps.geocode(address, {
    results: 1
  }).then(function (res) {

    var firstGeoObject = res.geoObjects.get(0),
      coords = firstGeoObject.geometry.getCoordinates(),
      bounds = firstGeoObject.properties.get('boundedBy');

    firstGeoObject.options.set('preset', 'islands#darkBlueDotIconWithCaption');

    firstGeoObject.properties.set('iconCaption', firstGeoObject.getAddressLine());

    myMap.geoObjects.add(firstGeoObject);

    myMap.setBounds(bounds, {
      checkZoomRange: true
    });
  });
}
