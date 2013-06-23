$.getScript(window.city_config['api url'] + '/get/all?hash=' + hashData() + '&callback=jsonpCallback', function(){
  $('#fees').html(''); // clear old data
  _Handler.removeAll(); // clear old handlers
  handler.initAll();
  window.fee_filter = create_filter(master_fees);
  $.waypoints('refresh');
});

function jsonpCallback(object) {
  if (!object) {
    master_fees = getFees();
    return;
  }

  master_fees = object;
  storeFees(object);
}

function hashData() {
  var data = getFees();
  if (!data) {
    return null;
  }

  return md5(JSON.stringify(data));
}

function storeFees(fees) {
  $.jStorage.set('fees_data', fees);
}

function getFees() {
  return $.jStorage.get('fees_data');
}
