class User < ActiveRecord::Base
  attr_accessible :name, :id, :image_url

  has_many :links


  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.image_url = auth[:extra][:raw_info][:avatar_url]
    end
  end

  def to_s
    self.name
  end

  def as_json
    {
      name: name,
      id: id,
      image_url: image_url
    }
  end

end
