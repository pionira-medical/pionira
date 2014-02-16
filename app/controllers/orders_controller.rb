class OrdersController < ApplicationController
  include OrdersHelper
  require 'zip'

  before_filter :redirect_if_not_authenticated, only: [:show, :update]
  before_filter :redirect_if_authenticated, only: [:sign_in]

  def index
    if params[:id].blank? || Order.exists?(params[:id])
      @order_id = params[:id]
    else
      flash.now[:danger] = t('error_occured')
      @errors = {id: t('orders.sign_in.id_error')}
    end
  end

  def show
  	@order = Order.find_by(id: session[:order_id], security_key: session[:order_security_key])
  end

  def update
    @order = Order.find_by(id: session[:order_id], security_key: session[:order_security_key])
    @order.update(order_params)
  end

  def download
    @order = Order.find(params[:id])
    zipfile_name = "#{Rails.root.join("public/system/archives").to_s}/pionira-order_#{@order.id}.zip"

    index = 1
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      @order.images.each do |image|
        filename_suffix = "%03d" % index
        zipfile.add("pionira-order_#{@order.id}-#{filename_suffix}", image.file.path)
        index += 1
      end
    end
    send_file zipfile_name, type: 'application/zip'
  end

  def destroy_images
    order = Order.find_by(id: session[:order_id], security_key: session[:order_security_key])
    order.images.delete_all unless order.blank?
    redirect_to({action: :show, id: order.id})
  end

  def sign_in
    render action: :index
  end

  def authenticate
    if order = Order.find_by(id: params[:id], security_key: params[:security_key])
  	  session[:order_id] = order.id
  	  session[:order_security_key] = order.security_key
  	  redirect_to({action: :show, id: order.id}, {success: t('orders.authenticate.signed_in')})
  	else
  	  @order_id = params[:id]
  	  @errors = {security_key: t('orders.authenticate.security_key_not_valid')}
      render action: :index
  	end
  end

  def request_security_key
    if order = Order.find_by(id: params[:id])
      OrderMailer.request_security_key(order).deliver
      @order_id = order.id
      flash.now[:success] = t('orders.request_security_key.send')
    else
      flash.now[:danger] = t('orders.request_security_key.failed')
    end
    render action: :index
  end

  private
  def order_params
    params.require(:order).permit(:reference, :phone, :email, :first_name, :last_name, :dr_title)
  end
end
