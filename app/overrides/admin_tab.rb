Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "media_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :partial => "spree/admin/media_tab",
                     :disabled => false)