{ lib, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
    withPerl = true;
    withRuby = true;
    extraPackages = with pkgs; [
      imagemagick
      ghostscript_headless
      tectonic
      texliveFull
      mermaid-cli
      fzf
      fzy
    ];
    extraConfigLua = "vim.deprecate = function() end";
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;

    };
    viAlias = true;
    vimAlias = true;
    performance.byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
    luaLoader.enable = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };

    globals = {
      mapleader = " ";
    };
    keymaps = [
      {
        action = "<cmd> Telescope live_grep <CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd> Telescope fzy<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd> Trouble diagnostics toggle <CR>";
        key = "<leader>t";
      }

    ];
    plugins = {
      nui.enable = true;
      which-key.enable = true;
      notify.enable = true;
      web-devicons.enable = true;
      lualine.enable = true;
      bufferline.enable = true;
      gitsigns.enable = true;
      highlight-colors.enable = true;
      nix.enable = true;
      lsp-lines.enable = true;
      lsp-signature.enable = true;
      lsp-status.enable = true;
      lspkind.enable = true;
      trouble.enable = true;
      twilight.enable = true;
      fidget.enable = true;
      ts-autotag.enable = true;
      ts-comments.enable = true;
      tiny-devicons-auto-colors.enable = true;
      ts-context-commentstring.enable = true;
      headlines.enable = true;
      noice = {
        enable = true;
        settings = {
          lsp = {
            override = {
              "cmp.entry.get_documentation" = true;
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
            };
          };
        };
      };
      snacks = {
        enable = true;
        settings = {
          bigfile = {
            enabled = true;
          };
          notifier = {
            enabled = true;
            timeout = 3000;
          };
          quickfile = {
            enabled = true;
          };
          statuscolumn = {
            enabled = true;
          };
          words = {
            debounce = 100;
            enabled = true;
          };
          image = {
            enabled = true;
          };
        };
      };

      todo-comments = {
        enable = true;
        settings = {
          highlight = {
            pattern = [
              ".*<(KEYWORDS)s*:"
              ".*<(KEYWORDS)s*"
            ];
          };
          colors = {
            default = [
              "Identifier"
              "#7C3AED"
            ];
            error = [
              "DiagnosticError"
              "ErrorMsg"
              "#DC2626"
            ];
            hint = [
              "DiagnosticHint"
              "#10B981"
            ];
            info = [
              "DiagnosticInfo"
              "#2563EB"
            ];
            test = [
              "Identifier"
              "#FF00FF"
            ];
            warning = [
              "DiagnosticWarn"
              "WarningMsg"
              "#FBBF24"
            ];
          };
          keywords = {
            FIX = {
              alt = [
                "FIXME"
                "BUG"
                "FIXIT"
                "ISSUE"
              ];
              color = "error";
              icon = " ";
            };
            HACK = {
              color = "warning";
              icon = " ";
            };
            NOTE = {
              alt = [
                "INFO"
              ];
              color = "hint";
              icon = " ";
            };
            PERF = {
              alt = [
                "OPTIM"
                "PERFORMANCE"
                "OPTIMIZE"
              ];
              icon = " ";
            };
            TEST = {
              alt = [
                "TESTING"
                "PASSED"
                "FAILED"
              ];
              color = "test";
              icon = "⏲ ";
            };
            TODO = {
              color = "info";
              icon = " ";
            };
            WARN = {
              alt = [
                "WARNING"
                "XXX"
              ];
              color = "warning";
              icon = " ";
            };
          };
        };
      };
      lsp = {
        enable = true;
        servers = {
          lua_ls = {
            enable = true;
            settings.telemetry.enable = true;
          };
          nixd.enable = true;
          clangd.enable = true;
        };
      };
      lsp-format = {
        enable = true;
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            bash = [
              "shellcheck"
              "shellharden"
              "shfmt"
            ];
            nix = [ "nixfmt" ];
            cpp = [ "clang_format" ];
            c = [ "clang_format" ];
            "_" = [
              "squeeze_blanks"
              "trim_whitespace"
              "trim_newlines"
            ];
          };
          format_on_save = # Lua
            ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

               -- if slow_format_filetypes[vim.bo[bufnr].filetype] then
               --   return
               -- end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
               end
            '';
          log_level = "warn";
          notify_on_error = false;
          notify_no_formatters = false;
          formatters = {
            shellcheck = {
              command = lib.getExe pkgs.shellcheck;
            };
            nixfmt = {
              command = lib.getExe pkgs.nixfmt-rfc-style;
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
          };
        };
      };
      lint = {
        enable = true;
        lintersByFt = {
          nix = [
            "nix"
          ];
          c = [
            "clangtidy"
          ];
        };
      };
      treesitter = {
        enable = true;
      };
      treesitter-context = {
        enable = true;
      };
      treesitter-refactor = {
        enable = true;
        highlightCurrentScope.enable = true;
        highlightDefinitions.enable = true;
        navigation.enable = true;
      };
      treesitter-textobjects = {
        enable = true;
        lspInterop.enable = true;
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          fzy-native.enable = true;
          live-grep-args.enable = true;
          file-browser = {
            enable = true;
            settings = {
              file_browser = {
                hijack_netrw = true;
                theme = "ivy";
              };
            };
          };
        };
        settings = {
          defaults = {
            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "%.ipynb"
            ];
            layout_config = {
              prompt_position = "top";
            };
            mappings = {
              i = {
                "<A-j>" = {
                  __raw = "require('telescope.actions').move_selection_next";
                };
                "<A-k>" = {
                  __raw = "require('telescope.actions').move_selection_previous";
                };
              };
            };
            selection_caret = "> ";
            set_env = {
              COLORTERM = "truecolor";
            };
            sorting_strategy = "ascending";
          };
        };
      };
    };
  };
}
