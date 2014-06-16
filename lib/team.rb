class Team
  attr_accessor :profile_url

  @@all = []

  def self.all
    @@all
  end

  def self.find_by_name(name)
    all.detect{|s| s.name == name}
  end

  def ==(other_team)
    self.profile_url == other_team.profile_url
  end

  def initialize(profile_url)
    @profile_url = profile_url
    @doc = Nokogiri::HTML(open(profile_url))
    @@all << self
  end

  def name
    @name ||= doc.search("span.fdh-flag img").collect{|i| i['alt']}[0]
  end

  # private 
    attr_reader :doc
end