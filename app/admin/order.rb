ActiveAdmin.register Order do
  menu priority: 2

  index do
    column :id
    column :hospital
    column :city
    column :created_at
    default_actions
  end

  form do |f|
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
    f.actions
  end

  controller do
    def permitted_params
      params.permit order: [:hospital, :department, :street_1, :street_2, :zip, :city, :country,
        :gender, :title, :first_name, :last_name, :email, :phone, :reference_1, :reference_2, :security_key]
    end
  end
end
