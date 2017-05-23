class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  has_many :orders

  def total
    sum = 0
    self.line_items.each do |li|
      sum += (li.quantity * li.item.price)
    end
    sum
  end

  def add_item(item_id)
    li = self.line_items.find_by(item_id: item_id)
    if li
      li.quantity += 1
      li
    else
      self.line_items.build(item_id: item_id)
    end
  end

  def process_cart_submission
    self.update(status: "submitted")
    self.line_items.each do |line_item|
      new_inventory = line_item.item.inventory - line_item.quantity
      line_item.item.update(inventory: new_inventory)
    end
  end
end
