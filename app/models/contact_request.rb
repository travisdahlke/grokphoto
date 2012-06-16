class ContactRequest < ActiveRecord::Base
  
  # ****
  # Validations
  validates :email, :presence => true, :length => { :within => 5..100 }
  validates :name, :length => { :within => 2..64, :allow_blank => true }
  validates :message, :presence => true, :length => { :minimum => 10 }

  # ****
  # Mass-assignment protection
  attr_accessible :email, :name, :message

  # ****
  # Named scopes
  scope :unread, where(:read => false)
  scope :read, where(:read => true)

  # ****
  # Pagination
  paginates_per 16
  
  # ****
  # Logging
  after_create :log_create_event
  after_create :send_email
  
  private #----
    
    def log_create_event
      Event.create(:description => "Contact request from: #{email}")
    end

    def send_email
      NotificationsMailer.new_contact_request(self).deliver
    end
    
end
