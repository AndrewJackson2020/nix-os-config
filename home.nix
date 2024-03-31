
{ lib, config, pkgs, ... }:

let
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
     alacritty
     R
     bc
     bitwarden
     cowsay
     delta
     emacs
     firefox
     fortune
     gcc
     gh
     git
     gnumake
     htop
     jq
     libreoffice
     protobuf_23
     protobufc
     qbittorrent
     unzip
     ranger
     ripgrep
     stow
     cargo 
     rustc 
     tmux
     tree
     vscode
     wget
     feh
     zenith
     zsh
    ];
    username = "andrew";
    homeDirectory = "/home/andrew";

    stateVersion = "23.05"; # Please read the comment before changing.

    file = lib.mkMerge ([
      {".local/bin/terraform".source = terraform_src + "/terraform";} 
      {".local/go".source = go_src;}
      {".local/bin/eza".source = eza_src + "/eza";}
      {".local/bin/fzf".source = fzf_src + "/fzf";}
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

