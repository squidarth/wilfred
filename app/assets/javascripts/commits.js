$(function() {
  bindElements(); 
  
  function bindElements() {
    $(".js-commit-action").on('click', function(ev) {
      ev.preventDefault(); 
      $.ajax({
         type: "POST"
       , dataType: "json"
       , url: $(this).attr('href')
      }).done(function(response) {
        $(".yield").html(response.html); 
        bindElements();
      });

      return false;
    });
  }
});
