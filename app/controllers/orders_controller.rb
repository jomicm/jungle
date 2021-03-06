class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])    
    # @line_items = LineItem.where(order_id: params[:id])
    # @line_items = LineItem.joins(:products).where.not(products: { id: 'product_id' })
    # @line_items = LineItem.joins(:products).where(products: { id: time_range })
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      empty_cart!
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

  def order_items
    # @order_items ||= LineItem.where(order_id: params[:id]).map {|litem| { line_item:litem, product:Product.where(id:litem.product_id).first, order:Order.where(id:litem.order_id).first } }
    # p @order
    # @products = @order.includes(:product).find(params[:id])
    @order_items ||= LineItem.where(order_id: params[:id]).map {|litem| { line_item:litem, product: litem.product } }
  end
  helper_method :order_items

  def order_total
    @order_total ||= Order.where(id: params[:id]).first
  end
  helper_method :order_total

end
