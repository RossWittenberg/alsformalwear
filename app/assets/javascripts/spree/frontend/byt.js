window.step1CategoriesList = {
    coatandpants: 'COAT & PANTS',
    vestsorcummerbunds: 'VEST OR CUMMERBUND',
    shirt: 'SHIRT',
    tie: 'TIE',
    shoesandsocks: 'SHOES',
    studsandlinks: 'STUDS AND LINKS'
};

window.productCategoriesList = {
    'tuxedos': 'Tuxedo',
    'suits': 'Suit',
    'cummerbunds': 'Cummerbund',
    'vests': 'Vest',
    'shirts': 'Shirt',
    'ties': 'Tie',
    'shoes': 'Shoe',
    'studs-and-links': 'Studs & Links'
};

var ProductModel = Backbone.Model.extend({
    defaults: {
        product_id: null,
        variant_id: null,
        product_name: null,
        designer: null,
        child_color: null,
        parent_color: null
    }
});

var ProductCategoryModel = Backbone.Model.extend({
    defaults: {
        slug: null,
        displayName: null
    }
});

var Step1CategoryModel = Backbone.Model.extend({
    defaults: {
        slug: null,
        displayName: null,
        type: null,
        selected: null
    }
});

var TuxCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/tuxedos',
    model: ProductModel,
    totalRecords: 0,
    slug: 'tuxedos',
    'taxon_id': 8,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var SuitCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/suits',
    model: ProductModel,
    totalRecords: 0,
    slug: 'suits',
    'taxon_id': 10,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var VestCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/vests',
    model: ProductModel,
    totalRecords: 0,
    slug: 'vests',
    'taxon_id': 13,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var CummerbundCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/cummerbunds',
    model: ProductModel,
    totalRecords: 0,
    slug: 'cummerbunds',
    'taxon_id': 14,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var ShirtCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/shirts',
    model: ProductModel,
    totalRecords: 0,
    slug: 'shirts',
    'taxon_id': 15,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var TiesCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/ties',
    model: ProductModel,
    totalRecords: 0,
    slug: 'ties',
    'taxon_id': 16,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var ShoesCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/shoes',
    model: ProductModel,
    totalRecords: 0,
    slug: 'shoes',
    'taxon_id': 17,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var StudsCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/studs-and-links',
    model: ProductModel,
    totalRecords: 0,
    slug: 'studs-and-links',
    'taxon_id': 19,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var CoatAndPantsCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/coat-and-pants',
    model: ProductModel,
    totalRecords: 0,
    slug: 'coatandpants',
    'taxon_id': 139,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var VestOrCummerbundCollection = Backbone.Collection.extend({
    url: '/catalog/t/product-categories/vests-or-cummerbunds',
    model: ProductModel,
    totalRecords: 0,
    slug: 'vestsorcummerbunds',
    'taxon_id': 141,
    filters: [],
    parse: function(data){
        this.totalRecords = data.meta['total_records'];
        updateSelectedCategoryResultCount(data.meta['total_records']);
        return data.variants;
    }
});

var ProductCategoryCollection = Backbone.Collection.extend({
    model: ProductCategoryModel,
    initialize: function(){
        var categoriesList = {
            'tuxedos': 'Tuxedos',
            'suits': 'Suits',
            'vests': 'Vests',
            'cummerbunds': 'Cummerbunds',
            'shirts': 'Shirts',
            'ties': 'Ties',
            'shoes': 'Shoes',
            'studs-and-links': 'Studs & Links',
        };

        _.each(categoriesList, function(val, key){
            var category = new ProductCategoryModel();
            category.set('slug', key);
            category.set('displayName', val);
            this.add(category);
        }, this);
    }
});

var Step1CategoryCollection = Backbone.Collection.extend({
    model: Step1CategoryModel,
    initialize: function(){
        _.each(window.step1CategoriesList, function(val, key){
            var category = new Step1CategoryModel();
            category.set('slug', key);
            category.set('displayName', val);
            this.add(category);
        }, this);
    }
});

var Step1CategoryView = Backbone.View.extend({
    tagName: 'div',
    className: 'row step1-category-container',
    initialize: function(){
        this.template = _.template($('#byt-step1-category-template').html());
        this.mobileTemplate = _.template($('#byt-step1-category-mobile-template').html());
        this.model.on('change:selected', function(model){
            this.render();
            if(model.get('selected') != null){
                $('#' + model.get('slug')).html('<img src="' + model.get('selected').get('image_url_byt') +'">');
                if(model.get('slug') === 'coatandpants'){
                    $('#pants').html(
                        $('<img />').load( function(){
                            $('#mannequin-pant-image').hide();
                        }).attr('src', model.get('selected').get('image_url_secondary_byt'))
                    );
                }
            } else {
                $('#' + model.get('slug')).html('');
                if(model.get('slug') === 'coatandpants'){
                    $('#pants').html('');
                    $('#mannequin-pant-image').show();
                }
            }
            if(document.documentElement.clientWidth < 768){
                smoothScroll(90);
            } else {
                smoothScroll(220);
            }
        }, this);
    },
    events: {
        'click .step1-category-link-empty': 'showProducts',
        'click .step1-category-link-selected': 'removeProduct',
        'click .mobile-category-image': 'showProducts'
    },
    render: function(){
        if(document.documentElement.clientWidth < 768){
            this.$el.html(this.mobileTemplate(this.model.toJSON()));
        } else {
            this.$el.html(this.template(this.model.toJSON()));
        }
        return this;
    },
    showProducts: function(evt){
        window.collection = null;
        switch(this.model.get('slug')){
            case 'coatandpants':
                window.collection = new CoatAndPantsCollection();
                break;
            case 'vestsorcummerbunds':
                window.collection = new VestOrCummerbundCollection();
                break;
            case 'shirt':
                window.collection = new ShirtCollection();
                break;
            case 'tie':
                window.collection = new TiesCollection();
                break;
            case 'shoesandsocks':
                window.collection = new ShoesCollection();
                break;
            case 'studsandlinks':
                window.collection = new StudsCollection();
                break;
        }
        updateSelectedCategoryTopLabel(window.step1CategoriesList[this.model.get('slug')]);
        showLoader();
        window.collection.fetch().then(
            function(){
                if(document.documentElement.clientWidth < 768){
                    renderProducts().then(function(){
                        smoothScroll($('#byt-products-container').offset().top - 40);
                    });
                } else {
                    renderProducts();
                    smoothScroll($('#byt-products-container').offset().top - 160);
                }
            },
            handleFetchError
        )
    },
    removeProduct: function(){
        this.model.set('selected', null);
    }
});

var Step1CategoryCollectionView = Backbone.View.extend({
    el: '#step1-container',
    events: {
        'click #byt-start-over-link' : 'startOver'
    },
    render: function(){
        var self = this;
        this.collection.each(function(model){
            var step1Category = new Step1CategoryView({model: model});
            self.$('#step1-categories-parent-container').append(step1Category.render().$el);
        });
    },
    startOver: function(){
        this.collection.each(function(model){
            model.set('selected', null);
        });
    }
});

var ProductView = Backbone.View.extend({
    tagName: 'li',
    className: 'col-lg-4 col-md-4 col-sm-6',
    initialize: function(){
        this.template = _.template($('#byt-product-template').html()),
        this.mobileTemplate = _.template($('#byt-product-mobile-template').html()),
        this.productInfoTemplate = _.template($('#byt-product-information-modal-template').html())
    },
    events: {
        'click .add-to-tux-button': 'onClickAddToTux',
        'click .product-details-button': 'onClickProductDetails',
        'click .product-list-item': 'onClickProductDetails'
    },
    onClickAddToTux: function(evt){
        addToTux(this.model.collection.slug, this.model);
    },
    onClickProductDetails: function(evt){
        var self = this;
        getProductVariantDetails(self.model.get('variant_id')).then(
            function(response){
                $('body').append(self.productInfoTemplate(response.variant))
                $('#byt-product-information-modal').modal();
                $('#byt-product-information-modal').on('hidden.bs.modal', function (e) {
                    $('#byt-product-information-modal').remove();
                });
                $('#byt-modal-add-to-tux-button').on('click', function(){
                    $('#byt-product-information-modal').modal('hide');
                    self.onClickAddToTux();
                });
                $('#byt-product-information-modal-close-button').on('click', function(){
                    $('#byt-product-information-modal').modal('hide');
                });
            });
            handleFetchError
    },
    render: function(){
        var self = this;
        if(document.documentElement.clientWidth < 768){
            this.$el.html(this.mobileTemplate(this.model.toJSON()));
            this.$el.addClass('mobile-product-list-item').addClass('no-side-padding');
        } else {
            this.$el.html(this.template(this.model.toJSON()));
            this.$el.addClass('product-list-item').addClass('no-pad-right');
        }
        var id = 'product-list-item-' + this.model.get('variant_id');
        this.$el.attr('id', id);
        $('body').on('click', '#' + id + ' .active-product-info', function(event){
            if(!$(event.target).hasClass('no-modal-button')){
                self.onClickProductDetails();
            }
        });
        return this;
    }
});

var ProductCollectionView = Backbone.View.extend({
    el: '#byt-products-container',
    render: function(){
        var self = this;
        var $collection = this.$('#products').empty();
        this.collection.each(function(model){
            this.addProductToCollection($collection, model);
        }, this);
        this.addHoverEffectToProducts();
        this.checkIfMoreProductsAvailable();
        return this;
    },
    addProductToCollection: function($collection, model){
        var product = new ProductView({model: model});
        $collection.append(product.render().$el);
    },
    addHoverEffectToProducts: function(){
        if(document.documentElement.clientWidth >= 768){
            this.$('.product-list-item').hover(
                function() {
                    $(this).find('.passive-product-info-overlay').fadeOut(300);
                    $(this).find('.passive-product-info').fadeOut(300);
                    $(this).find('.active-product-info').fadeIn(300);
                    $(this).find('.active-product-info-overlay').fadeIn(300);
                },
                function() {
                    $(this).find('.passive-product-info-overlay').fadeIn(300);
                    $(this).find('.passive-product-info').fadeIn(300);
                    $(this).find('.active-product-info').fadeOut(300);
                    $(this).find('.active-product-info-overlay').fadeOut(300);
                }
            );
        }
        FAVORITES.addListeners();
        FAVORITES.getUserFavorites(); 
    },
    checkIfMoreProductsAvailable: function(){
        var self = this;
        var totalRecords = this.collection.totalRecords;
        var currentRecords = this.collection.length;
        if(totalRecords > currentRecords){
            this.$('#load-more-products-button').removeAttr('disabled');
        } else {
            this.$('#load-more-products-button').attr('disabled','disabled');
        }
        $('#load-more-products-button').on('click', function(){
            self.loadMoreProducts();
        });
    },
    productsPerPage: 12,
    loadMoreProducts: function(){
        var baseurl = this.collection.url;
        var currentRecords = this.collection.length;
        var nextPageNumber = (currentRecords / this.productsPerPage) + 1;
        var self = this;
        var searchHash = {};
        _.each(window.collection.filters, function(filterCategory){
            _.each(filterCategory.choices, function(filterChoice){
                if(filterChoice.selected === true){
                    if(typeof searchHash[filterCategory.slug] === 'undefined'){
                        searchHash[filterCategory.slug] = [];
                    }
                    searchHash[filterCategory.slug].push(filterChoice.slug);
                }
            });
        });

        $.ajax({
            type: 'GET',
            url: baseurl,
            data: {
                'format': 'json',
                'search': searchHash,
                'page': nextPageNumber
            },
            dataType: 'json'
        }).then(
            function(response){
                var $collection = self.$('#products');
                _.each(response.variants, function(val){
                    var model = new self.collection.model(val);
                    self.collection.add(model);
                    self.addProductToCollection($collection, model);
                });
                self.addHoverEffectToProducts();
                $('#load-more-products-button').off();
                $('#load-more-products-button').attr('loading-in-progress', 'false');
                $('#load-more-products-loader-container').empty();
                self.checkIfMoreProductsAvailable();
            },
            handleFetchError
        );
    }
});

var ProductCategoryView = Backbone.View.extend({
    tagName: 'li',
    className: 'product-category',
    initialize: function(){
        this.template = _.template($('#byt-product-category-template').html());


    },
    events: {
        'click' : 'onProductCategoryClick'
    },
    render: function(){
        this.$el.html(this.template(this.model.toJSON()));
        return this;
    },
    fetchProducts: function(productCategory){
        var self = this;
        window.collection = null;
        switch(productCategory){
            case 'tuxedos':
                window.collection = new TuxCollection();
                break;
            case 'suits':
                window.collection = new SuitCollection();
                break;
            case 'vests':
                window.collection = new VestCollection();
                break;
            case 'cummerbunds':
                window.collection = new CummerbundCollection();
                break;
            case 'shirts':
                window.collection = new ShirtCollection();
                break;
            case 'ties':
                window.collection = new TiesCollection();
                break;
            case 'shoes':
                window.collection = new ShoesCollection();
                break;
            case 'studs-and-links':
                window.collection = new StudsCollection();
                break;
        }
        updateSelectedCategoryTopLabel(window.productCategoriesList[productCategory]);
        showLoader();
        window.collection.fetch().then(
            renderProducts,
            self.handleFetchError
        );

    },

    handleFetchError: function(response){
        console.log(response);
    },

    onProductCategoryClick: function(evt){
        $('#selected-parent-color-block-container').html('');
        $('#selected-parent-color-block-container').css({
            'background-color': '#ffffff',
            'display': 'none',
        });
        $('#selected-child-color-block-container').html('');
        $('#selected-child-color-block-container').css({
            'background-color': '#ffffff',
            'display': 'none',
        });
        this.fetchProducts(this.model.get('slug'))
    }
});

var ProductCategoryCollectionView = Backbone.View.extend({
    el: '#product-categories-container',
    render: function(){
        this.collection.each(function(model){
            var productCategoryView = new ProductCategoryView({model: model});
            this.$el.append(productCategoryView.render().$el);
        }, this);
    }
});

function smoothScroll(scrollTop){
    $('html, body').animate({
        scrollTop: scrollTop
    }, 500);
}

function getLook(look_id){
    $.ajax({
        url: '/catalog/byt/' + look_id,
        data: {
            'format': 'json'
        },
        success: function(data){
            var products = data.look.products;
            _.each(products, function(variantId, step1Slug){
                getProductVariantDetails(variantId).then(
                    function(response){
                        var productModel = new ProductModel(response.variant);
                        addToTux(step1Slug, productModel);
                    }
                )
            })
        },
        failure: function(data){
            console.log(data)
        }
    });
}

function saveLook(dataHash, followRedirect){
    return $.ajax({
        url: '/catalog/byt',
        type: 'POST',
        data: dataHash,
        dataType: "json",
        success: function(data){
            if(data.success === true){
                if(followRedirect && data.redirect !== null){
                    window.location.href = data.redirect;
                }
            } else {
                console.log(data);
            }
        },
        error: function(data){
            console.log(data);
        }
    });
}

function updateLook(dataHash){
    var look_id = $.urlParam('look_id');
    $.ajax({
        url: '/catalog/byt/' + look_id,
        type: 'PUT',
        data: dataHash,
        dataType: "json",
        success: function(data){
            if(data.success === true){
                if(data.redirect !== null){
                    window.location.href = data.redirect;
                }
            } else {
                console.log(data);
            }
        },
        error: function(data){
            console.log(data);
        }
    });
}

function getAllColors(){
    window.allColors = [];
    return $.ajax({
        url: '/catalog/byt/colors',
        type: 'GET',
        data: {
            'format': 'json'
        },
        dataType: "json",
        success: function(response){
            _.each(response.colors, function(val, key){
                var color = {
                    displayName: key,
                    slug: key,
                    hex: val['parent_hex'],
                    border: val['border'],
                    type: 'parent',
                    children: []
                };
                _.each(val['children_colors'], function(hex, slug){
                    color['children'].push({
                        displayName: slug,
                        slug: slug,
                        hex: hex,
                        border: color.border,
                        type: 'child',
                    })
                });
                window.allColors.push(color)
            });
        },
        failure: function(data){
            console.log(data);
        }
    });
}

function fetchFilters(){
    window.collection.filters = [];
    return $.ajax({
        url: '/catalog/byt/filters_by_taxon',
        type: 'GET',
        data: { 'format': 'json', 'taxon_id' : window.collection['taxon_id'] },
        dataType: "json",
        success: function(data){
            _.each(data.filters, function(val){
                var filter = {
                    slug: val.class,
                    displayName: val.name,
                    choices: []
                };
                _.each(val.labels, function(val, key){
                    filter.choices.push({
                        slug: val[1],
                        displayName: val[0],
                        selected: false,
                        border: 'none'
                    });
                });
                window.collection.filters.push(filter);
            });
        },
        failure: function(data){
            console.log(data);
        }
    });
}

function renderProducts(refreshFilters){
    if(typeof refreshFilters === 'undefined'){
        refreshFilters = true;
    }
    if(refreshFilters){
        removeChildColor();
        removeParentColor();
        $('#filter-categories-container').html('');
    }
    $('#load-more-products-button').off();
    window.productCollectionView = new ProductCollectionView({collection: window.collection});
    window.productCollectionView.render();
    if(refreshFilters){
        return fetchFilters().then(renderFilters)
    }
}

function fetchFilteredProducts(){
    var searchHash = {};
    _.each(window.collection.filters, function(filterCategory){
        _.each(filterCategory.choices, function(filterChoice){
            if(filterChoice.selected === true){
                if(typeof searchHash[filterCategory.slug] === 'undefined'){
                    searchHash[filterCategory.slug] = [];
                }
                searchHash[filterCategory.slug].push(filterChoice.slug);
            }
        });
    });
    showLoader();
    window.collection.fetch({
        data: {
            'format': 'json',
            'search': searchHash
        }
    }).then(
        function(){
            renderProducts(false);
        }
    );
}

function renderFilters(){
    var self = this;
    var filterColorTemplate = _.template($('#color-filter-square-template').html());
    var filterCategoriesTemplate = _.template($('#filter-categories-template').html());
    var filterChoiceTemplate = _.template($('#filter-choice-template').html());
    _.each(window.collection.filters, function(filterCategory){
        if(filterCategory.slug === 'parent-color'){
            $('#filter-colors-container').empty();
            _.each(filterCategory.choices, function(filterChoice){
                _.each(window.allColors, function(val){
                    if(val.slug == filterChoice.slug){
                        $('#filter-colors-container').append(filterColorTemplate(val));
                    }
                });
            });
        } else if(filterCategory.slug !== 'child-color') {
            $('#filter-categories-container').append(filterCategoriesTemplate(filterCategory));
            _.each(filterCategory.choices, function(filterChoice){
                filterChoice['filterCategory'] = filterCategory.slug;
                $('#filter-category-' + filterCategory.slug).append(filterChoiceTemplate(filterChoice));
            });
        }
    });

    $('#filter-colors-container').off();

    if (document.documentElement.clientWidth >= 768) {
        $('#filter-colors-container').on('mouseenter', '.parent-color-filter-square', function () {
            var colorLabel = $(this).attr('data-color-label');
            $('#parent-color-name-container').html('<span>' + s(colorLabel).humanize().capitalize().value() + '</span>')
        }).on('mouseleave', '.parent-color-filter-square', function () {
            $('#parent-color-name-container').html('');
        });

        $('#filter-colors-container').on('mouseenter', '.child-color-filter-square', function () {
            var colorLabel = $(this).attr('data-color-label');
            $('#child-color-name-container').html('<span>' + s(colorLabel).humanize().capitalize().value() + '</span>')
        }).on('mouseleave', '.child-color-filter-square', function () {
            $('#child-color-name-container').html('');
        });
    }

    $('#filter-colors-container').on('click', '.parent-color-filter-square', function(){
        $('#parent-color-name-container').html('');
        $('#selected-parent-color-block-container').html('<span id="selected-parent-color-remove"> x </span>  <span id="selected-parent-color-label">' + s($(this).attr('data-color-label')).humanize().capitalize().value() + '</span></span>');
        $('#selected-parent-color-block-container').css({
            'background-color': $(this).attr('data-color-hex'),
            'display': 'block'
        });
        var selectedFilterChoice = $(this).attr('data-color-label');
        if(selectedFilterChoice == 'whites' || selectedFilterChoice == 'white'){
            $('#selected-parent-color-block-container').css({
                'color': '#000',
                'border': '1px solid #D8D8D8'
            });
        } else {
            $('#selected-parent-color-block-container').css({
                'color': '#fff',
                'border': 'none'
            });
        }
        var parentColorsKey = _.findIndex(window.collection.filters, {'slug': 'parent-color'});
        var filterChoiceKey = _.findIndex(window.collection.filters[parentColorsKey]['choices'], {'slug' : selectedFilterChoice});
        window.collection.filters[parentColorsKey]['choices'][filterChoiceKey]['selected'] = true;
        fetchFilteredProducts(window.collection);

        var allChildColors = [];
        var parentColorKey = _.findIndex(window.allColors, {'slug': selectedFilterChoice});
        allChildColors = window.allColors[parentColorKey].children;

        var childColorsKey = _.findIndex(window.collection.filters, {'slug': 'child-color'});
        var availableChildColors = _.filter(allChildColors, function(color){
            return (_.findIndex(window.collection.filters[childColorsKey].choices, {'slug' : color.slug}) !== -1);
        });

        $('#filter-colors-container').empty();
        _.each(availableChildColors, function(val, key){
            $('#filter-colors-container').append(filterColorTemplate(val));
        });

        $('#child-color-name-container').show();

        $('#selected-parent-color-remove').on('click', function(){
            removeParentColor();
            removeChildColor();
            showListOfParentColors();
            fetchFilteredProducts();
        });
    });

    $('#filter-colors-container').on('click', '.child-color-filter-square', function(){
        $('#child-color-name-container').html('');
        $('#selected-child-color-block-container').html('<span id="selected-child-color-remove"> x </span>  <span id="selected-child-color-label">' + s($(this).attr('data-color-label')).humanize().capitalize().value() + '</span></span>');
        $('#selected-child-color-block-container').css({
            'background-color': $(this).attr('data-color-hex'),
            'display': 'block'
        });
        var selectedFilterCategory = 'child-color';
        var selectedFilterChoice = $(this).attr('data-color-label');
        if(selectedFilterChoice == 'white'){
            $('#selected-child-color-block-container').css({
                'color': '#000',
                'border': '1px solid #D8D8D8'
            });
        } else {
            $('#selected-child-color-block-container').css({
                'color': '#fff',
                'border': 'none'
            });
        }
        _.each(collection.filters, function(filterCategory, filterCategoryKey){
            if(filterCategory.slug === selectedFilterCategory){
                _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                    collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected'] = false;
                });
            }
        });
        _.each(collection.filters, function(filterCategory, filterCategoryKey){
            if(filterCategory.slug === selectedFilterCategory){
                _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                    if(filterChoice.slug === selectedFilterChoice){
                        collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected'] = true;
                        fetchFilteredProducts();
                    }
                });
            }
        });

        $('#selected-child-color-remove').on('click', function(){
            removeChildColor(collection);
            fetchFilteredProducts(collection);
        });

    });

    $('.filter-choice-checkbox').on('change', function(){
        var selectedFilterCategory = $(this).attr('data-filter-category');
        var selectedFilterChoice = $(this).attr('data-filter-choice');
        var checked = false;
        if($(this).is(':checked')){
            checked = true;
        }
        _.each(collection.filters, function(filterCategory, filterCategoryKey){
            if(filterCategory.slug === selectedFilterCategory){
                _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                    if(filterChoice.slug === selectedFilterChoice){
                        collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected'] = checked;
                        fetchFilteredProducts(collection);
                    }
                });
            }
        });
    });

}

function removeChildColor(){
    $('#selected-child-color-block-container').html('');
    $('#selected-child-color-block-container').css({
        'background-color': '#ffffff',
        'display': 'none'
    });
    var selectedFilterCategory = 'child-color';
    _.each(window.collection.filters, function(filterCategory, filterCategoryKey){
        if(filterCategory.slug === selectedFilterCategory){
            _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                window.collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected'] = false;

            });
        }
    });
}

function removeParentColor(){
    $('#selected-parent-color-block-container').html('');
    $('#selected-parent-color-block-container').css({
        'background-color': '#ffffff',
        'display': 'none'
    });
    var selectedFilterCategory = 'parent-color';
    _.each(collection.filters, function(filterCategory, filterCategoryKey){
        if(filterCategory.slug === selectedFilterCategory){
            _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected'] = false;

            });
        }
    });
    $('#child-color-name-container').hide();
}

function showListOfParentColors(){
    var self = this;
    var filterColorTemplate = _.template($('#color-filter-square-template').html());
    var parentColorsKey = _.findIndex(window.collection.filters, {'slug': 'parent-color'});
    var parentBorder = _.findIndex(window.collection.filters, {'border': 'border'});
    $('#filter-colors-container').empty();
    _.each(window.collection.filters[parentColorsKey]['choices'], function (filterChoice) {
        _.each(window.allColors, function (parentColor) {
            if (parentColor.slug == filterChoice.slug) {
                $('#filter-colors-container').append(filterColorTemplate(parentColor));
            }
        });
    });
}

function handleFetchError(response){
    console.log(response);
}

function updateSelectedCategoryTopLabel(label){
    $('#current-selected-category-top-label').text('Add ' + label);
}

function updateSelectedCategoryResultCount(count){
    $('#current-selected-category-total-results').text(count + ' results');
}

function addToTux(categorySlug, productModel){
    var productCategoryToStep1CategoryMapping = {
        'tuxedos': 'coatandpants',
        'suits': 'coatandpants',
        'vests': 'vestsorcummerbunds',
        'cummerbunds': 'vestsorcummerbunds',
        'shirts': 'shirt',
        'ties': 'tie',
        'shoes': 'shoesandsocks',
        'studs-and-links': 'studsandlinks',
        'coatandpants': 'coatandpants',
        'vestsorcummerbunds': 'vestsorcummerbunds',
        'vests-or-cummerbunds': 'vestsorcummerbunds',
        'tie': 'tie',
        'shirt': 'shirt',
        'vestandcummerbund': 'vestsorcummerbunds',
        'accessories': 'studsandlinks'
    };
    var step1Slug = productCategoryToStep1CategoryMapping[categorySlug];
    window.step1Categories.findWhere({'slug': step1Slug}).set('selected', productModel);
    var selectedProducts = {};
    window.step1Categories.each(function(model){
        if(model.get('selected') != null){
            selectedProducts[transformModelSlugForSave(model.get('slug'))] = model.get('selected').get('variant_id');
        }
    });
    var dataHash = {
        format: 'json',
        products: selectedProducts
    };
    saveLook(dataHash, false).then(function(response) {
        var screwAddthis = "window.addthis_share = { url_transforms : { add: { look_id: '" + response['look_id'] + "'} } }";
        eval(screwAddthis);
        window.addthis_share['url'] = 'http://www.alsformalwear.com/catalog/byt?look_id=' + response['look_id'];
        window.addthis_share['title'] = "Al's Formal Wear - Look Great. Wonderful Memories.";
    });
}

function getProductVariantDetails(variantId){
    return $.ajax({
        url: '/catalog/byt/show_variant',
        data: {'format':'json', 'variant_id': variantId}
    });
}

function showLoader(autoScroll, containerElement ){
    if(typeof autoScroll === 'undefined'){
        autoScroll = true;
    }
    if(typeof containerElement === 'undefined'){
        containerElement = 'products';
    }
    var loaderTemplate = _.template($('#loader-template').html());
    $('#load-more-products-button').attr('disabled','disabled');
    $('#' + containerElement).html(loaderTemplate());
    if(autoScroll){
        if(document.documentElement.clientWidth < 768){
            smoothScroll($('#byt-products-container').offset().top - 40);
        } else {
            smoothScroll($('#byt-products-container').offset().top - 160);
        }
    }
}

function transformModelSlugForSave(slug){
    switch(slug){
        case 'coatandpants':
            slug = 'coatandpants';
            break;
        case 'vestsorcummerbunds':
            slug = 'vestandcummerbund';
            break;
        case 'shirt':
            slug = 'shirt';
            break;
        case 'tie':
            slug = 'tie';
            break;
        case 'shoesandsocks':
            slug = 'shoes';
            break;
        case 'studsandlinks':
            slug = 'accessories';
            break;
    }
    return slug;
}

$(document).ready(function(){
    if ($("#byt-container").length > 0 ){

        window.step1Categories = new Step1CategoryCollection();
        new Step1CategoryCollectionView({collection: window.step1Categories}).render();
        new ProductCategoryCollectionView({collection: new ProductCategoryCollection()}).render();

        getAllColors().then(function(){
            showLoader(false);
            window.collection = new CoatAndPantsCollection();
            window.collection.fetch().then(renderProducts, handleFetchError);
            updateSelectedCategoryTopLabel(window.step1CategoriesList['coatandpants']);
        });

        if($.urlParam('look_id') != null){
            getLook($.urlParam('look_id'));
        } else if($.urlParam('variant_id') != null){
            var variantDetails = [];
            getProductVariantDetails($.urlParam('variant_id')).then(
                function(response){
                    var productModel = new ProductModel(response.variant);
                    addToTux($.urlParam('category'), productModel);
                }
            )
        }

        $('#save-byt-button').on('click', function(){
            var selectedProducts = {};
            window.step1Categories.each(function(model){
                if(model.get('selected') != null){
                    selectedProducts[transformModelSlugForSave(model.get('slug'))] = model.get('selected').get('variant_id');
                }
            });
            var dataHash = {
                format: 'json',
                products: selectedProducts
            };
            if($.urlParam('event_id') != null){
                dataHash['event_id'] = $.urlParam('event_id');
                if($.urlParam('look_id').length > 0){
                    updateLook(dataHash)
                } else {
                    saveLook(dataHash, true);
                }
            } else {
                saveLook(dataHash, true);
            }
        });

        $("#byt-container").on("click", ".down-caret-button-area, .category-header", function(){
            var $caret = $(this).prevAll('.down-caret').first();
            var $toggleFor = $('#' + $caret.attr('data-toggle-for'));
            if ( $caret.hasClass('active') ){
                $caret.removeClass("active")
                $toggleFor.slideUp(400);
            } else {
                $caret.addClass("active");
                $toggleFor.slideDown(400);
            }
        });

        $("#byt-container").on("mouseenter", ".down-caret-button-area", function() {
                var caret = $(this).prev().prev();
                caret.addClass('hover');
            })
            .on("mouseleave", ".down-caret-button-area", function() {
                var caret = $(this).prev().prev();
                caret.removeClass('hover');
            });

        if (document.documentElement.clientWidth >= 768) {
            $("#byt-container").on("mouseenter", ".color-filter-square", function() {
                $(this).children('.color-filter-border').first().addClass('active');

            })
            .on("mouseleave", ".color-filter-square", function() {
                $(this).children('.color-filter-border').first().removeClass('active');
            });
        }

        $('#byt-start-over-mobile-link').on('click', function(){
            $('#byt-start-over-link').trigger('click');
        });

        $('#save-byt-button-mobile').on('click', function(){
            $('#save-byt-button').trigger('click');
        });

        if(document.documentElement.clientWidth < 768) {
            $('div[data-toggle-for="colors-filter-section-container"]').removeClass('active');
            $('div[data-toggle-for="product-categories-container"]').removeClass('active');
        }

        $(document).on('scroll', function(){
            var loadMoreButton = $('#load-more-products-button');
            if(window.pageYOffset > $('#load-more-products-loader-container').position().top && loadMoreButton.attr('loading-in-progress') === 'false' && !loadMoreButton.is(':disabled')){
                loadMoreButton.attr('loading-in-progress', 'true').trigger('click');
                showLoader(false, 'load-more-products-loader-container');
            }
        });
    }
});