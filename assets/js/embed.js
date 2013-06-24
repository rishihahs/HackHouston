(function(window) {
  
  var ids = [];

  showEmbed();
  handler.addHandler(showEmbed);

  function showEmbed() {
    $('#embed .link').click(function() {
      $('#embed .des').slideToggle('fast');
      
      $('html, body').animate({
        scrollTop: $("#embed").offset().top - 60
      }, 600);
      
      if ($('#fees').hasClass('show-embed')) {
        $('.fee .embed-bar').remove();
        $('#fees').removeClass('show-embed');
      } else {
        $('.fee .rating').after('<span class="label label-success embed-bar"><span>Embed</span> <input type="checkbox"></span>');
        $('.fee .embed-bar').hide().show(0);
        checkboxClick();
        $('#fees').addClass('show-embed');
      }
    });
  };
  
  function checkboxClick() {
    $('.embed-bar input[type="checkbox"]').click(function() {
      if ($(this).is(':checked')) {
        ids.push($(this).parent().siblings('.id').text());
      } else {
        var text = $(this).parent().siblings('.id').text();
        ids.splice(ids.indexOf(text), 1);
      }
      
      calculateURL();
      
      return true;
    });
  }
  
  function calculateURL() {
    var url = window.city_config['api url'] + '/get/id?';
    for (var x = 0, l = ids.length; x < l; x++) {
      url += ((x === 0) ? 'id[]=' : '&id[]=') + ids[x];
    }
    
    $('#embed textarea').text(url);
  }
  
})(this);