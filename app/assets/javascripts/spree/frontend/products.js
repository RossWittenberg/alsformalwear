$(document).ready(function(){

  var selectBox = $("select.select-color");

  selectBox.on('change', function(){
    var newSrc = ($(this).val());

    var opt = $(this).find("option[value='"+newSrc+"']") //get correct option
    var newData = (opt[0].dataset.variant); //get correct option variant
    var byt = (opt[0].dataset.byt); //get true/false for byt image
    var newAlt = $(this).find($('option:selected')).data('alt');

    //change featured image
    $('div.main-image img').attr('src', newSrc);
    //change image alt
    $('div.main-image img').attr('alt', newAlt);
    //change data-variant field
    $('div.byt-option-wrapper button').attr('data-variant', newData);
    //if byt field is false, hide BYT section
    if (byt !== 'true') {
      $('div.byt-option-wrapper').addClass('hidden');
    } else {
      $('div.byt-option-wrapper').removeClass('hidden');
    }

  });

  $('.filter-button').click(function(){
    $('body').animate({
      scrollTop: 0
    });
  });

  $('.mobile-product-list-item').click(function(){
    $(this).find('.showbox').removeClass('hidden');
  });

  $('.catalog-button.add-to-tux-button.no-modal-button').click(function(){
    $(this).closest('.mobile-product-list-item').find('.showbox').removeClass('hidden');
  });
  
});