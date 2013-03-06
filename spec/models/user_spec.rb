require 'spec_helper_model'
require 'omniauth'
require 'support/github'

describe User do
  let(:user) { User.create_from_omniauth(GithubData.user) }

  describe '.create_from_omniauth' do
    it 'gets the email' do
      user.email.should == 'test@innku.com'
    end
    it 'get the provider' do
      user.provider.should == 'github'
    end
    it 'gets the user id' do
      user.uid.should == 333
    end
    it 'gets the name' do
      user.name.should == "test_user"
    end
    it "gets the image url" do
      user.image_url.should == "https://secure.gravatar.com/avatar/333?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    end
  end

  describe "#valid?" do
    it 'is valid with full attributes' do
      user.valid?.should == true
    end
    it 'is invalid with erroneous email' do
      user.email = "whataburger"
      user.valid?.should == false
    end
  end

  describe "#as_json" do
    it 'only includes the specified keys' do
      user = User.create_from_omniauth(GithubData.user)
      user.as_json.keys.sort.should == ["email", "id", "image_url", "name", "preferences"]
    end
  end

end
