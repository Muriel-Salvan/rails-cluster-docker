#!/usr/local/bin/ruby
require 'sinatra'
set :bind, '0.0.0.0'
set :port, '3000'

def local_ip
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

  UDPSocket.open do |s|
    s.connect '64.233.187.99', 1
    s.addr.last
  end
ensure
  Socket.do_not_reverse_lookup = orig
end

get '/hi' do
  "Hostname: #{ Socket.gethostname } IP: #{ local_ip }"
end
