default["java"]["install_flavor"] = "oracle"
default["java"]["jdk_version"] = 7
default["java"]["oracle"]["accept_oracle_download_terms"] = true

default['tizen']['wearable-sdk']['version']    = '1.0.0b1'
default['tizen']['wearable-sdk']['home']       = '/usr/local/tizen-wearable-sdk'

# user needs passwordless sudo to complete install
default['tizen']['wearable-sdk']['user']       = 'ec2-user'
default['tizen']['wearable-sdk']['group']      = 'ec2-user'

default['tizen']['wearable-sdk']['image']['url']        = 'https://download.tizen.org/sdk/Wearable/sdk-images/1.0.0b1/tizen-wearable-sdk-image-1.0.0b1-ubuntu64.zip'
default['tizen']['wearable-sdk']['image']['checksum']   = '790e191132448a5a83198dbecfe5bd96e7ae2308ee38cce89203e04fdb30ce51'
default['tizen']['wearable-sdk']['install-manager']['url']        = 'https://download.tizen.org/sdk/Wearable/InstallManager/1.0.0b1/tizen-wearable-sdk-2.2.150_ubuntu64.bin'
default['tizen']['wearable-sdk']['install-manager']['checksum']   = '6185d852632efb3f65f3e7da5261946a88d40e3b2c5a4f046be0bd9c6e42dd4c'
