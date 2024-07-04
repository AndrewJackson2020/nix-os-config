# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # <home-manager/nixos>
    ];

  # Bootloader.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

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
 
     desktopManager = {
       xterm.enable = false;
       gnome.enable = true;
     };
 
     displayManager = {
        defaultSession = "gnome";
	gdm.enable = true;
	startx.enable = true;
     	# lightdm = {
	#   enable = true;
	#   greeter.enable = true;
	# };
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
  services.openssh.enable = true;

  services.xrdp = {
    enable = true;
    defaultWindowManager = "i3";
    openFirewall = true;
  };
  services.picom.enable = true;

  users.users.andrew = {
    isNormalUser = true;
    description = "Andrew";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    	qemu
    ];
  };
  users.users.fei = {
    isNormalUser = true;
    description = "Mommy Bear";
    extraGroups = [ "networkmanager" ];
  };
  users.users.bunbun = {
    isNormalUser = true;
    description = "Baby Bun";
    extraGroups = [ "networkmanager" ];
  };
  users.users.babybear = {
    isNormalUser = true;
    description = "Bun Bear";
    extraGroups = [ "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;
 
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
  };

  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
  };
  
  fonts.packages = with pkgs; [
    nerdfonts
  ];
  environment.systemPackages = with pkgs; [
  ((vim_configurable.override {  }).customize{
        name = "vim";
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
  ];

  programs = {
    thunar.enable = true;
  };

  system.stateVersion = "23.11";

}
