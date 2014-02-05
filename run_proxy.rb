lst_ips = ARGV.clone
Process.wait(Process.spawn("docker run -p 3000:3000 -t murielsalvan/proxy ruby -w /root/run_proxy.rb #{lst_ips.join(' ')}"))
