tizen Cookbook
=====================
This cookbook installs the Tizen build tools and Tizen Wearables SDK. Installing the Tizen SDK is a bit of a mess. Apparently, the developers of the SDK didn't really plan on having this happen from the command line without the help of a GUI, so there is a bit of hacking involved. But it works!

This cookbook was designed on Amazon Linux, so some changes may be needed for other OS's.

Requirements
------------
This cookbook depends on the following:
- `yum` - yum cookbook for installing packages
- `java` - java cookbook to install java to run the install package

Attributes
----------
#### tizen::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['version']</tt></td>
    <td>String</td>
    <td>Tizen Wearable SDK version</td>
    <td><tt>1.0.0b1</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['home']</tt></td>
    <td>String</td>
    <td>Tizen Wearable SDK main home dir. This will be a symlink to the versioned directory.</td>
    <td><tt>/usr/local/tizen/wearable-sdk</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['user']</tt></td>
    <td>String</td>
    <td>User to install the SDK with. The Tizen Wearable installer is kind of dumb and requires a user with passwordless sudo to complete the installation.</td>
    <td><tt>ec2-user</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['group']</tt></td>
    <td>String</td>
    <td>Group of the user to user for the installer</td>
    <td><tt>ec2-user</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['image']['url']</tt></td>
    <td>String</td>
    <td>URL to the Tizen Wearable SDK image</td>
    <td><tt>https://download.tizen.org/sdk/Wearable/sdk-images/1.0.0b1/tizen-wearable-sdk-image-1.0.0b1-ubuntu64.zip</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['image']['checksum']</tt></td>
    <td>String</td>
    <td>sha256 checksum of the image file</td>
    <td><tt>790e191132448a5a83198dbecfe5bd96e7ae2308ee38cce89203e04fdb30ce51</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['install-manager']['url']</tt></td>
    <td>String</td>
    <td>URL to the Tizen Wearable SDK install-manager</td>
    <td><tt>https://download.tizen.org/sdk/Wearable/InstallManager/1.0.0b1/tizen-wearable-sdk-2.2.150_ubuntu64.bin</tt></td>
  </tr>
  <tr>
    <td><tt>['tizen']['wearable-sdk']['install-manager']['checksum']</tt></td>
    <td>String</td>
    <td>sha256 checksum of the install-manager file</td>
    <td><tt>6185d852632efb3f65f3e7da5261946a88d40e3b2c5a4f046be0bd9c6e42dd4c</tt></td>
  </tr>
</table>

Usage
-----
#### tizen::default

This recipe sets up the Tizen yum repository and installs the "gbs" and "mic" packages from it.

Just include `tizen` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tizen]"
  ]
}
```

#### tizen::wearable-sdk

This recipe sets up the Tizen Wearable SDK.

Just include `tizen::wearable-sdk` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[tizen::wearable-sdk]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Joe Richards <nospam-github@disconformity.net>
