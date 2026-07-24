# dotfiles

## Hostname fix

macOS may silently override the local hostname via DHCP, remote
management, or other network signals. A LaunchDaemon checks every
60 seconds and restores the desired value.

### Setup

```sh
echo 'my-hostname' | sudo tee /etc/fix-hostname
sudo cp ~/.dotfiles/bin/fbfh /usr/local/bin/
sudo chown root:wheel /usr/local/bin/fbfh
sudo cp ~/.dotfiles/manual/LaunchDaemons/org.fbluemle.fbfh.plist /Library/LaunchDaemons/
sudo chown root:wheel /Library/LaunchDaemons/org.fbluemle.fbfh.plist
sudo launchctl bootstrap system/ /Library/LaunchDaemons/org.fbluemle.fbfh.plist
```

The script is copied to a root-owned location so the daemon never
executes a user-writable file as root.

### Removal

```sh
sudo launchctl bootout system/org.fbluemle.fbfh
sudo rm /Library/LaunchDaemons/org.fbluemle.fbfh.plist /usr/local/bin/fbfh
```

## License

[MIT](LICENSE)
