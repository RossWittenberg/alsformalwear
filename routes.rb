Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"

  mount Spree::Core::Engine, :at => '/catalog'

  root 'welcome#index'

  delete 'appointment/:id' => 'appointment#delete'

  get '/quinceanera.asp', to: redirect('/quinceanera')
  get '/prom.asp', to: redirect('/prom')
  get '/about.asp', to: redirect('/about')
  get '/contact.asp', to: redirect('/contact')
  get '/:80/measurements.asp', to: redirect('/measurements')

  get 'about/'                      => 'welcome#about'
  get 'wedding/'                    => 'welcome#wedding'
  get 'prom/'                       => 'welcome#prom'
  get 'terms-and-privacy/'          => 'welcome#terms'
  get 'quinceanera/'                => 'welcome#quinceanera'
  get 'social-event/'               => 'welcome#social_event'
  get 'contact/'                    => 'welcome#contact'
  get 'group-offers/'               => 'welcome#group_offers'
  get 'discount/'                   => 'welcome#discount'
  get 'cap/'                        => 'welcome#cap'
  get 'out-of-town-measurements/'   => 'measurements#out_of_town_measurements'
  get 'sitemap/'                    => 'welcome#sitemap'

  get 'byt' => "welcome#byt"

  put 'catalog/byt/:id' => 'spree/byt#update'

  get 'events/select' => 'events#select'
  get 'events/print' => 'events#print'
  get 'events/variant_look_up' => 'events#variant_look_up'
  post 'events/create_with_group_code' => 'events#create_with_group_code'
  put 'events/update_with_group_code/:id' => 'events#update_with_group_code'
  get 'events/high_schools' => 'events#high_schools'
  post 'events/download' => 'events#download'
  post 'events/users_download' => 'events#users_download'
  post 'events/appointments_download' => 'events#appointments_download'

  post 'discounts/general_discounts_download' => 'discounts#general_discounts_download'
  post 'discounts/wedding_discounts_download' => 'discounts#wedding_discounts_download'


  put 'measurements/out-of-town' => 'measurements#out_of_town_measurements_submit'
  put 'measurements/validate' => 'measurements#validate'


  get 'locations/hours' => 'locations#fetch_hours'
  get 'locations/nearest' => 'locations#nearest'
  resources :locations, only: [:show, :index]

  resources :events, except: :show
  
  resources :discounts, only: :destroy


  resources :favorites, only: [:create, :destroy]
  put 'favorites/individual_product_destroy' => 'favorites#individual_product_destroy'
  get 'favorites/user_favorites' => 'favorites#user_favorites'
  

  resources :measurements, only: [:create, :update, :destroy, :index]


  put 'catalog/user/:id' => 'spree/user#update'

  get 'catalog/byt/show_variant' => 'spree/byt#show_variant'
  get 'catalog/byt' => 'spree/byt#index'
  get 'catalog/byt/colors' => 'spree/byt#colors'
  get 'catalog/byt/search_colors' => 'spree/byt#search_colors'
  get 'catalog/byt/filters_by_taxon' => 'spree/byt#filters_by_taxon'
  get 'catalog/byt/keyword_search' => 'spree/byt#keyword_search'
  get 'catalog/byt/find_parent' => 'spree/byt#find_parent'
  get 'catalog/byt/:id' => 'spree/byt#show'
  post 'catalog/byt' => 'spree/byt#create'
  put 'catalog/byt/:id' => 'spree/byt#update'
  delete 'catalog/byt' => 'spree/byt#destroy'
  post 'catalog/byt/clone' => 'spree/byt#clone'

  # adding event to a look

  post 'catalog/byt/event' => 'spree/byt#create_event_for_look'
  put 'catalog/byt/event/:id' => 'spree/byt#update_event_for_look'

  put 'forms/appointment'        => 'forms#appointment'
  put 'forms/contact'        => 'forms#contact'
  put 'forms/school_group_sales' => 'forms#school_group_sales'
  put 'forms/discount' => 'forms#discount'
  put 'forms/wedding-discount' => 'forms#wedding_discount'
  put 'forms/cap' => 'forms#cap'
  
  



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  #SPECIFIC 301 RULES
  get '/home', to: redirect('/')
  get '/shopexd.asp' => 'redirects#catalog'
  get '/rental-category.asp' => 'redirects#rentalCategory'
  get '/informal.asp' => 'redirects#misc'
  get '/destination.asp' => 'redirects#staticWed'
  get '/prom-discount-coupon.asp' => 'redirects#misc'
  get '/catalog-item-review.asp' => 'redirects#misc'
  get '/color-match-detail.asp' => 'redirects#misc'
  get '/bridal-show/show-number.asp', to: redirect('http://archive.alsformalwear.com/bridal-show/show-number.asp')
  get '/bridal-shows.asp', to: redirect('/wedding')
  get '/scholarships.asp', to: redirect('/')
  get '/scholarships-winners.asp', to: redirect('/')
  get '/scholarships-apply.asp', to: redirect('/')
  get '/about-donations.asp', to: redirect('/')
  get '/school-services.asp', to: redirect('/group-offers')
  get '/prom-rep-index.asp', to: redirect('/group-offers')
  get '/scb-index.asp', to: redirect('/group-offers')
  get '/social.asp', to: redirect('/group-offers')
  get '/social', to: redirect('/group-offers')
  get '/sef.asp', to: redirect('/group-offers')
  get '/sef', to: redirect('/group-offers')
  get '/about-careers', to: redirect('/')
  get '/espanol-form.asp', to: redirect('/')
  get '/byt-page.asp', to: redirect('/catalog/byt')
  get '/color-match.asp', to: redirect('/')
  get '/wedding.asp', to: redirect('/wedding')
  get '/portfolio-wedding-index.asp', to: redirect('/wedding')
  get '/:80/google-analytics.com/ga.js', to: redirect('http://google-analytics.com/ga.js')
  get '/:80/restoration/', to: redirect('http://www.crdnhouston.com/')  
  get '/:80/quince-history.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-all.asp#special', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-all.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-tax.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-security.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-security.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-security.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/:80/policy-security.asp', to: redirect('https://buy.alsformalwear.com/')
  get '/14&template=tmp_prom_rental.htm', to: redirect('/catalog/products/black-label-slim-fit-shawl?variant_id=874')
  get '/73&template=tmp_prom_rental.htm', to: redirect('/catalog/products/slate-blue-allure?variant_id=268')
  get '/80&template=tmp_prom_rental.htm', to: redirect('/catalog/products/midnight-blue-notch?variant_id=276')
  get '/81&template=tmp_prom_rental.htm', to: redirect('/catalog/products/kors-2-button-notch?variant_id=316')
  get '/36&template=tmp_prom_rental.htm', to: redirect('/catalog/products')
  get '/83&template=tmp_prom_rental.htm', to: redirect('/catalog/products/silver-savoy?variant_id=332')
  get '/84&template=tmp_prom_rental.htm', to: redirect('/catalog/products')
  get '/76&template=tmp_prom_rental.htm', to: redirect('/catalog/products/white-illusion?variant_id=272')
  get '/10&template=tmp_prom_rental.htm', to: redirect('/catalog/products/white-illusion?variant_id=272')
  get '/20&template=tmp_prom_rental.htm', to: redirect('/catalog/products/republic-2-button-notch?variant_id=170')
  get '/52&template=tmp_prom_rental.htm', to: redirect('/catalog/products/marseille-2-button-peak?variant_id=186')
  get '/7&template=tmp_prom_rental.htm', to: redirect('/catalog/products/black-couture-peak?variant_id=152')
  get '/5&template=tmp_prom_rental.htm', to: redirect('/catalog/products/the-avalon?variant_id=148')
  get '/48&template=tmp_prom_rental.htm', to: redirect('/catalog/products/el-rey-black?variant_id=182')
  get '/49&template=tmp_prom_rental.htm', to: redirect('/catalog/products/el-rey-white?variant_id=184')
  get '/80&template=tmp_quince_rental.htm', to: redirect('/catalog/products/midnight-blue-notch?variant_id=276')
  get '/2&template=tmp_quince_rental.htm', to: redirect('/catalog/products/1-button-notch?variant_id=62')
  get '/7&template=tmp_quince_rental.htm', to: redirect('/catalog/products/black-couture-peak?variant_id=152')
  get '/11&template=tmp_quince_rental.htm', to: redirect('/catalog/products/double-breasted-peak?variant_id=1632')
  get '/3&template=tmp_quince_rental.htm', to: redirect('/catalog/products/classic-full-dress-peak-tails?variant_id=66')
  get '/61&template=tmp_quince_rental.htm', to: redirect('/catalog/products/white-2-button-notch?variant_id=245')
  get '/205&template=tmp_quince_rental.htm', to: redirect('/catalog/products/the-zootux?variant_id=370')
  get '/88&template=tmp_prom_rental.htm', to: redirect('/catalog/products')
  get '/96&template=tmp_prom_rental.htm', to: redirect('/catalog/products')
  get '/88&template=tmp_quince_rental.htm', to: redirect('/catalog/products')
  get '/206&template=tmp_quince_rental.htm', to: redirect('/catalog/products')
  get '/48&template=tmp_quince_rental.htm', to: redirect('/catalog/products')
  get '/49&template=tmp_quince_rental.htm', to: redirect('/catalog/products')
  get '/sef-index.asp', to: redirect('/social-event/#social-fund')
  get '/library-prom-faq.asp', to: redirect('/contact#faq-top')
  get '/library-prom-faq.asp', to: redirect('/contact#faq-top')
  get '/:80/scripts/date.js', to: redirect('/')
  get '/scripts/CalendarPopup.js', to: redirect('/')
  get '/:80/co-prom-byt-index.asp', to: redirect('/prom')
  get '/:80/prom-byt-page.asp', to: redirect('/prom')
  get '/prom-byt-page.asp', to: redirect('/prom')
  get '/:80/co-rental-category.asp', to: redirect('/catalog/products')
  get '/:80/store-hours.asp', to: redirect('/locations')
  get '/:80/store-list.asp', to: redirect('/locations')
  get '/:80/co-portfolio-wedding-index.asp', to: redirect('/catalog/login')
  get '/:80/prom-index.asp', to: redirect('/prom')
  get '/:80/co-prom-index.asp', to: redirect('/prom')
  get '/:80/prom/prom-styles.asp', to: redirect('/prom')
  get '/:80/quince-index.asp', to: redirect('/quinceanera')
  get '/:80/quince-category.asp', to: redirect('/quinceanera')
  get '/:80/quince-index.asp', to: redirect('/quinceanera')
  get '/:80/prom-school-services.asp', to: redirect('/group-offers')
  get '/:80/aboutus-school-services.asp', to: redirect('/group-offers')
  get '/:80/prom-angelique-form.asp', to: redirect('/contact')
  get '/:80/quince-angelique-form.asp', to: redirect('/contact')
  get '/:80/angelique-form.asp', to: redirect('/contact')
  get 'www.alsformalwear.com:80/ask-angelique.asp', to: redirect('/contact')
  get '/:80/home.htm', to: redirect('/')
  get '/:80/policy-rental-agreement.asp', to: redirect('/')
  get '/:80/aboutus-hawc-school.asp', to: redirect('/')
  get '/:80/rental-new.asp', to: redirect('/')
  get '/:80/index.htm', to: redirect('/')
  get '/:80/books/api_fed790ab9d7ba1278089460fbaa3fa91.js?hl=en', to: redirect('/')
  get '/:80/books/api_20f3c55ed3dd15cab292af43a4d6da73.js?hl=en', to: redirect('/')
  get ':80/aboutus.asp', to: redirect('/about')
  get '/:80/aboutus-history.asp', to: redirect('/about')
  get '/:80/aboutus-misterneats.asp', to: redirect('/about')
  get '/:80/contactus.asp', to: redirect('/contact')
  get ':80/coupon.asp', to: redirect('/discount')
  get '/discount-coupons.asp', to: redirect('/discount')
  get '/library-signature-look.asp', to: redirect('/prom')
  get '/library-wedding-video.asp', to: redirect('/wedding')
  get '/library-wedding-suit.asp', to: redirect('/wedding')
  get '/library-wedding-drphil.asp', to: redirect('/wedding')
  get '/library-wedding-tv.asp', to: redirect('/wedding')
  get '/library-bowtie-back.asp', to: redirect('/wedding')
  get '/library-brown-tuxedos.asp', to: redirect('/wedding')
  get '/store-locations.asp', to: redirect('/locations')
  get '/student-rep.asp', to: redirect('/')
  get '/policies.asp', to: redirect('/')
  get '/testimonials.asp', to: redirect('/')
  get '/about-2007-expansion.asp', to: redirect('/about')
  get '/:80/index.php', to: redirect('/')
  get '/:80/images/coupons/dyd-formal.gift', to: redirect('/discount')
  get '/design-your-discount', to: redirect('/discount')
  get '/ask.asp', to: redirect('/contact')
  get '/library-quinceanera-history.asp', to: redirect('/quinceanera')
  get '/library-tuxedo-dictionary.asp', to: redirect('/')
  get '/library-tuxedo-etiquette.asp', to: redirect('http://info.alsformalwear.com/2015/12/07/formal-wear-etiquette/')
  get '/library-bowtie-howto.asp', to: redirect('http://info.alsformalwear.com/2015/12/07/how-to-tie-a-perfect-bow-tie/')
  get '/library-ascot-howto.asp', to: redirect('/')
  get '/library-tuxedo-dictionary.asp', to: redirect('/')
  get '//library-boutonniere-howto.asp', to: redirect('http://www.alscornerblog.com/2015/12/07/how-to-pin-on-a-boutonniere/')
  get '/library-perfect-fit.asp', to: redirect('/')
  get '/library-charts.asp', to: redirect('/')
  get '/slim-fit-shirts.asp', to: redirect('/')
  get '/measurement-form.asp', to: redirect('/')
  get '/library-tuxedo-history.asp', to: redirect('http://info.alsformalwear.com/2015/12/07/history-of-the-tuxedo/')
  get '/library-garter-history.asp', to: redirect('http://info.alsformalwear.com/2015/12/07/the-history-of-the-garter/')  
  get '/library-groom-calendar.asp', to: redirect('/')
  get '/library-guys-guide.asp', to: redirect('/')
  get '/library-wedding-date.asp', to: redirect('/')
  get '/library-holiday-calendar.asp', to: redirect('/')
  get '/library-wedding-checklist.asp', to: redirect('/')
  get '/library-bridal-shows.asp', to: redirect('/')
  get '/library-groomsmens-gifts.asp', to: redirect('/')
  get '/library-creative-invitations.asp', to: redirect('/')
  get '/library-quinceanera-checklist.asp', to: redirect('/quinceanera')
  get '/byt-popup.asp', to: redirect('/catalog/byt')
  get '/store-locations.asp', to: redirect('/locations')
  get '/store-map.asp', to: redirect('/locations')
  get '/store-city.asp', to: redirect('/locations')
  get '/prom-faq.asp', to: redirect('/prom')
  get '/destination-faq.asp', to: redirect('/wedding')
  get '/byt-page.asp', to: redirect('/catalog/byt')
  get '/vendor-night.asp', to: redirect('/group-offers')
  get '/catalog/products/www.alsinvitations.com', to: redirect('/')
  get '/catalog/www.alsinvitations.com', to: redirect('/')
  get '/www.alsinvitations.com', to: redirect('/')
  get '/formal.asp', to: redirect('/social-event')
  get '/cse', to: redirect('/')
  get '/links.asp', to: redirect('/')
  get '/about-low-prices.asp', to: redirect('/')
  get '/about-misterneats.asp', to: redirect('/')
  get '/tuxedo-dictionary.asp', to: redirect('/')
  get '/info-perfect-fit.asp', to: redirect('/')
  get '/info-tux-history.asp', to: redirect('/')
  get '/restoration', to: redirect('/')
  get '/prom-poster-form.asp', to: redirect('/prom')
  get '/scholarship-rules.asp', to: redirect('/prom')
  get '/prom-coupon.asp', to: redirect('/prom/#form-top')
  get 'prom-rep.asp', to: redirect('/prom/#rep-form')
  get '/prom-discount-coupon.asp', to: redirect('/prom/#rep-form')
  get '/prom-byt-print.asp', to: redirect('/prom')
  get '/teacher-grants.asp', to: redirect('/group-offers')
  get '/security.asp', to: redirect('/terms-and-privacy')
  get '/login', to: redirect('/catalog/login')
  get '/portfolio-email-password.asp', to: redirect('/catalog/login')
  get '/sweepstakes-entry.asp', to: redirect('/wedding/#wedding-sweepstakes')
  get '/info-wedding-video.asp', to: redirect('http://www.alsphotography.com/Packages.aspx?Type=2')
  get '/video.asp', to: redirect('http://www.alsphotography.com/Packages.aspx?Type=2')
  get '/wedding-invitations.asp', to: redirect('http://www.alsinvitations.com/')
  get '/wedding-gifts.asp', to: redirect('/wedding')
  get '/info-wedding-drphil.asp', to: redirect('/wedding')
  get '/info-wedding-suit.asp', to: redirect('/wedding')
  get '/quince-bear.asp', to: redirect('/quinceanera')
  get '/quince-coupons.asp', to: redirect('/quinceanera')
  get '/quince-history.asp', to: redirect('/quinceanera')
  get '/quinceanera-catalog.asp', to: redirect('/quinceanera')
  get '/quince-index.asp', to: redirect('/quinceanera')
  get '/catalog-detail.asp', to: redirect('/catalog/products')
  get '/catalog-item-review.asp', to: redirect('/catalog/products')
  get '/info-chocolate.asp', to: redirect('/catalog/products')
  get '/obama-tux.asp', to: redirect('/catalog/products')
  get '/michael-kors.asp', to: redirect('/catalog/products')
  get '/portfolio-index.asp', to: redirect('/catalog/products')
  get '/discover', to: redirect('/catalog/products')
  get '/catalog.asp', to: redirect('/catalog/products')
  get '/index.asp', to: redirect('/catalog/products')
  get '/info-signature-look.asp', to: redirect('/catalog/products')
  get '/rental-suits.asp', to: redirect('/catalog/products')
  get '/measurement-card-form.asp', to: redirect('/out-of-town-measurements')
  get '/store-locator.asp', to: redirect('/locations')
  get '/co-store-locations.asp', to: redirect('/locations')
  get '/store-map.asp', to: redirect('/locations')
  get '/library-body-types.asp', to: redirect('/group-offers')
  get '/tuxedo-library.asp', to: redirect('/group-offers')
  get '/library-wedding-apps.asp', to: redirect('/group-offers')
  get '/library-2008-scholarships.asp', to: redirect('/group-offers')
  get '/mardi-gras.asp', to: redirect('/group-offers')
  get '/SchoolApp', to: redirect('/group-offers')
  get '/angelique-form', to: redirect('/contact')
  get '/policy-returns.asp', to: redirect('/contact')
  get '/info-body-types.asp', to: redirect('/contact/#faq-top')
  get '/info-etiquette.asp', to: redirect('/contact/#faq-top')
  get '/info-ifa-2007.asp', to: redirect('/contact')
  get '/byt-help.asp', to: redirect('/catalog/byt')
  get '/portfolio-save-form.asp', to: redirect('/catalog/byt')
  get '/prom-byt-page.asp?choose=vest', to: redirect('/catalog/byt')
  get '/aboutus-employment.asp', to: redirect('/about')
  get '/aboutus-contact.asp', to: redirect('/about')
  get '/aboutus-2007-expansion.asp', to: redirect('/about')
  get '/aboutus-donations.asp', to: redirect('/about')
  get '/Scholarships.apply.asp', to: redirect('/prom')
  get '/formal-byt-page.asp', to: redirect('/catalog/byt')
  get '/guarantee.asp', to: redirect('/')
  get '/catalog-item-review.asp', to: redirect('/catalog')
  get '/search-results.asp', to: redirect('/catalog')

  get '/shopexd.asp', to: redirect('/catalog/products')
  get '/', to: redirect('/')

  # get URI.escape('/wedding/%23wedding-discount'), to: redirect('/wedding/#wedding-discount')
  # get '/wedding/%20-%20wedding-sweepstakes', to: redirect('/wedding/#wedding-sweepstakes')
  # get URI.escape('/prom/%20-%20school-fund'), to: redirect('/prom/#school-fund')
  # get '/prom/%20-%20rep-form', to: redirect('/prom/#rep-form')
  # get '/prom/%20-%20school-group', to: redirect('/prom/#school-group')
  # get '/social-event/%20-%20social-fund', to: redirect('/social-event/#social-fund')

  # The "main" `devise_for :spree_user` is added via solidus_auth_devise, at
  # (https://github.com/solidusio/solidus_auth_devise/blob/master/config/routes.rb).
  # But it's hardcoded to skip creation of OmniAuth routes. I've added a `devise_for`
  # here, which doesn't omit OmniAuth routes, and kept it as minimal a route footprint
  # as easily possible. —JC
  devise_for :spree_user,
             :class_name => 'Spree::User',
             :controllers => { :omniauth_callbacks => "spree/omniauth_callbacks" },
             :skip => [:unlocks],
             :path_names => { :sign_out => 'logout' },
             :path_prefix => :user

  if Rails.env.development?
    get '/thirdparty-authentication',
        to: 'sandbox#thirdparty_authentication',
        layout: false
  end

  get "*any", via: :all, to: "errors#not_found"
end

Spree::Core::Engine.add_routes do
  get '/admin/leads' => 'admin/leads#index'
  namespace :admin do
    resources :locations
    resources :colors
    get    '/competitor_color/new'      => 'colors#new_competitor_color', as: :new_competitor_color
    # post   '/competitor_color'          => 'colors#create_competitor_color', as: :create_competitor_color
    # get    '/competitor_color/:id/edit' => 'colors#edit_competitor_color', as: :edit_competitor_color
    # put    '/competitor_color/:id'      => 'colors#update_competitor_color', as: :update_competitor_color
    # delete '/competitor_color/:id'      => 'colors#destroy_competitor_color', as: :destroy_competitor_color
    resources :group_codes, except: :destroy do 
      collection do
        get 'location_info' => 'group_codes#location_info'
      end
    end
    resources :contents, except: :destroy do
      collection do
        get '/global' => 'contents#global'
        get '/home' => 'contents#home'
        get '/wedding' => 'contents#wedding'
        get '/prom' => 'contents#prom'
        get '/social-event' => 'contents#social_event'
        get '/quinceanera' => 'contents#quinceanera'
        get '/about' => 'contents#about'
        get '/contact' => 'contents#contact'
        get '/group_offers' => 'contents#group_offers'
        get '/other' => 'contents#other'
      end
    end 
  end

end
