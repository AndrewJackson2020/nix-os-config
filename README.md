# Nix Config

## Commands
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

## Future Development
Create third flake profile for non nix-os machines

