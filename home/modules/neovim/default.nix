{ inputs
, pkgs
, lib
, ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    enableMan = true;
    vimAlias = true;
    viAlias = true;
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;
    wrapRc = true;
    extraPackages = with pkgs; [
      clang
      libclang
      deadnix
      bash
      nix
      vale
      alejandra
      nixpkgs-fmt
      nixfmt-rfc-style
      uutils-coreutils-noprefix
    ];
    files = {
      "ftplugin/nix.lua" = {
        opts = {
          expandtab = true;
          shiftwidth = 2;
          tabstop = 2;
        };
      };
    };
    opts = {
      expandtab = true;
      shiftwidth = 8;
      tabstop = 8;
      relativenumber = true;
      number = true;
    };
    clipboard.register = "unnamedplus";
    performance = {
      byteCompileLua = {
        enable = true;
        initLua = true;
        nvimRuntime = true;
        plugins = true;
      };
      combinePlugins.enable = false;
    };
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };
    plugins = {
      transparent = {
        enable = true;
        settings.groups = [
          "Normal"
          "NormalNC"
          "Comment"
          "Constant"
          "Special"
          "Identifier"
          "Statement"
          "PreProc"
          "Type"
          "Underlined"
          "Todo"
          "String"
          "Function"
          "Conditional"
          "Repeat"
          "Operator"
          "Structure"
          "LineNr"
          "NonText"
          "SignColumn"
          "CursorLine"
          "CursorLineNr"
          "StatusLine"
          "StatusLineNC"
          "EndOfBuffer"
          "BufferLineTabClose"
          "BufferLineBufferSelected"
          "BufferLineFill"
          "BufferLineBackground"
          "BufferLineSeparator"
          "BufferLineIndicatorSelected"
        ];
      };
      web-devicons.enable = true;
      lualine.enable = true;
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          ensure_installed = "all";
          ignore_install = [
            "norg"
          ];
          highlight = {
            additional_vim_regex_highlighting = true;
            enable = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = false;
              node_decremental = "grm";
              node_incremental = "grn";
              scope_incremental = "grc";
            };
          };
          indent = {
            enable = true;
          };
          parser_install_dir = {
            __raw = "vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')";
          };
          sync_install = false;

          nixvimInjections = true;
        };
      };
      treesitter-context.enable = true;
      treesitter-refactor.enable = true;
      treesitter-textobjects.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls = {
            enable = true;
            autostart = true;
          };
          nixd = {
            enable = true;
            autostart = true;
          };
        };
      };
      lsp-format.enable = true;
      lsp-lines.enable = true;
      lsp-signature.enable = true;
      lsp-status.enable = true;
      lspkind.enable = true;
      lspsaga.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [
              "alejandra"
              "nixfmt_unstable"
              "nixpkgs_fmt"
            ];
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            c = [ "clang_format" ];
            cpp = [ "clang_format" ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_format = "fallback";
          };
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            alejandra = {
              command = lib.getExe pkgs.alejandra;
            };
            nixfmt-unstable = {
              command = lib.getExe pkgs.nixfmt-rfc-style;
            };
            nixpkgs-fmt = {
              command = lib.getExe pkgs.nixpkgs-fmt;
            };
            shellcheck = {
              command = lib.getExe pkgs.shellcheck;
            };
            shfmt = {
              command = lib.getExe pkgs.shfmt;
            };
            shellharden = {
              command = lib.getExe pkgs.shellharden;
            };
            squeeze_blanks = {
              command = lib.getExe' pkgs.uutils-coreutils-noprefix "cat";
            };
            clang_format = {
              command = lib.getExe' pkgs.libclang "clang-format";
            };
          };
        };
      };
      lint = {
        enable = true;
        lintersByFt = {
          nix = [
            "nix"
            "deadnix"
          ];
          bash = [
            "bash"
          ];
          c = [
            "clang-tidy"
          ];
          text = [
            "vale"
          ];
        };
      };
    };
  };
}
