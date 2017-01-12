$(document).ready(function(){
    if ($("#catalog-container").length > 0 ){
        //Add a function to jQuery so we can fetch the URL params
        $.urlParam = function(name){
            var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
            if (results==null){
                return null;
            }
            else{
                return results[1] || 0;
            }
        };

        window.step1CategoriesList = {
            coatandpants: 'COAT & PANTS',
            vestandcummerbund: 'VEST OR CUMMERBUND',
            shirt: 'SHIRT',
            tie: 'TIE',
            shoesandsocks: 'SHOES',
            studsandlinks: 'STUDS AND LINKS',
            all: 'ALL PRODUCTS'
        };

        window.productCategoriesList = {
            'tuxedos': 'Tuxedo',
            'suits': 'Suit',
            'cummerbunds': 'Cummerbund',
            'vests': 'Vest',
            'shirts': 'Shirt',
            'ties': 'Tie',
            'shoes': 'Shoe',
            'studs-and-links': 'Studs & Links',
            'pants': 'Pants'
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

        var PantsCollection = Backbone.Collection.extend({
            url: '/catalog/t/product-categories/pants',
            model: ProductModel,
            totalRecords: 0,
            slug: 'pants',
            'taxon_id': 12,
            filters: [],
            parse: function(data){
                this.totalRecords = data.meta['total_records'];
                updateSelectedCategoryResultCount(data.meta['total_records']);
                return data.variants;
            }
        });

        var SocksCollection = Backbone.Collection.extend({
            url: '/catalog/t/product-categories/socks',
            model: ProductModel,
            totalRecords: 0,
            slug: 'socks',
            'taxon_id': 18,
            filters: [],
            parse: function(data){
                this.totalRecords = data.meta['total_records'];
                updateSelectedCategoryResultCount(data.meta['total_records']);
                return data.variants;
            }
        });

        var CoatsCollection = Backbone.Collection.extend({
            url: '/catalog/t/product-categories/coats',
            model: ProductModel,
            totalRecords: 0,
            slug: 'coats',
            'taxon_id': 11,
            filters: [],
            parse: function(data){
                this.totalRecords = data.meta['total_records'];
                updateSelectedCategoryResultCount(data.meta['total_records']);
                return data.variants;
            }
        });

        var AccessoriesCollection = Backbone.Collection.extend({
            url: '/catalog/t/product-categories/accessories',
            model: ProductModel,
            totalRecords: 0,
            slug: 'accessories',
            'taxon_id': 20,
            filters: [],
            parse: function(data){
                this.totalRecords = data.meta['total_records'];
                updateSelectedCategoryResultCount(data.meta['total_records']);
                return data.variants;
            }
        });

        var AllProductsCollection = Backbone.Collection.extend({
            url: '/catalog/t/product-categories/all',
            model: ProductModel,
            totalRecords: 0,
            slug: 'all',
            'taxon_id': 142,
            filters: [],
            parse: function(data){
                this.totalRecords = data.meta['total_records'];
                updateSelectedCategoryResultCount(data.meta['total_records']);
                return data.variants;
            }
        });

        var SearchedProductsCollection = Backbone.Collection.extend({
            url: '/catalog/byt/keyword_search?search[keyword]=abc',
            model: ProductModel,
            totalRecords: 0,
            slug: 'all',
            'taxon_id': 142,
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
                    'all': 'All Products',
                    'tuxedos': 'Tuxedos',
                    'suits': 'Suits',
                    'cummerbunds': 'Cummerbunds',
                    'vests': 'Vests',
                    'shirts': 'Shirts',
                    'ties': 'Ties',
                    'shoes': 'Shoes',
                    'studs-and-links': 'Studs & Links',
                    'pants': 'Pants'
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
                    } else {
                        $('#' + model.get('slug')).html('');
                    }
                    smoothScroll(250);
                }, this);
            },
            events: {
                'click .step1-category-link-empty': 'showProducts',
                'click .step1-category-link-selected': 'removeProduct'
            },
            render: function(){
                this.$el.html(this.template(this.model.toJSON()));
                return this;
            },
            showProducts: function(evt){
                window.collection = null;
                switch(this.model.get('slug')){
                    case 'coatandpants':
                        window.collection = new TuxCollection();
                        break;
                    case 'vestandcummerbund':
                        window.collection = new VestCollection();
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
                window.collection.fetch().then(
                    function(){
                        renderProducts();
                        smoothScroll($('#byt-products-container').offset().top - 160);
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
                'click .product-details-button': 'onClickProductDetails'
            },
            onClickAddToTux: function(evt){
                this.$el.find('.showbox').removeClass('hidden');
                var slug = this.model.get('product_category');
                window.location.href = '/catalog/byt/?variant_id=' + this.model.get('variant_id') + '&category=' + slug;
            },
            onClickProductDetails: function(evt){
                this.$el.find('.showbox').removeClass('hidden');
                window.location.href = '/catalog/products/' + this.model.get('slug') + '?variant_id=' + this.model.get('variant_id');
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
                
                if(document.documentElement.clientWidth < 768){
                    $(this).next().find('.product-list-item').on('click', function(){
                        $(this).find('.showbox').removeClass('hidden');
                        self.onClickProductDetails();
                    });
                }

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
                fetchProducts(this.model.get('slug'))
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

        function fetchProducts(productCategory){
            getProductCollectionForProductCategory(productCategory);
            updateSelectedCategoryTopLabel(window.productCategoriesList[productCategory]);
            updateSelectedCategoryColor(productCategory);
            showLoader();
            return window.collection.fetch().then(
                renderProducts,
                handleFetchError
            );
        }

        function getProductCollectionForProductCategory(productCategory){
            window.collection = null;
            switch(productCategory){
                case 'tuxedos':
                    window.collection = new TuxCollection();
                    break;
                case 'suits':
                    window.collection = new SuitCollection();
                    break;
                case 'cummerbunds':
                    window.collection = new CummerbundCollection();
                    break;
                case 'vests':
                    window.collection = new VestCollection();
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
                case 'pants':
                    window.collection = new PantsCollection();
                    break;
                case 'coats':
                    window.collection = new CoatsCollection();
                    break;
                case 'socks':
                    window.collection = new SocksCollection();
                    break;
                case 'accessories':
                    window.collection = new AccessoriesCollection();
                    break;
                case 'all':
                    window.collection = new AllProductsCollection();
                    break;
            }
        }

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
                },
                failure: function(data){
                    console.log(data)
                }
            });
        }

        function saveLook(dataHash){
            $.ajax({
                url: '/catalog/byt',
                type: 'POST',
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
                            type: 'parent',
                            border: val['border'],
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
                                selected: false
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
                $('#filter-categories-container').html('');
            }
            $('#load-more-products-button').off();
            window.productCollectionView = new ProductCollectionView({collection: window.collection});
            window.productCollectionView.render();
            if(refreshFilters){
                return fetchFilters().then(function(){
                    renderFilters();
                    $('body').trigger('products-rendered');
                })
            } else {
                $('body').trigger('products-rendered');
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
                $('#filter-colors-container').on('mouseenter', '.parent-color-filter-square', function(){
                    var colorLabel = $(this).attr('data-color-label');
                    $('#parent-color-name-container').html('<span>' + s(colorLabel).humanize().capitalize().value() + '</span>')
                }).on('mouseleave', '.parent-color-filter-square', function(){
                    $('#parent-color-name-container').html('');
                });

                $('#filter-colors-container').on('mouseenter', '.child-color-filter-square', function(){
                    var colorLabel = $(this).attr('data-color-label');
                    $('#child-color-name-container').html('<span>' + s(colorLabel).humanize().capitalize().value() + '</span>')
                }).on('mouseleave', '.child-color-filter-square', function(){
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
                if(selectedFilterChoice == 'whites' ){
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

                updateFiltersInUrl();
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
                if( selectedFilterChoice == 'white'  ){
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
                            if(filterChoice.slug === selectedFilterChoice) {
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

                updateFiltersInUrl();

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
                updateFiltersInUrl();
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
            updateFiltersInUrl();
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
            updateFiltersInUrl();
        }

        function showListOfParentColors(){
            var self = this;
            var filterColorTemplate = _.template($('#color-filter-square-template').html());
            var parentColorsKey = _.findIndex(window.collection.filters, {'slug': 'parent-color'});
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

        function updateFiltersInUrl(){
            var params = getURLSearchParameters();
            var url = window.location.href;
            _.each(params, function(val, index){
                if(index.search(/filter_/) !== -1){
                    url = removeParameterFromUrl(url, index);
                }
            });
            _.each(collection.filters, function(filterCategory, filterCategoryKey){
                _.each(filterCategory.choices, function(filterChoice, filterChoiceKey){
                    if(collection.filters[filterCategoryKey].choices[filterChoiceKey]['selected']) {
                        url = addParameterToUrl(url, 'apply_filters', 'true');
                        if(_.contains(['parent-color', 'child-color'], filterCategory.slug)){
                            url = addParameterToUrl(url, 'filter_' + filterCategory.slug, filterChoice.slug)
                        } else {
                            url = addParameterToUrl(url, 'filter_' + filterCategory.slug + '[]', filterChoice.slug)
                        }
                    }
                });
            });
            window.history.replaceState({}, '', url);
        }

        function addParameterToUrl(url, parameterName, parameterValue, atStart/*Add param before others*/){
            parameterValue = encodeURIComponent(parameterValue);
            var replaceDuplicates = true;
            if(parameterName.search('filter_') !== -1){
                replaceDuplicates = false;
            }
            if(url.indexOf('#') > 0){
                var cl = url.indexOf('#');
                var urlhash = url.substring(url.indexOf('#'),url.length);
            } else {
                urlhash = '';
                cl = url.length;
            }
            var sourceUrl = url.substring(0,cl);

            var urlParts = sourceUrl.split("?");
            var newQueryString = "";

            if (urlParts.length > 1)
            {
                var parameters = urlParts[1].split("&");
                for (var i=0; (i < parameters.length); i++)
                {
                    var parameterParts = parameters[i].split("=");
                    if (!(replaceDuplicates && parameterParts[0] == parameterName))
                    {
                        if (newQueryString == "")
                            newQueryString = "?";
                        else
                            newQueryString += "&";
                        newQueryString += parameterParts[0] + "=" + (parameterParts[1]?parameterParts[1]:'');
                    }
                }
            }
            if (newQueryString == "")
                newQueryString = "?";

            if(atStart){
                newQueryString = '?'+ parameterName + "=" + parameterValue + (newQueryString.length>1?'&'+newQueryString.substring(1):'');
            } else {
                if (newQueryString !== "" && newQueryString != '?')
                    newQueryString += "&";
                newQueryString += parameterName + "=" + (parameterValue?parameterValue:'');
            }
            return urlParts[0] + newQueryString + urlhash;
        };

        function removeParameterFromUrl(url, parameterName, parameterValue) {
            //prefer to use l.search if you have a location/link object
            var urlparts= url.split('?');
            if (urlparts.length>=2) {

                var prefix= parameterName + '=';
                var pars= urlparts[1].split(/[&;]/g);

                //reverse iteration as may be destructive
                for (var i= pars.length; i-- > 0;) {
                    //idiom for string.startsWith
                    if (pars[i].lastIndexOf(prefix, 0) !== -1) {
                        pars.splice(i, 1);
                    }
                }

                url= urlparts[0]+'?'+pars.join('&');
                return url;
            } else {
                return url;
            }
        }

        function updateSelectedCategoryColor(productCategory){
            $('.product-category-link').removeClass('product-category-selected');
            $('.product-category-link[data-slug="'+ productCategory +'"]').addClass('product-category-selected');
            var url = window.location.href;
            url = removeParameterFromUrl(url, 'apply_filters');
            var params = getURLSearchParameters();
            _.each(params, function(val, index){
                if(index.search(/filter_/) !== -1){
                    url = removeParameterFromUrl(url, index);
                }
            });
            window.history.replaceState({}, '', addParameterToUrl(url, 'category', productCategory, true));
        }

        // Configure Underscore to use {{- }} as the escape tags, since the default <%= %> tags are processed by ERB & hence cannot be used here
        _.templateSettings.escape = /\{\{-(.*?)\}\}/g
        _.templateSettings.evaluate = /\{\{(.*?)\}\}/g
        window.step1Categories = new Step1CategoryCollection();
        new Step1CategoryCollectionView({collection: window.step1Categories}).render();
        new ProductCategoryCollectionView({collection: new ProductCategoryCollection()}).render();

        $("#catalog-container").on("click", ".down-caret-button-area, .category-header", function(){
            var $caret = $(this).prevAll('.down-caret').first();
            var $toggleFor = $('#' + $caret.attr('data-toggle-for'));
            if ( $caret.hasClass('active') ){
                $caret.removeClass("active");
                $toggleFor.slideUp(400);
            } else {
                $caret.addClass("active");
                $toggleFor.slideDown(400);
            }
        });

        $("#catalog-container").on("mouseenter", ".down-caret-button-area", function() {
            var caret = $(this).prev().prev();
            caret.addClass('hover');
        })
            .on("mouseleave", ".down-caret-button-area", function() {
                var caret = $(this).prev().prev();
                caret.removeClass('hover');
            });

        if (document.documentElement.clientWidth >= 768) {
            $("#catalog-container").on("mouseenter", ".color-filter-square", function () {
                $(this).children('.color-filter-border').first().addClass('active');
            })
                .on("mouseleave", ".color-filter-square", function () {
                    $(this).children('.color-filter-border').first().removeClass('active');
                });
        }

        getAllColors().then(function(){
            if($.urlParam('category') != null){
                showLoader();
                if($.urlParam('parent-color') != null){
                    getProductCollectionForProductCategory($.urlParam('category'));
                    updateSelectedCategoryColor($.urlParam('category'));
                    fetchFilters().then(function(){
                        renderFilters();
                        var selectedFilterChoice = $.urlParam('parent-color');
                        $('.parent-color-filter-square[data-color-label="'+ selectedFilterChoice +'"]').trigger('click');
                    });

                } else {
                    fetchProducts($.urlParam('category'));
                }
            } else if($.urlParam('keyword') != null) {
                $.ajax({
                    type: 'GET',
                    url: '/catalog/byt/keyword_search',
                    data:{'search': {'keyword': $.urlParam('keyword')}},
                    success: function(data){
                        if (data.variants.length === 0){
                            $('.no-results-message').removeClass('hidden').show();
                        } else {
                            $('.no-results-message').addClass('hidden').hide();
                        }
                        window.collection = new SearchedProductsCollection();
                        _.each(data.variants, function(product){
                            window.collection.add(new ProductModel(product));
                        });
                        window.collection.url = '/catalog/byt/keyword_search?search[keyword]=' + $.urlParam('keyword');
                        window.collection.totalRecords = data.meta['total_records'];
                        updateSelectedCategoryResultCount(data.meta['total_records']);
                        renderProducts();
                        updateSelectedCategoryTopLabel(window.step1CategoriesList['all']);
                    },
                    error: handleFetchError
                });
            } else {
                window.collection = new TuxCollection();
                window.collection.fetch().then(renderProducts, handleFetchError);
                updateSelectedCategoryTopLabel(window.step1CategoriesList['coatandpants']);
            }

            if(typeof window.urlParams['apply_filters'] !== 'undefined'){
                $('body').one('products-rendered', function(){
                    _.each(window.urlParams, function(val, key){
                        if(key.search('filter_') !== -1){
                            var filterSlug = key.split(/filter_/)[1];
                            if(filterSlug.search(/\[\]/) !== -1){
                                filterSlug = filterSlug.split(/\[\]/)[0];
                                _.each(val, function(filterVal){
                                    $('#filter-category-' + filterSlug + ' input[data-filter-choice="' + filterVal + '"]').trigger('click');
                                });
                            } else if (filterSlug === 'parent-color'){
                                $('div.parent-color-filter-square[data-color-label="'+ val +'"]').trigger('click');
                                if(typeof window.urlParams['filter_child-color'] !== 'undefined'){
                                    $('div.child-color-filter-square[data-color-label="'+ window.urlParams['filter_child-color'] +'"]').trigger('click');
                                    delete window.urlParams['filter_child-color'];
                                }
                            } else {
                                $('#filter-category-' + filterSlug + ' input[data-filter-choice="' + val + '"]').trigger('click');
                            }
                            if(!$('div[data-toggle-for="filter-category-' + filterSlug + '"]').hasClass('active')){
                                $('div[data-toggle-for="filter-category-' + filterSlug + '"]').addClass('active');
                                $('div[data-toggle-for="filter-category-' + filterSlug + '"]').siblings('ul.filter-category').css('display', 'block');
                            }
                        }
                    })
                });
            }

        });

        $('#save-byt-button').on('click', function(){
            var selectedProducts = {};
            window.step1Categories.each(function(model){
                if(model.get('selected') != null){
                    selectedProducts[model.get('slug')] = model.get('selected').get('variant_id');
                }
            });
            var dataHash = {
                format: 'json',
                products: selectedProducts
            };
            if($.urlParam('event_id') != null){
                dataHash['event_id'] = $.urlParam('event_id');
                if($.urlParam('look_id') != null){
                    updateLook(dataHash)
                } else {
                    saveLook(dataHash);
                }
            } else {
                saveLook(dataHash);
            }
        });

        if(document.documentElement.clientWidth < 768) {
            $('div[data-toggle-for="colors-filter-section-container"]').removeClass('active');
            $('div[data-toggle-for="product-categories-container"]').removeClass('active');
        }

        if($.urlParam('look_id') != null){
            getLook($.urlParam('look_id'));
        }

        if(document.documentElement.clientWidth < 768) {
            $(document).on('scroll', function(){
                var loadMoreButton = $('#load-more-products-button');
                if(window.pageYOffset > $('#load-more-products-loader-container').position().top && loadMoreButton.attr('loading-in-progress') === 'false' && !loadMoreButton.is(':disabled')){
                    loadMoreButton.attr('loading-in-progress', 'true').trigger('click');
                    showLoader(false, 'load-more-products-loader-container');
                }
            });
        } else {
            $(document).on('scroll', function(){
                var loadMoreButton = $('#load-more-products-button');
                var footerHeight = $('footer').height() + 300;
                if(window.pageYOffset > ($('#load-more-products-loader-container').position().top - footerHeight) && loadMoreButton.attr('loading-in-progress') === 'false' && !loadMoreButton.is(':disabled')){
                    loadMoreButton.attr('loading-in-progress', 'true').trigger('click');
                    showLoader(false, 'load-more-products-loader-container');
                }
            });
        }

    }
});