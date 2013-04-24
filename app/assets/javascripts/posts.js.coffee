#jQuery ->
#  if $('.pagination').length
#    $(window).scroll ->
#      url = $('.pagination a:last').attr('href')
#      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
#        $('.pagination').html('<p class= "center lead">Quem quer mais, dá um grito aí!</p>')
#        $.getScript(url)
#    $(window).scroll()