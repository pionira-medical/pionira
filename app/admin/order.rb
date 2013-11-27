ActiveAdmin.register Order do
  menu priority: 2

  index do
    column :id
    column :hospital
    column :city
    column :created_at
    default_actions
  end

  show do
    attributes_table do
      row :id
      row :hospital
      row :department
      row :street_1
      row :street_2
      row :zip
      row :city
      row :country, :as => :string
      row :gender
      row :title
      row :first_name
      row :last_name
      row :email
      row :phone
      row :reference
      row :security_key
    end
    table_for order.images do
      column "Image" do |i| image_tag(i.file.url(:thumb)) end
      column "Size" do |i| number_to_human_size(i.file_file_size) end
      column "Type" do |i| i.file_content_type end
      column "Created At" do |i| i.created_at end
    end
    active_admin_comments
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Order Details" do
      f.input :hospital
      f.input :department
      f.input :street_1
      f.input :street_2
      f.input :zip
      f.input :city
      f.input :country, :as => :string
      f.input :gender
      f.input :title
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :reference
      f.input :security_key
    end
    f.inputs do
      f.has_many :images do |ff|
        ff.input :file, :as => :file, :hint => f.template.image_tag(ff.object.file.url(:thumb))
      end
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit order: [:hospital, :department, :street_1, :street_2, :zip, :city, :country, :gender, :title,
        :first_name, :last_name, :email, :phone, :reference, :security_key, images_attributes: [:id, :file]]
    end
  end
end
