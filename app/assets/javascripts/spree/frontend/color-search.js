var COLOR_SEARCH = {
  addListeners: function() {
    $('.color-search').autocomplete({
    source: function (request, response ){
      var params = {'format': 'json','search': { 'color': request.term }};
      $.ajax({
        type: 'get',
        url: '/catalog/byt/search_colors',
        data: params,
        success: function(data){
          console.log(data);
          response(data)
        },
        error: function(data){
        }
      });
    },
    minLength: 3,
    'open': function( e, ui ) {
      $('.ui-autocomplete').css({
        maxWidth: '170px',
        border: '0',
      });
    },
    select: function(e, ui ) {
      console.log(ui.item.name)
    }
    }).autocomplete( "instance" )._renderItem = COLOR_SEARCH.renderItem;

  },
  renderItem: function(ul, data){
    var color;
    var searchColor;
    if ( data.parent != null ){
      searchColor = data.parent.name;
      color = data.colors[0];
    } else {
      searchColor = data.name;
      color = data;
    }
    ul.css('zIndex', '999');
    return $( "<a>" )
      .attr('href', '/catalog/products?keyword='+searchColor)
      .css( { margin: '10px 0', cursor: 'pointer', height: '30px', 'display': 'block' }  )
      .data( "color.autocomplete", color )
      .addClass('color-search-autocomplete')
      .prepend( $('<div>').css({ display: 'inline-block', height: '30px', width: '30px', backgroundColor: color.hex })
        .addClass('color-filter-square child-color-filter-square')
        .attr('data-color-label', color.name)
        .append( $('<p>')
          .attr('href', '/catalog/products?keyword='+color.name)
          .text(color.name.replace("_", " ") )
          .css({ textTransform: 'capitalize', lineHeight: '30px', marginLeft: '40px', fontSize: '10px', width: '150px' })  
        )  
      )
    .appendTo( ul )
  }  
};

$(document).ready(function() {
	console.log("color search loaded");
	COLOR_SEARCH.addListeners();
});




