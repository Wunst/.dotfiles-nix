{ config, lib, pkgs, ... }:

let
  cfg = config.wunst.editor.nixvim;
in {
  options.wunst.editor.nixvim = {
    enable = lib.mkEnableOption "nixvim";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      description = "The base16 colorscheme to use";
    };
  };

  # utils for telescope
  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    ripgrep
    fd
  ]);

  config.programs.nixvim = lib.mkIf cfg.enable {
    enable = true;

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<C-f>" = "find_files";
        "<leader>ff" = "git_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fw" = "lsp_workspace_symbols";
      };
    };

    plugins.treesitter.enable = true;

    plugins.lsp = {
      enable = true;
      keymaps = {
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };
      };
      servers = {
        tsserver.enable = true;
        nixd.enable = true;
      };
    };

    plugins.cmp = {
      enable = true;
      settings = {
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
        };
        sources = [
          { name = "buffer"; }
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "nvim_lsp_signature_help"; }
        ];
      };
      filetype.gitcommit.sources = [
        { name = "git"; }
      ];
    };

    colorschemes.base16 = {
      enable = true;
      colorscheme = cfg.colorscheme;
    };
    
    opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      clipboard = "unnamedplus";
      undofile = true;
    };

    globals.mapleader = " ";
  };
}

