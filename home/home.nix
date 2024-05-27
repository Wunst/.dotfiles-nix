{ config, pkgs, username, ... }:

let
  shellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
  theme = "Solarized Dark";

  lib = pkgs.lib;
in {
  imports = [
    ./editor/vim
    ./desktop/i3
    ./desktop/common/wallpaper
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;

  programs =  {
    gh.enable = true;

    bash = {
      enable = true;
      inherit shellAliases;
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "muse";
        plugins = [
          "git"
          "sudo"
          "tmux"
        ];
      };
      inherit shellAliases;
    };

    kitty = {
      enable = true;
      inherit theme;
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      shortcut = "a";
      mouse = true;
      reverseSplit = true;
    };
  };

  editor.vim.enable = true;
}
