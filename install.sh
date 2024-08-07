#!/usr/bin/env bash

# Check for NixOS
if grep -qi NixOS /etc/os-release; then
  echo "This is NixOS. "
  echo "Continuing with the GolluMOS installation."
  echo "---"
else
  echo "This is not NixOS or the distribution information is not available. ❌"
  exit 1
fi

# Check for Git
if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
else
  echo "Git is not installed. Please install it and try again."
  echo "  Example: nix-shell -p git"
  exit 1
fi

echo "---"

cd || exit
echo "Cloning GolluMOS Repository..."
git clone https://github.com/SpirytusWeDrinkin/GolluMOS.git

echo "---"

# Vérifiez si le répertoire ou le fichier .GolluMOS existe
if [ -e "$HOME/.GolluMOS" ]; then
    echo ".GolluMOS already exists."
    read -p "Do you want to overwrite it? (y/n): " overwrite
    if [ "$overwrite" != "y" ]; then
        echo "Installation aborted."
        exit 1
    fi
    rm -rf "$HOME/.GolluMOS"
fi

# Move and organize GolluMOS files
echo "Creating ~/.GollumOS, the configuration will be saved in this directory, feel free to modify it afterward"
mkdir -p .GolluMOS
cp -r GolluMOS/* .GolluMOS/
rm -rf GolluMOS .GolluMOS/.git  # Remove cloned directory

cd .GolluMOS || exit

echo "---"

# User information
username=$(whoami)
echo "Your username will remain the same: $username"

echo "---"

echo "Please answer the following, default values are shown in brackets"

echo "---"

read -p "Enter hostname: " hostname

read -p "Git username: " gitUsername

read -p "Git email: " gitEmail

# Configuration options with defaults
read -p "Locale [en_US.UTF-8]: " locale
locale=${locale:-en_US.UTF-8}

read -p "Keyboard layout [us]: " keyboardLayout
keyboardLayout=${keyboardLayout:-us}

read -p "Keyboard variant [ ]: " keyboardVariant
keyboardVariant=${keyboardVariant:-}

read -p "Timezone [Europe/London]: " timezone
timezone=${timezone:-Europe/London}

echo "---"

echo "⚠️ Warning: GPU configuration"
echo "  - Dual GPU setups (e.g., Intel + Nvidia) is easier to set up when choosing only the integrated GPU (Intel/AMD)."
echo "  - You can always update it later. Proceed with dual-GPU setup only if you know the correct GPU bus IDs."

read -p "GPU type: " gpuType

# Get bus IDs only for intel-nvidia
if [ "$gpuType" == "intel-nvidia" ]; then
  read -p "Intel bus ID (Format PCI:B:S:F in Base10): " intelBusId
  read -p "Nvidia bus ID (Format PCI:B:S:F in Base10): " nvidiaBusId
fi

echo "---"
echo "Available colorscheme include everforest, gruvbox-dark, rose-pine, dracula"
read -p "Color scheme [everforest]: " colorScheme
colorScheme=${colorScheme:-everforest}

# Create output directory and file path
outputFile="./options.nix"

# Write configuration file
cat <<EOL > "$outputFile"
{
  username = "${username}";
  hostname = "${hostname}";
  userHome = "/home/${username}";

  gitUsername = "$gitUsername";
  gitEmail = "$gitEmail";

  aLocale = "$locale";
  kbLayout = "$keyboardLayout";
  kbVariant = "$keyboardVariant";
  aTimezone = "$timezone";

  gpuType = "$gpuType";
EOL

# Add bus IDs for intel-nvidia
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

echo "Configuration file created successfully: $outputFile ️"
echo "---"

sleep 2

echo "Generating The Hardware Configuration... ️"
sudo nixos-generate-config --show-hardware-config > ./hardware.nix

echo "---"

echo "Now Going To Build GolluMOS, "
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#${hostname}

