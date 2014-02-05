nbr_servers = ARGV[0].to_i

pipes_in = {}
nbr_servers.times do |idx|
  port = 5000 + idx
  pipe_cmd_in, pipe_cmd_out = IO.pipe
  cmd_pid = Process.spawn("docker run -p #{port}:3000 murielsalvan/server", :out => pipe_cmd_out, :err => pipe_cmd_out)
  puts "Launch server on port #{port}: PID=#{cmd_pid}"
  Process.detach(cmd_pid)
  pipe_cmd_out.close
  pipes_in[cmd_pid] = pipe_cmd_in
end
# Wait for all servers to be up
pipes_in.each do |pid, pipe_in|
  puts "Waiting for PID #{pid} to be listening..."
  found_info = false
  while !found_info
    out = pipe_in.readline.chomp
    puts out
    found_info = out.match(/WEBrick::HTTPServer/) != nil
    sleep 0.01 if !found_info
  end
end

puts 'All servers up and running.'

# Get their IP addresses
ips = []
`docker ps | sed -e 's/^\\(............\\).*$/\\1/' | tail -#{nbr_servers}`.split("\n").each do |container_id|
  ips << `docker inspect #{container_id} | grep IPAddress | sed -e 's/.*: \\"\\(.*\\)\\".*/\\1/g'`.chomp
end

puts ips.join(' ')
