# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.alsformalwear.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/about', :changefreq => 'weekly'
  add '/byt', :changefreq => 'weekly'
  add '/catalog', :changefreq => 'daily'
  add '/catalog/account', :changefreq => 'daily'
  add '/catalog/byt', :changefreq => 'daily'
  add '/catalog/login', :changefreq => 'daily'
  add '/catalog/products', :changefreq => 'daily'
  add '/contact', :changefreq => 'weekly'
  add '/discount', :changefreq => 'weekly'
  add '/events', :changefreq => 'weekly'
  add '/group-offers', :changefreq => 'weekly'
  add '/locations', :changefreq => 'weekly'
  add '/measurements', :changefreq => 'weekly'
  add '/out-of-town-measurements', :changefreq => 'weekly'
  add '/prom', :changefreq => 'weekly'
  add '/social-event', :changefreq => 'weekly'
  add '/terms-and-privacy', :changefreq => 'weekly'
  add '/quinceanera', :changefreq => 'weekly'
  add '/wedding', :changefreq => 'weekly'

  Spree::Variant.find_each do |variant|
    unless variant.is_master? 
      add variant.path, :changefreq => 'daily'
    end 
  end
end