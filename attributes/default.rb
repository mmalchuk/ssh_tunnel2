default[:ssh_tunnel][:list] = [
{
	:name => "default_tunnel",
	:enabled => false,
	:config => {
		:loc_addr => "127.0.0.1",
		:loc_port => "",
		:gw_addr => "",
		:gw_port => "22",
		:gw_user => "root",
		:rem_addr => "",
		:rem_port => "",
		:private_key => ""
	},
	:action => 'start'
},
{
	:name => "start tunnel for pop3 @192.168.0.100",
	:enabled => false,
	:config => {
		:loc_addr => "127.0.0.1",
		:loc_port => "10110",
		:gw_addr => "192.168.0.1",
		:gw_port => "22",
		:gw_user => "root",
		:rem_addr => "192.168.0.100",
		:rem_port => "110",
		:private_key => "-----BEGIN RSA PRIVATE KEY-----
some pem-encoded data
-----END RSA PRIVATE KEY-----"
	},
	:action => 'start'
},
{
	:name => "stop tunnel for pop3 @192.168.0.100",
	:enabled => false,
	:config => {
		:loc_addr => "127.0.0.1",
		:loc_port => "10110",
		:gw_addr => "192.168.0.1",
		:gw_port => "22",
		:gw_user => "root",
		:rem_addr => "192.168.0.100",
		:rem_port => "110",
		:private_key => "-----BEGIN RSA PRIVATE KEY-----
some pem-encoded data
-----END RSA PRIVATE KEY-----"
	},
	:action => 'stop'
},
{
	:name => "restart all tunnels",
	:enabled => false,
	:config => {
		:loc_addr => "127.0.0.1",
		:loc_port => "10110",
		:gw_addr => "192.168.0.1",
		:gw_port => "22",
		:gw_user => "root",
		:rem_addr => "192.168.0.100",
		:rem_port => "110",
		:private_key => "-----BEGIN RSA PRIVATE KEY-----
some pem-encoded data
-----END RSA PRIVATE KEY-----"
	},
	:action => 'restartall'
},
{
	:name => "stop all tunnels",
	:enabled => true,
	:config => {
		:loc_addr => "127.0.0.1",
		:loc_port => "10110",
		:gw_addr => "192.168.0.1",
		:gw_port => "22",
		:gw_user => "root",
		:rem_addr => "192.168.0.100",
		:rem_port => "110",
		:private_key => "-----BEGIN RSA PRIVATE KEY-----
some pem-encoded data
-----END RSA PRIVATE KEY-----"
	},
	:action => 'stopall'
}
]
