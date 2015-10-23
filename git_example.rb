class GitHubTest

  require 'rest-client'
  #github API basic URI
	BASE_URI= 'https://api.github.com'

	# Get the user name
	def user_name
		puts "Enter user name"
		@user = gets.chomp
    unless (@user =~ /^(?![-]{1})[a-z0-9-]*[a-z]{1}$/)
      puts "Incorrect name! Plese, try againe!"
      self.user_name
    end
	end

	# Get the repo name
	def repo_name
		puts "Enter name of repository"
    @repo = gets.chomp.gsub(/[-]{2,}/, '-')
    unless (@repo =~ /^(?![\s])+[a-z0-9_-]{1,}$/)
      puts "Incorrect repository name. Plese check it" 
      self.repo_name
    end
	end

	def valid(path = nil)
		 begin
			 puts "Getting the data from ===>  #{BASE_URI}/#{path}"
			 @request = JSON.parse(RestClient.get("#{BASE_URI}/#{path}"))
			 puts JSON.pretty_unparse(@request)
		 rescue  RestClient::ResourceNotFound
			 puts 'Not found'
		 end
	end

  #  ====== Exapmles ======
	def user_repos
		self.user_name
		self.valid("users/#{@user}/repos")
	end

  # All public repos ( get some first example repos)
	def public_repos
		self.valid("repositories")
	end

	# List of the user contributors
	def list_contributors
		self.user_name
		self.repo_name
		self.valid("repos/#{@user}/#{@repo}/contributors")
	end

end



#get an instance
example = GitHubTest.new
example.list_contributors

