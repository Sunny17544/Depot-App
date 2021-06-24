class CheckoutsController < ApplicationController

  include ApplicationHelper
  before_action :set_checkout, only: %i[ show edit update destroy ]
  before_action :current_order, only: [:create, :update]
  
  # GET /checkouts or /checkouts.json
  def index
    @checkouts = Checkout.all
  end

  # GET /checkouts/1 or /checkouts/1.json
  def show
  end

  # GET /checkouts/new
  def new
    @checkout=@order_items
    if @checkout.nil?
      @checkout = Checkout.new
    else
      redirect_to edit_checkout_path(@checkout.id)
    end
  end

  # GET /checkouts/1/edit
  def edit
    @checkout = Checkout.find(params[:id])
  end

  # POST /checkouts or /checkouts.json
  def create

    @checkout = Checkout.new(checkout_params)

    respond_to do |format|
      if @checkout.save
        @order.order_items.each do |line_item|
          @checkout.order_items.create!(name: line_item.product.product_id,quantity: line_item.quantity,price: line_item.product.price)
        end
        #@total=(@checkout.order_items.sum { |x| x['quantity']*x['price'] } ) * 100 
      begin
        customer=Stripe::Customer.create({email: params[:stripeEmail],source: params[:stripeToken]})
        charge=Stripe::Charge.create({customer: customer.id,amount: @total.to_i,currency: 'inr' })
        rescue Stripe::CardError => e
          return redirect_to edit_checkout_path(@checkout)
      end
      if charge.status == "succeeded"
        session[:order_id]=nil
        @checkout.payments.create!(chargeid: charge.id,status: charge.status,amount: (charge.amount)/100 )
      end
        format.html { redirect_to @checkout, notice: "Checkout was successfully created." }
        format.json { render :show, status: :created, location: @checkout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkouts/1 or /checkouts/1.json
  def update
    @checkout=CHeckout.find(params[:id])
    respond_to do |format|
      if @checkout.update(checkout_params)
        @checkout.order_items.destroy_all
          @card.order_items.each do |line_item|
            @checkout.order_items.create!(name: line_item.product.product_id,quantity: line_item.quantity,price: line_item.product.price)
          end
          #@total=(@checkout.order_items.sum { |x| x['quantity']*x['price'] } ) * 100 
        begin
          customer=Stripe::Customer.create({email: params[:stripeEmail],source: params[:stripeToken]})
          charge=Stripe::Charge.create({customer: customer.id,amount: @total.to_i,currency: 'inr' })
          rescue Stripe::CardError => e
            return redirect_to edit_checkout_path(@checkout)
        end
        if charge.status == "succeeded"
          session[:order_id]=nil
        end
        format.html { redirect_to @checkout, notice: "Checkout was successfully updated." }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1 or /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: "Checkout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def checkout_params
      params.require(:checkout).permit(:name, :address, :email, :pay_type)
    end
end
