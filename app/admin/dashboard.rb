ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
  #   div :class => "blank_slate_container", :id => "dashboard_default_message" do
  #     span :class => "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Die neuesten Aufträge" do
          ul do
            Order.last(5).map do |order|
              li link_to("#{order.hospital}, #{order.city}", admin_order_path(order))
            end
          end
        end
      end
      column do
        panel "Nächste Auslieferungen" do
          ul do
            Order.where("delivered_at < '#{DateTime.now.to_s}'").limit(5).order('delivered_at asc').map do |order|
              li link_to("#{l(order.delivered_at, format: :long)}: #{order.hospital}, #{order.city}", admin_order_path(order))
            end
          end
        end
      end
    end
  end
end
