(function(window) { 
  'use strict';
  
  $('#fees').waypoint(loadMoreFees, { offset: 'bottom-in-view' });
  
  function loadMoreFees() {
    var lastNum = $('.fee').length;
    
    if (!lastNum) {
      return;
    }
    
    $(this).waypoint('disable');
    
    var obj = [];
    for (var i = lastNum, n = 0, l = window.city_config['block size'] + lastNum; i < l; i++, n++) {
      if (i >= window.fee_filter.getOutput().length) {
        break;
      }
      
      obj[n] = window.fee_filter.getOutput()[i];
    }
    
    window.fee_filter.render(obj);
    $(this).waypoint('enable');
  }
  
})(this);