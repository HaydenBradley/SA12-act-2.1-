require 'httparty'

def fetch_repositories(org_name)
  url = "https://api.github.com/orgs/#{org_name}/repos"
  response = HTTParty.get(url)
  if response.success?
    return JSON.parse(response.body)
  else
    puts "Failed to fetch repositories: #{response.code} - #{response.message}"
    return []
  end
end

def analyze_repositories(repositories)
  max_stars_repo = repositories.max_by { |repo| repo['stargazers_count'] }
  {
    name: max_stars_repo['name'],
    description: max_stars_repo['description'],
    stars: max_stars_repo['stargazers_count'],
    url: max_stars_repo['html_url']
  }
end

def display_most_starred_repo(repo)
  puts "Most Starred Repository:"
  puts "Name: #{repo[:name]}"
  puts "Description: #{repo[:description]}"
  puts "Stars: #{repo[:stars]}"
  puts "URL: #{repo[:url]}"
end


org_name = 'barchart'
repositories = fetch_repositories(org_name)
if repositories.any?
  most_starred_repo = analyze_repositories(repositories)
  display_most_starred_repo(most_starred_repo)
else
  puts "No repositories found for #{org_name}."
end