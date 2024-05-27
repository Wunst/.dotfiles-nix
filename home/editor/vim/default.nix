{ config, pkgs, ... }:

{
  options = 
  let 
    lib = pkgs.lib; 
  in {
    editor.vim = {
      enable = lib.mkEnableOption "vim";
    };
  };

  config = {
    programs.vim = {
      enable = config.editor.vim.enable;

      settings = {
        number = true;
        relativenumber = true;
        tabstop = 4;
        shiftwidth = 4;
        copyindent = true;
        expandtab = true;
      };
    };
  };
}
