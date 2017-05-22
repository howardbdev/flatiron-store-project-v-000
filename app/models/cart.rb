class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

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
end
