module ApplicationHelper
  def cart_count_over_one
    "<span class='tag is-dark'>#{total_cart_items}</span>".html_safe if total_cart_items > 0
  end

  def total_cart_items
    return 0 unless @cart
    @cart.line_items.map(&:quantity).sum
  end
end
