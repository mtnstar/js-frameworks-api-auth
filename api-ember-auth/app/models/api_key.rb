class ApiKey < ActiveRecord::Base
  before_create :generate_access_token, :generate_client_id

  belongs_to :user

  def as_json(options = {})
    h = super(options)
    h.delete('id')
    h.delete('user_id')
    h
  end

  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  def generate_client_id
    begin
      self.client_id = SecureRandom.hex(4)
    end while self.class.exists?(client_id: client_id)
  end

end
