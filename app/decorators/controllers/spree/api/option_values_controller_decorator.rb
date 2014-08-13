Spree::Api::OptionValuesController.class_eval do
  def index
    if params[:ids]
      @option_values = scope.where(:id => params[:ids].split(','))
    else
      @option_values = scope.ransack(params[:q]).result
    end
    respond_with(@option_values)
  end
end

