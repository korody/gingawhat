$('#send-mail').button();

$('#send-mail').click(function() {
  var $this = $(this);
  $this.button('loading');
  $this.addClass('active');
  // setTimeout(function() {
  //   $this.removeClass('active');
  //   $this.button('complete');
  // }, 2000);
});
