{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  cfg = config.editor.nixvim;
in {
  options.editor.nixvim.enable = lib.mkEnableOption "nixvim";

  config.programs.nixvim = lib.mkIf cfg.enable {
    enable = true;

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<C-f>" = "find_files";
        "<leader>ff" = "git_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
      };
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      clipboard = "unnamedplus";
    };

    globals.mapleader = " ";
  };
}
