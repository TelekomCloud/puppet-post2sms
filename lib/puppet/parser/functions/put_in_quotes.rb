#
# put_in_quotes.rb
#
module Puppet::Parser::Functions
  newfunction(:put_in_quotes, :type => :rvalue, :doc => <<-EOS
      Helper function to put a regular string into double quotes
      in  = hello " world
      out = "hello \" world"
      EOS
    ) do |arguments|

    raise(Puppet::ParseError, "put_in_quotes(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    value = arguments[0]

    raise(Puppet::ParseError, 'put_in_quotes(): Requires string to work ' +
      'with')  unless value.is_a?(String)

    '"' + value.gsub('\\','\\\\\\\\').gsub('"','\"') + '"'
  end
end