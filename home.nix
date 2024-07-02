
{ lib, config, pkgs, ... }:

let
  # TODO: Need to find stable url
  # debian_iso = pkgs.fetchurl {
  #   url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso";
  #   hash = "sha256-AT9bRGcNgSgLWxvAJFWEKyUN8vDGdjOY/raa8agFoU8=";
  # };
  arch_iso = pkgs.fetchurl {
    url = "https://mirror.arizona.edu/archlinux/iso/2024.06.01/";
    hash = "sha256-tkrce0Pzoc+gJ111eAuAjLzcHZBUB4tGUjmuYNVuSec=";
  };
  temple_os_iso = pkgs.fetchurl {
    url = "https://www.templeos.org/Downloads/TOS_Distro.ISO";
    hash = "sha256-PGjKOV0LZPd58f+jMOJoV5ixeGLjw2rk40lTf9Z2tAs=";
  };
  rocky9_iso = pkgs.fetchurl {
    url = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.4-x86_64-minimal.iso";
    hash = "sha256-7jrJf9/6tYZSQhlBWZkCASF5w3U1rs52gkZzEFFpxKI=";
  };
  terraform_src = pkgs.fetchzip {
    url = "https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip";
    hash = "sha256-eoPAIM4FtC0fAwW851ouiZpL8hkQ/whKanI26xOX+9M=";
  };
  go_src = pkgs.fetchzip {
    url = "https://go.dev/dl/go1.22.0.linux-amd64.tar.gz";
    hash = "sha256-gRj8ZbcTc7rK8jVDxi13izHcIbbwjFx9hS4GIm7l9ks=";
  };
  eza_src = pkgs.fetchzip {
    url = "https://github.com/eza-community/eza/releases/download/v0.18.9/eza_x86_64-unknown-linux-musl.zip";
    hash = "sha256-xOCRbBgNbaOlE9BKSC4lMmxU8RgTns5QAyvWu/w86j8=";
  };
  fzf_src = pkgs.fetchzip {
    url = "https://github.com/junegunn/fzf/releases/download/0.48.1/fzf-0.48.1-linux_amd64.tar.gz";
    hash = "sha256-VOaQd6uSNOFHzzYfZiE1Xw5V+8jZ3HkGm3la3cK2Ec8=";
  };
  oh_my_zsh_src = pkgs.fetchgit {
    url = "https://github.com/ohmyzsh/ohmyzsh.git";
    rev = "6dfa9507ce0eb0f4d386bd03268e33943ea55c0f";
    sha256 = "sha256-u4g3dCkAH/F44NxmA8tF8ga7grb57Pny740viS7BUiE=";
  };
  get_files = x: map (y: x + "/" + y) (builtins.attrNames (lib.filterAttrs (n: v: v == "regular") (builtins.readDir (./home + x))));
  get_directories = x: builtins.concatLists (map (y: get_dotfiles (x + "/" + y)) (builtins.attrNames (lib.filterAttrs (n: v: v == "directory") (builtins.readDir (./home + x)))));
  get_dotfiles = x: map (y: y) (builtins.concatLists [(get_directories x) (get_files x)]);
  home_file = x: ./home + ("/" + x);
  files = get_dotfiles "";
  files_map = map (x: {"${x}".source = (home_file x);}) files;
in
{
  home = {
    packages = with pkgs; [
     R
     alacritty
     ansible
     bazel_7
     bat
     bc
     bitwarden
     cargo 
     cowsay
     rustfmt
     delta
     du-dust
     emacs
     feh
     firefox
     fortune
     gcc
     gh
     git
     gnumake
     htop
     jq
     libreoffice
     odyssey
     openldap
     openssl
     pgbouncer
     podman-compose
     postgresql_16
     procs
     protobuf_23
     protobufc
     python3
     qbittorrent
     ripgrep
     rustc 
     stow
     tldr
     tmux
     tree
     unzip
     vscode
     wget
     starship
     zenith
     zoxide
     zsh
    ];
    username = "andrew";
    homeDirectory = "/home/andrew";

    stateVersion = "23.05"; # Please read the comment before changing.

    file = lib.mkMerge ([
      {"iso/arch.iso".source = arch_iso;} 
      {"iso/rocky_9.iso".source = rocky9_iso;} 
      {"iso/temple_os.iso".source = temple_os_iso;} 
      # {"iso/debian.iso".source = debian_iso;} 
      {".local/bin/terraform".source = terraform_src + "/terraform";} 
      {".local/go".source = go_src;}
      {".local/bin/eza".source = eza_src + "/eza";}
      {".local/bin/fzf".source = fzf_src + "/fzf";}
      {".oh-my-zsh".source = oh_my_zsh_src;}
      {".old_bashrc".source = ./.bashrc;}
    ] ++ files_map);
  };
  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
        bashrcExtra = ''
          source ~/.old_bashrc
        '';
    };
    neovim = {
      enable = true;
      plugins = [
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.packer-nvim
        pkgs.vimPlugins.tokyonight-nvim
        pkgs.vimPlugins.nvim-tree-lua
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.mason-nvim
        pkgs.vimPlugins.mason-lspconfig-nvim
      ];
    };
  };
}

