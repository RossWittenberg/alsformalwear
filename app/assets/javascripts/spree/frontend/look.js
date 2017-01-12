// //index
// $.ajax({
//   url: '/catalog/byt',
//   data: {'format': 'json', 
//          'search': { 
//            'parent-color':'blues' 
//           }
//         },
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }  
// });
//products index with taxonomy
// $.ajax({
//   url: '/catalog/t/product-categories/tuxedos',
//   data: {
//       'format': 'json',
//       'search': {
//         'parent-color':'blues'
//         }
//   },
//   dataType: 'json',
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }  
// });

// //show look
// $.ajax({
//   url: '/catalog/byt/1',
//   data: {'format': 'json'},
//   success: function(data){
//     console.log(data)
//   },
//   failure: function(data){
//     console.log(data)
//   }  
// });
// // show product for modal
// $.ajax({
//   url: '/catalog/byt/show_variant',
//   // data: {'format':'json', 'variant_id': 800},
//   success: function(data){
//     debugger;
//     console.log(data)
//   },
//   failure: function(data){
//     console.log(data)
//   }  
// });

// // show look
// function testLooks(){
//     $.ajax({
//         url: '/catalog/byt/1',
//         data: {'format': 'json'},
//         success: function(data){
//             console.log(data)
//         },
//         failure: function(data){
//             console.log(data)
//         }
//     });
// show product for modal
//     $.ajax({
//         url: '/catalog/byt/show_variant',
//         // data: {'format':'json', 'variant_id': 800},
//         success: function(data){
//             debugger;
//             console.log(data)
//         },
//         failure: function(data){
//             console.log(data)
//         }
//     });
// }

// // create
// $.ajax({
//   url: '/catalog/byt',
//   type: 'POST',
//   data: { 'format': 'json', 
//           'products': {
//             'tuxedo': {
//               'id': 16, 'variant_id': 3 
//             },
//             'tie': {
//               'id': 14, 'variant_id': 2 
//             }  
//           }  
//         },
//   dataType: "json",
//   success: function(data){
//   	console.log(data);
//   },
//   failure: function(data){
//   	console.log(data);
//   }
// });

// // update
// $.ajax({
//   url: '/catalog/byt/1',
//   type: 'PUT',
//   data: {'format': 'json', 'products': {'tuxedo': {'id': 16, 'variant_id': 3 } },
//           'products': {
//             'tuxedo': {
//               'id': 16, 'variant_id': 3 
//             } 
//           }  
//         },
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });

// // clone
// $.ajax({
//   url: '/catalog/byt/clone',
//   type: 'POST',
//   data: { 'format': 'json', 
//           'look_id': 1 
//         },
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });

// // colors
// $.ajax({
//   url: '/catalog/byt/colors',
//   type: 'GET',
//   data: { 'format': 'json' },
//   dataType: "json",
//   success: function(data){
//     debugger;
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });

// // filters - all parent colors
// $.ajax({
//   url: '/catalog/byt/filters_by_taxon',
//   type: 'GET',
//   data: { 'format': 'json', 'taxon_id' : 8 },
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });

// // filters with parent color specified
// $.ajax({
//   url: '/catalog/byt/filters_by_taxon',
//   type: 'GET',
//   data: { 'format': 'json', 'taxon_id' : 8, 'search':{'parent-color': 'reds'} },
//   dataType: "json",
//   success: function(data){
//     console.log(data);
//   },
//   failure: function(data){
//     console.log(data);
//   }
// });


