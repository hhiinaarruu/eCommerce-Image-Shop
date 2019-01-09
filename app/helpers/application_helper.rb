module ApplicationHelper
  def cart_count_over_one
    if total_cart_items > 0
      return "<span class='tag is-dark'>#{total_cart_items}</span>".html_safe
    end
  end

  def total_cart_items
    return 0 unless @cart
    @cart.line_items.map { |item| item.quantity }.sum
  end
end
