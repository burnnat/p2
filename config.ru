use Rack::Static,
	:urls => [""],
	:root => "repository",
	:index => "index.html"

run lambda {|*|}