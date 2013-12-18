class PriceChecksController < ApiController
  before_filter :find_price_check, :except => [:index, :create]

  def index
    respond_with PriceCheck.all
  end

  def create
    respond_with PriceCheck.create price_check_params
  end

  def show
    respond_with @price_check
  end

  def update
    respond_with @price_check.update_attributes price_check_params
  end

  def destroy
    respond_with @price_check.destroy
  end

  protected
  def find_price_check
    @price_check = PriceCheck.find params[:id]
  end

  def price_check_params
    {
      :make => params[:make],
      :model => params[:model],
      :year => params[:year],
    }
  end

  def price_check_url(price_check)
    price_checks_path price_check
  end
end
