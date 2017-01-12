Deface::Override.new(
 :virtual_path => 'spree/layouts/admin',
 :name => 'custom-admin-tab',
 :insert_after => "nav#admin-menu",
 :text => '<a href="/catalog/admin/leads">Leads</a>'
)