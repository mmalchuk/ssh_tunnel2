#
# Cookbook Name:: ssh_tunnel
# Recipe:: default
#
# Copyright 2012, Maksim Malchuk
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# install ssh package
package "ssh" do
	action :install
end

# process each rule
node[:ssh_tunnel][:list].each do |tun|

	Chef::Log.info "Prcessing #{tun[:name]}"

	if tun[:enabled] == true

		# convert some attr's to local var's
		gw_port = tun[:config][:gw_port].empty? ? '22' : tun[:config][:gw_port]
		gw_user = tun[:config][:gw_user].empty? ? 'root' : tun[:config][:gw_user]

		local = tun[:config][:loc_addr].empty? ? tun[:config][:loc_port] : tun[:config][:loc_addr] + ':' + tun[:config][:loc_port]
		remote = tun[:config][:rem_addr] + ':' + tun[:config][:rem_port]

		pattern = local + ':' + remote

		Chef::Log.info "Prcessing pattern: #{pattern}"

		# create some dir's
		directory "/etc/ssh_tunnel" do
			owner "root"
			group "root"
			mode "0751"
		end

		# create private key file
		template "/etc/ssh_tunnel/#{pattern}.pem" do
			source "default.pem.erb"
			owner "root"
			group "root"
			mode "0600"
			variables(
				:private_key => tun[:config][:private_key]
			)
		end

		# create daemon script
		template "/etc/ssh_tunnel/#{pattern}.sh" do
			source "default.sh.erb"
			owner "root"
			group "root"
			mode "0770"
			variables(
				:pattern => "#{pattern}",
				:gw_port => tun[:config][:gw_port],
				:gw_user => tun[:config][:gw_user],
				:gw_addr => tun[:config][:gw_addr]
			)
		end

		if tun[:action] == 'start'
			execute "ssh_tunnel:start" do
				command "/etc/ssh_tunnel/#{pattern}.sh &"
				action :run
			end
		end

		if tun[:action] == 'restart'
			execute "ssh_tunnel:restart" do
				command "ps xafu | grep 'ssh.*#{pattern}.pem' | grep -v grep | awk '{ print $2 }' | xargs -r kill -9 2>/dev/null"
				action :run
			end
		end

		if tun[:action] == 'restartall'
			execute "ssh_tunnel:restartall" do
				command "ps xafu | grep 'ssh.*.pem' | grep -v grep | awk '{ print $2 }' | xargs -r kill -9 2>/dev/null"
				action :run
			end
		end

		if tun[:action] == 'stop'
			execute "ssh_tunnel:stop" do
				command "ps xafu | grep '#{pattern}' | grep -v grep | awk '{ print $2 }' | xargs -r kill -9 2>/dev/null"
				action :run
			end
		end

		if tun[:action] == 'stopall'
			execute "ssh_tunnel:stopall" do
				command "ps xafu | grep 'ssh_tunnel' | grep -v grep | awk '{ print $2 }' | xargs -r kill -9 2>/dev/null"
				action :run
			end
		end

	end

end

