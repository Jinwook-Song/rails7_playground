document.addEventListener('turbo:load', function () {
  const checkbox = document.getElementById('toggleGeolocation');
  const geoInfo = document.getElementById('geolocationInfo');

  // Check if elements exist before attempting to manipulate them
  if (checkbox && geoInfo) {
    // Initial state: show geolocation
    geoInfo.style.display = 'block';

    checkbox.addEventListener('change', function () {
      if (checkbox.checked) {
        geoInfo.style.display = 'block';
      } else {
        geoInfo.style.display = 'none';
      }
    });
  }
});
