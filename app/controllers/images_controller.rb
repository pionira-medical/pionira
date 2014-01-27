class ImagesController < ApplicationController
  def create
  	if !params[:qqfile].blank?
      order = Order.find(params[:order_id])
      image = order.images.build
      image.file = params[:qqfile]
      if image.save
        render :text => '{"success": true}'
      else
        render :text => '{"success": false}'
      end
    end
  end

  def destroy
    Order.find(params[:order_id]).images.delete_all
  end
end
