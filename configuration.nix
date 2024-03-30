# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # <home-manager/nixos>
    ];

  # Bootloader.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
#     autorun = false;
 
     desktopManager = {
       xterm.enable = false;
     };
 
     displayManager = {
        defaultSession = "none+i3";
	startx.enable = true;
     };
     windowManager.i3 = {
       enable = true;
       package = pkgs.i3-gaps;
       extraPackages = with pkgs; [
         dmenu
         i3status
         i3lock
         i3blocks
       ];
     };
  };

services.xrdp.enable = true;
services.xrdp.defaultWindowManager = "i3";
services.xrdp.openFirewall = true;

  # Configure keymap in X11
#   services.xserver = {
#     layout = "us";
#     xkbVariant = "";
#   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  services.picom.enable = true;

#   home-manager.users.andrew = { pkgs, ... }: {
#     programs.alacritty.enable = true;
#     services.picom.enable = true;

#     xsession.windowManager.i3 = {
#       enable = true;
#       package = pkgs.i3-gaps;
#       config = rec {
# 
#         keybindings = lib.mkOptionDefault{
#           "Mod1+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
#         };
#       };
#     };

#     home.stateVersion = "23.11";
#  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables = rec {
    TERMINAL = "terminator";
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
  #    vim 
  #    vimPlugins.nerdtree
  #    vimPlugins.gruvbox
  #    vimPlugins.coc-python
  ((vim_configurable.override {  }).customize{
        name = "vim";
        # Install plugins for example for syntax highlighting of nix files
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ nerdtree gruvbox coc-python ];
          opt = [];
        };
        vimrcConfig.customRC = ''
          " your custom vimrc
          set nocompatible
          set backspace=indent,eol,start
          " Turn on syntax highlighting by default
          syntax on
          " ...
        '';
      }
    )
     R
     bc
     bitwarden
     cowsay
     delta
     emacs
     eza
     firefox
     fortune
     gcc
     gh
     git
     gnumake
     go
     htop
     jq
     libreoffice
     nerdfonts
     protobuf_23
     protobufc
     qbittorrent
     ranger
     ripgrep
     stow
     terminator
     terraform
     terraform
     tmux
     tree
     vscode
     wget
     feh
     zenith
     zsh
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs = {
    thunar.enable = true;
  };


  # List services that you want to enable:

  # Enable the OpenSSH daemon.
    services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
