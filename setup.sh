#!/usr/bin/env bash

echo "This scripts fully installs the lab environment on a Ubuntu machine."
echo "Tested on Ubuntu Desktop 20.04 with the setup described in setup.md."
echo "During the setup procedure you will see plenty of warnings about apt not having a stable interface."
echo "You may safely ignore these warnings."

# Exit immediately if there's an error
set -e

##
# Method definitions

# Install packages from aptitude
# Usage: install package1 package2
function install() {
  packages="$*"
  echo "Installing $packages."
  sudo apt install -y $packages > /dev/null
}

##
# Install guest additions

echo "===== Installing VirtualBox Guest Additions ====="

# Install dependencies for the guest additions and hide the output (keep warnings etc.)
sudo apt update > /dev/null
install build-essential dkms "linux-headers-$(uname -r)"

echo "Please insert the guest additions ISO."
echo "The option is available via the menu bar option Devices > Insert Guest Additions CD image..."
echo "When prompted, run the script and follow the on-screen instructions."
echo "When the installation has concluded, please press enter."

read -p "Press enter to continue: "

# Try to unmount the guest additions disk
sudo umount "$(find /media -maxdepth 2 -mindepth 2)" || :

# Fix VirtualBox shared clipboard support
# See: https://www.virtualbox.org/ticket/19336
echo "When prompted for (Y/I/N/O/D/Z), please enter the character 'Y' and press enter."
echo "Note that the following 'Press enter to continue' prompt is not the prompt you're looking for."
read -p "Press enter to continue: "
sudo apt install -y virtualbox-guest-x11 > /dev/null
sudo VBoxClient --clipboard

##
# Install development dependencies

echo "===== Installing Development Dependencies ====="

# Install Python 3.9 and related dependencies
install python3.9 python3-pil python3-pip python3.9-dev python3.9-venv

echo "Installing Python packages"
python3.9 -m pip install numpy matplotlib pandas plotly psutil pillow > /dev/null

# Install tools for network requests
install curl wget

# Install dependencies for some PPAs
install apt-transport-https

# Install development tools
install shellcheck

##
# Install editors

echo "===== Installing Editors ====="

# Install Atom
# See: https://flight-manual.atom.io/getting-started/sections/installing-atom/#platform-linux
wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt update > /dev/null
install atom

# Install Atom plugins
echo "Installing Atom plugins"
apm install atom-ide-ui autocomplete-bash-builtins file-icons ide-html ide-css ide-json ide-python ide-typescript linter-shellcheck minimap pigments > /dev/null

# Install Visual Studio Code
# See: https://code.visualstudio.com/docs/setup/linux
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update > /dev/null
install code
rm -f packages.microsoft.gpg 2> /dev/null || :

##
# Finish the setup

# Remove the script itself
rm "$0" 2> /dev/null || :

# Clear the bash history
rm $(find /home/ -iname ".bash_history") 2> /dev/null || :

echo "The setup has completed. The virtual machine will now be restarted."
read -p "Press enter to restart: "
sudo shutdown -r now
