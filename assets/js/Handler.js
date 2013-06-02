function _Handler() {
  this.handlers = [];
}

_Handler.prototype = {
  
  initAll: function() {
    for (var x = 0; x < this.handlers.length; x++) {
      this.handlers[x]();
    }
  },
  
  addHandler: function(handler) {
    this.handlers.push(handler);
  }
  
}

_Handler.removeAll = function() {
  $(document).add('*').off();
}

var handler = new _Handler();