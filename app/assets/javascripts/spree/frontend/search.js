$(document).ready(function() {
  // preventKeySubmitOnSearch();
  console.log("search loaded")
  $('#keyword-search').autocomplete({
    source: function (request, response ){
      var params = {'format': 'json','search': { 'keyword': request.term }};
      $.ajax({
        type: 'get',
        url: '/catalog/byt/keyword_search',
        data: params,
        success: function(data){
          console.log(data);
          response(data.variants)
        },
        error: function(data){
        }
      });
    },
    minLength: 3
  }).autocomplete( "instance" )._renderItem = function( ul, variant ) {
    return $( "<li>" )
      .data( "variant.autocomplete", variant )
      .addClass('product-autocomplete')  
      .append($('<a>')
      .attr('href', '/catalog/products/'+variant.slug+'?variant_id='+variant.variant_id)
      .prepend($('<p>').css({'width' : '100%', 'margin' : '0'})
      .text(variant.product_name + "-" + variant.designer )
      .css('text-transform', 'capitalize') 
      .prepend($('<img>').attr('src', variant.image_url_mini) ) ) )
      .appendTo( ul );
  };

  $('form.keyword-search-form').submit(function(event) {
    var searchTerm = $(this).find('input').val()
    if( searchTerm.length > 2 ){
      event.preventDefault();
      window.location.replace("/catalog/products?keyword="+searchTerm)
    }
  });

  $('form.mobile-keyword-search-form').submit(function(event) {
    var searchTerm = $(this).find('input').val()
    if( searchTerm.length > 2 ){
      event.preventDefault();
      window.location.replace("/catalog/products?keyword="+searchTerm)
    }
  });
  $('#search').autocomplete({
    source: function (request, response ){
      var params = {'format': 'json','search': { 'keyword': request.term }};
      $.ajax({
        type: 'get',
        url: '/catalog/byt/keyword_search',
        data: params,
        success: function(data){
          console.log(data);
          response(data.variants)
        },
        error: function(data){
        }
      });
    },
    minLength: 3
  }).autocomplete( "instance" )._renderItem = function( ul, variant ) {
    // preventKeySubmit();
    return $( "<li>" )
      .data( "variant.autocomplete", variant )
      .addClass('product-autocomplete')  
      .append($('<a>')
      .attr('href', '/catalog/products/'+variant.slug+'?variant_id='+variant.variant_id)
      .prepend($('<p>').css({'width' : '100%', 'margin' : '0'})
      .text(variant.product_name + "-" + variant.designer )
      .css('text-transform', 'capitalize') 
      .prepend($('<img>').attr('src', variant.image_url_mini) ) ) )
      .appendTo( ul );
  };

  $('#high_school_search_prom').autocomplete({
    source: function (request, response ){
      var params = {'format': 'json','search': { 'query': request.term }};
      $.ajax({
        type: 'get',
        url: '/events/high_schools',
        data: params,
        success: function(data){
          console.log(data);
          response(data.high_schools)
        },
        error: function(data){
        }
      });
    },
    minLength: 3,
    autoFocus: true,
    select: function(event, ui) {
      $('#high_school_search_prom').val(ui.item.name);
      updateAddress(ui.item);
      return false;
    }
  }).autocomplete( "instance" )._renderItem = function( ul, high_school ) {
    preventKeySubmitOnSearch();
    ul.addClass('high-school');
    console.log("hs autocomplete")
    return $( "<li>" )
      .data( "high_school.autocomplete", high_school )
      .addClass('high-school-autocomplete')  
      .append($('<a>'))
      .prepend($('<p>').css({'width' : '100%', 'margin' : '0'}))
      .text(high_school.name + " - " + high_school.city)
      .css('text-transform', 'capitalize') 
      .appendTo( ul );
  };

  $('#high_school_search_fundraiser').autocomplete({
    source: function (request, response ){
      var params = {'format': 'json','search': { 'query': request.term }};
      $.ajax({
        type: 'get',
        url: '/events/high_schools',
        data: params,
        success: function(data){
          console.log(data);
          response(data.high_schools)
        },
        error: function(data){
        }
      });
    },
    minLength: 3,
    autoFocus: true,
    select: function(event, ui) {
      $('#high_school_search_fundraiser').val(ui.item.name);
      updateAddress(ui.item);
      return false;
    }
  }).autocomplete( "instance" )._renderItem = function( ul, high_school ) {
    preventKeySubmitOnSearch();
    ul.addClass('high-school');
    console.log("hs autocomplete")
    return $( "<li>" )
      .data( "high_school.autocomplete", high_school )
      .addClass('high-school-autocomplete')  
      .append($('<a>'))
      .prepend($('<p>').css({'width' : '100%', 'margin' : '0'}))
      .text(high_school.name + " - " + high_school.city)
      .css('text-transform', 'capitalize') 
      .appendTo( ul );
  };

})

function updateAddress(hs) {
  var address = $('#event_street_address');
  var city = $("#event_school_city,#event_city");
  var state = $("#event_school_state,#event_state");
  var zipCode = $("#event_school_zip_code,#event_zip_code");
  address.val(hs.street_address)
  city.val(hs.city);
  zipCode.val(hs.zip_code);
  state.find("option[value='"+hs.state+"']").attr('selected', 'selected').change();
}



function preventKeySubmitOnSearch(){
  $(document).on("keypress", 'form', function (e) {
    var code = e.keyCode || e.which;
    if (code == 13 && $(this).find('input').val().length < 3 ) {
        e.preventDefault();
        return false;
    }
  });
}








// (function( $ ) {

//   $.ui.autocomplete.prototype.options.autoSelect = true;
//   $( ".ui-autocomplete-input" ).live( "blur", function( event ) {
//       var autocomplete = $( this ).data( "autocomplete" );
//       if ( !autocomplete.options.autoSelect || autocomplete.selectedItem ) { return; }

//       var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" );
//       autocomplete.widget().children( ".ui-menu-item" ).each(function() {
//           var item = $( this ).data( "uiAutocompleteItem" );
//           if ( matcher.test( item.label || item.value || item ) ) {
//               autocomplete.selectedItem = item;
//               return false;
//           }
//       });
//       if ( autocomplete.selectedItem ) {
//           autocomplete._trigger( "select", event, { item: autocomplete.selectedItem } );
//       }
//   });

// }( jQuery ));










