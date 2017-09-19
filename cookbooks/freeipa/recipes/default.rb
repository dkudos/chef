#
# Cookbook:: freeipa
# Recipe:: default
#
ipa_admin_password = node["freeipa"]["ipa_admin_password"]
hostname = node["freeipa"]["hostname"] 
domain = node["freeipa"]["domain"] 
dir_manager_password = node["freeipa"]["dir_manager_password"] 
realm_name = node["freeipa"]["realm_name"]

package "freeipa-server" do
  retries 3
  timeout 1800
  retry_delay 10
  action [:install]
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  ipa-server-install -r #{realm_name} -n #{domain} -p #{dir_manager_password} -a #{ipa_admin_password} --no-ntp --no-hbac-allow -U
  EOH
