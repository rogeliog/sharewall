desc 'Send Newsletters to users'
task send_newsletters: :environment do
  # Send newsletters on thursdays
  if Date.today.wday == 4
    links = Link.unscoped.recent.popular.limit(10)
    User.all.each do |user|
      if user.email && user.preferences[:newsletter]
        UserMailer.newsletter(links, user).deliver 
      end
    end
  end
end