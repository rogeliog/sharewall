class UserMailer < ActionMailer::Base
  default from: "sharewall@innku.com"

  def newsletter(links, user)
    @top_link = links.first
    @links = links[1..-1]
    mail(:subject => "This week on sharewall", :to => user.email)
  end

end
