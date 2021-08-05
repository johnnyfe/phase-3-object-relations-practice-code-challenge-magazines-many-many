class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        self.readers.each do |item|
            puts "#{item.email};"
        end
    end

    def self.most_popular
        # Magazine.all.max {|magazine| magazine.subscriptions.count}
        # Subscription.group('magazine_id').count
        Magazine.joins(:subscriptions).group('magazine_id').order('COUNT(magazines.id) DESC').limit(1)
    end
        
end