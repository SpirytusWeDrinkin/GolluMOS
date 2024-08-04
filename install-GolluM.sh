#!/usr/bin/env bash

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
    echo "This is NixOS. 👍"
    echo "Continuing with the GolluMOS installation."
    echo "-----"
else
    echo "This is not NixOS or the distribution information is not available. ❌"
    exit
fi

if command -v git &> /dev/null; then
    echo "Git is installed, continuing with installation. ✅"
else
    echo "Git is not installed. Please install Git and try again."
    echo "Example: nix-shell -p git"
    exit 1
fi

echo "-----"

echo "Cloning GolluMOS Repository... 🚀"
git clone https://github.com/SpirytusWeDrinkin/GolluMOS.git

echo "-----"

# Create .GolluMOS directory and copy repository content into it
mkdir -p .GolluMOS
cp -r GolluMOS/* .GolluMOS/
rm -rf GolluMOS .GolluMOS/.git/  # Remove the cloned directory

# Change to the new directory
cd .GolluMOS || exit

echo "-----"

# Prompt for variables from the user
read -p "Enter username: " setUsername
echo "-----"
read -p "Enter hostname: " setHostname
echo "-----"
read -p "Enter Git user name: " gitUsername
echo "-----"
read -p "Enter Git email: " gitEmail
echo "-----"
read -p "Use 24h clock (true/false): " clock24h
echo "-----"
read -p "Enter locale (e.g., en_US.UTF-8): " aLocale
echo "-----"
read -p "Enter keyboard layout (e.g., us): " kbLayout
echo "-----"
read -p "Enter keyboard variant (e.g., intl): " kbVariant
echo "-----"
read -p "Enter timezone (e.g., Europe/Paris): " aTimezone
echo "-----"

# Provide a warning about GPU configuration
echo "⚠️ Warning: You are going to select the GPU type, if you are using a dual GPU setup (e.g., Intel + Nvidia),"
echo "it is generally recommended to choose only the integrated GPU for now (e.g., Intel or AMD)."
echo "You can always update the GPU configuration later but can proceed now if you know the correct bus IDs."
echo "-----"

read -p "Enter GPU type (e.g., intel-nvidia): " gpuType
echo "-----"

# Ask for Intel and Nvidia bus IDs only if GPU type is intel-nvidia
if [ "$gpuType" == "intel-nvidia" ]; then
    read -p "Enter Intel bus ID (e.g., PCI:0:2:0): " intelBusId
    echo "-----"
    read -p "Enter Nvidia bus ID (e.g., PCI:1:0:0): " nvidiaBusId
    echo "-----"
fi

read -p "Enter color scheme (e.g., gruvbox-dark): " colorScheme
echo "-----"

# Create the directory for the hostname
outputDir="./hosts/${setHostname}"
mkdir -p "$outputDir"

# Output file path
outputFile="${outputDir}/options.nix"

# Create the configuration file
cat <<EOL > "$outputFile"
{
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";

  gitUsername = "$gitUsername";
  gitEmail = "$gitEmail";

  clock24h = $clock24h;
  aLocale = "$aLocale";
  kbLayout = "$kbLayout";
  kbVariant = "$kbVariant";
  aTimezone = "$aTimezone";

  gpuType = "$gpuType";
EOL

# Add Intel and Nvidia bus IDs if GPU type is intel-nvidia
if [ "$gpuType" == "intel-nvidia" ]; then
  cat <<EOL >> "$outputFile"
  intel-bus-id = "$intelBusId";
  nvidia-bus-id = "$nvidiaBusId";
EOL
fi

cat <<EOL >> "$outputFile"
  colorScheme = "$colorScheme";
}
EOL

echo "The configuration file has been created successfully: $outputFile 🗂️"
echo "-----"

echo "The password for a new user is password 🔐"
sleep 2

echo "-----"

echo "Generating The Hardware Configuration... 🛠️"
sudo nixos-generate-config --show-hardware-config > '${outputDir}/hardware.nix'

echo "-----"

echo "Now Going To Build GolluMOS, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#${setHostname}

