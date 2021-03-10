import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'


const initMapbox = () => {
  const params = document.querySelector(".show-page-map");

  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '15px';

    if (params) {
      new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);

    } else {
      new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup) // add this
      .addTo(map);

    }
    });
  };

  const directions = new MapboxDirections({
    accessToken: process.env.MAPBOX_API_KEY,
    unit: 'imperial',
    profile: 'mapbox/walking'
  });

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    fitMapToMarkers(map, markers);
    addMarkersToMap(map, markers);
    // map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    //                                  mapboxgl: mapboxgl }));
    map.addControl(new mapboxgl.NavigationControl());
    if (document.querySelector('.direction-map')) {
      map.addControl(directions, 'top-left');
    };
  }
};

const initGeocoder = () => {
  const geocoder = new MapboxGeocoder({
    accessToken: process.env.MAPBOX_API_KEY,
    types: 'country,region,place,postcode,locality,neighborhood'
    });
    const geocoderDiv = document.getElementById('geocoder')
      if ( geocoderDiv && geocoderDiv.childElementCount === 1 ) {
        geocoderDiv.removeChild(geocoderDiv.firstChild)
      }
      geocoder.addTo('#geocoder');
      geocoder.on('result', (result) => {
        const hiddenField = document.getElementById( 'geocoder-query' )
        hiddenField.value = JSON.stringify( { coordinates: result.result.center, name: result.result.place_name } )
       })
};

export { initMapbox, initGeocoder };

// if (mapElement) {
//   // [ ... ]
//   const markers = JSON.parse(mapElement.dataset.markers);
//   markers.forEach((marker) => {
//     new mapboxgl.Marker()
//       .setLngLat([ marker.lng, marker.lat ])
//       .addTo(map);
//   });
// }

