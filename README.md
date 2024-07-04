# Nix Config

## Switch Commands
Build for laptop
```bash
sudo nixos-rebuild switch --flake ./#nixos-laptop
```

Build for desktop
```bash
sudo nixos-rebuild switch --flake ./#nixos-desktop
```

Build for VM
```bash
sudo nixos-rebuild switch --flake ./#nixos-hyperv-vm
```

## Install command
```bash
sudo ./install.sh
```

## Future Development
Create third flake profile for non nix-os machines

