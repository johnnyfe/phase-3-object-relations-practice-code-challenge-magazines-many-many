class Reader < ActiveRecord::Base
  has_many :subscriptions
  has_many :magazines, through: :subscriptions

  def subscribe(price:, magazine:)
    new_magazine = Magazine.find_by(title: magazine)
    magazine_id = new_magazine.id
    new_reader = Reader.find_by(name: self.name)
    reader_id = new_reader.id
    new_subscription = Subscription.new(price: price, magazine_id: magazine_id, reader_id: reader_id)
    new_subscription
  end

  def total_subscription_price
    self.subscriptions.sum(:price)
  end

  def cancel_subscription(magazine:)
    new_magazine = Magazine.find_by(title: magazine)
    magazine_id = new_magazine.id
    delete_subscription = Subscription.find_by(magazine_id: magazine_id)
    delete_subscription.destroy
  end

end