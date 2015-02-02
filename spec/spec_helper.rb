require 'serverspec'
require 'net/ssh'
require 'tempfile'

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

host = ENV['TARGET_HOST']

if host != 'localhost'
  set :backend, :ssh

  config = Tempfile.new('', Dir.tmpdir)
  config.write(`vagrant ssh-config #{ENV['TARGET_HOST']}`)
  config.close

  options = Net::SSH::Config.for(host, [config.path])

  options[:user] ||= Etc.getlogin

  set :host,        options[:host_name] || host
  set :ssh_options, options
else
  set :backend, :exec
end
