module GithubData
  def self.user
    YAML.load_file(fixture('github_user.yml'))
  end
end