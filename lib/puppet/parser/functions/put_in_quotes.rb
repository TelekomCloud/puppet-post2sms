# Helper function to put a regular string into double quotes
# in  = hello " world
# out = "hello \" world"
Puppet::Parser::Functions::newfunction(:put_in_quotes, :type => :rvalue) do |vals|
  vals.map do |s|
    '"' + s.gsub('\\','\\\\\\\\').gsub('"','\"') + '"'
  end
end