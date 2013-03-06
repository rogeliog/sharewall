class User < ActiveRecord::Base
  DEFAULT_PREFERENCES = {newsletter: true}

  attr_accessible :name, :id, :image_url, :email, :preferences
  serialize :preferences, Hash

  validates :email, email_format: true, allow_nil: true, uniqueness: true
  has_many  :links

  # Set here because serialized db defaults do not work
  before_create lambda {|user| user.preferences = DEFAULT_PREFERENCES }

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
      user.name = auth["info"]["nickname"]
      user.image_url = auth["extra"]["raw_info"]["avatar_url"]
    end
  end

  def to_s
    self.name
  end

  def as_json(options={})
    super(only: [:name, :id, :image_url, :email, :preferences])
  end

end
