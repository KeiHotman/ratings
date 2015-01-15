$(document).on 'click', '.rating .score a', ->
  score = parseInt($(this).attr('score'))
  $.ajax
    type: 'POST'
    url: '/items/' + $(this).attr('item_id') + '/rating'
    data:
      score: score
    dataType: 'script'
    success: ->
      console.log('succes')
  false

# mouseover stars to be rating on courses#show
$(document).on 'mouseenter', '.rating .score', ->
  $(this).find('img').addClass('star')
  $(this).find('img').removeClass('star_empty')

  $(this).prevAll().find('img').addClass('star')
  $(this).prevAll().find('img').removeClass('star_empty')

  $(this).nextAll().find('img').addClass('star_empty')
  $(this).nextAll().find('img').removeClass('star')

$(document).on 'mouseleave', '.rating .score', ->
  $('.rating .score').not('.persisted').find('img').addClass('star_empty')
  $('.rating .score').not('.persisted').find('img').removeClass('star')

  $('.rating .score.persisted').find('img').addClass('star')
  $('.rating .score.persisted').find('img').removeClass('star_empty')
