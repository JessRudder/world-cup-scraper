class TeamScraper
  attr_accessor :index_url
  attr_reader :team_urls, :doc

  def initialize(index_url)
    @index_url = index_url
    @doc = Nokogiri::HTML(open(index_url))
    scrape_team_urls
  end
  
  def scrape_team_urls
    @team_urls ||= doc.search("div.team-qualifiedteams a").collect{|a| normalize_team_url(a["href"])}.uniq.compact
  end

  def scrape_teams
    team_urls.collect{|url| Team.new(url)}
  end
  
  private
    def normalize_team_url(url)
      url.start_with?("http://") ? url : "http://www.fifa.com#{url}"
    end
end