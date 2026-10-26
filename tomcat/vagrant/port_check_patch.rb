# port_check_patch.rb
# Workaround for a Vagrant 2.4.9 bug on macOS 26.7 and later (hashicorp/vagrant#13845):
# Vagrant's port check reports every forwarded host port as "already in use".
# This replaces the check with a plain connect, which fails correctly when nothing listens.
# On other hosts it behaves exactly like the original check.
require "socket"
require "timeout"
begin
  require "vagrant/util/is_port_open"
rescue LoadError
  # outside Vagrant (only used when testing this file on its own)
end

module Vagrant
  module Util
    module IsPortOpen
      def is_port_open?(host, port)
        Timeout.timeout(1) do
          TCPSocket.new(host, port).close
          true
        end
      rescue Timeout::Error, Errno::ECONNREFUSED, Errno::EHOSTUNREACH,
             Errno::ENETUNREACH, Errno::EADDRNOTAVAIL, Errno::ECONNRESET
        false
      end
      module_function :is_port_open?
    end
  end
end
