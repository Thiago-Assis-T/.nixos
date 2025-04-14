{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.nvf
  ];
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        debugMode.enable = false;
        spellcheck.enable = true;
        withNodeJs = true;
        withPython3 = true;
        withRuby = true;
        enableLuaLoader = true;
        syntaxHighlighting = true;
        viAlias = true;
        vimAlias = true;
        extraPackages = with pkgs; [clang tree-sitter];
        utility = {
          diffview-nvim.enable = true;
          images.image-nvim = {
            enable = true;
            setupOpts = {
              backend = "kitty";
              integrations.markdown = {
                enable = true;
                downloadRemoteImages = true;
              };
            };
          };
          preview = {
            markdownPreview = {
              enable = true;
              alwaysAllowPreview = true;
              autoStart = true;
            };
          };
        };
        visuals = {
          fidget-nvim.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          tiny-devicons-auto-colors.enable = true;
          cellular-automaton.enable = true;
        };
        ui = {
          colorizer.enable = true;
          modes-nvim.enable = true;
          smartcolumn.enable = true;
          noice.enable = true;
          borders = {
            enable = true;
            plugins = {
              lsp-signature.enable = true;
              lspsaga.enable = true;
              nvim-cmp.enable = true;
              which-key.enable = true;
            };
          };
        };

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        notes.todo-comments.enable = true;

        snippets.luasnip.enable = true;
        autocomplete = {
          enableSharedCmpSources = true;
          blink-cmp = {
            enable = false;
            friendly-snippets.enable = true;
            setupOpts.signature.enabled = true;
          };
          nvim-cmp = {
            enable = true;
          };
        };
        options = {
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          trouble.enable = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
          lspkind.enable = true;
          lspsaga.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };
        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          enableExtraDiagnostics = true;
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
            extraDiagnostics.types = [
              "statix"
            ];
            format.enable = true;
            lsp = {
              enable = true;
            };
          };
          clang = {
            enable = true;
            lsp.enable = true;
            cHeader = true;
            dap.enable = true;
          };
          python = {
            enable = true;
            dap.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          markdown = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            extensions.render-markdown-nvim.enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
          };
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        binds = {
          cheatsheet.enable = true;
          whichKey.enable = true;
        };
        diagnostics = {
          enable = true;
          config = {
            update_in_insert = true;
            virtual_lines = false;
            virtual_text = true;
          };
          nvim-lint = {
            enable = true;
            lint_after_save = true;
          };
        };
      };
    };
  };
}
