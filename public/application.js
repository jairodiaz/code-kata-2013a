function toggle_favourite(id, checkbox) {
  var favourite = document.getElementById(id);
  var name = favourite.getAttribute('data-name');
  var location = favourite.getAttribute('data-location');
  var url = favourite.getAttribute('data-url');
  var saved = checkbox.checked;
  var data = { "venue_id": id, "name": name, "favourite": saved, "canonical_url": url, "location": location };
  if (saved) {
    $.post('/favourite', data);
  } else {
    $.ajax({url: '/favourite', type: 'DELETE', data: data});
  }
}
