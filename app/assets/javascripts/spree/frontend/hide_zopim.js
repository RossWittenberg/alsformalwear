$(window).bind("load", function() {
  var productsUrl = String(window.location.href);
  console.log(productsUrl);

  if ( ( /catalog\/products/i.test(productsUrl) || /catalog\/byt/i.test(productsUrl) ) && ( $(window).width() < 991 ) ) {
    $('div.zopim').hide();
  }
});