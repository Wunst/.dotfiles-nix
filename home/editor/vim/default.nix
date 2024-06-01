{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  cfg = config.editor.vim;
{
  options.editor.vim.enable = lib.mkEnableOption "vim";

  config.programs.vim = lib.mkIf cfg.enable {
    enable = true;

    settings = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      copyindent = true;
      expandtab = true;
    };
  };
}
