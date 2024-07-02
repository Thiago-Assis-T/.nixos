{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.programs.my-nvim;
in
{
  options.programs.my-nvim = {
    enable = lib.mkEnableOption (lib.mdDoc "my-nvim");
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      # Telescope Dependency for find grep
      ripgrep
      # For nix formatting
      nixfmt-rfc-style
      nixpkgs-fmt
      # For treesitter
      gcc
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      extraConfigLua = ''
        vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#0f1419", ctermbg = "none" })
        vim.g.have_nerd_font = true;
      '';
      clipboard = {
        # Use system clipboard
        register = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      globals.mapleader = " ";
      globals.maplocaleader = " ";
      opts = {
        updatetime = 100; # Faster completion
        # Line numbers
        relativenumber = true; # Relative line numbers
        number = true; # Display the absolute line number of the current line
        hidden = true; # Keep closed buffer open in the background
        swapfile = false; # Disable the swap file
        undofile = true; # Automatically save and restore undo history
        hlsearch = false;
        incsearch = true; # Incremental search: show match for partly typed search command
        inccommand = "split"; # Search and replace: preview changes in quickfix list
        ignorecase = true; # When the search query is lower-case, match both lower and upper-case
        #   patterns
        smartcase = true; # Override the 'ignorecase' option if the search pattern contains upper
        #   case characters
        scrolloff = 8; # Number of screen lines to show around the cursor
        cursorline = false; # Highlight the screen line of the cursor
        cursorcolumn = false; # Highlight the screen column of the cursor
        signcolumn = "yes"; # Whether to show the signcolumn
        fileencoding = "utf-8"; # File-content encoding for the current buffer
        termguicolors = true; # Enables 24-bit RGB color in the |TUI|
        spell = true; # Highlight spelling mistakes (local to window)
        wrap = false; # Prevent text from wrapping
        # Tab options
        tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
        shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
        expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
        autoindent = true; # Do clever autoindenting
        textwidth = 0; # Maximum width of text that is being inserted.  A longer line will be
      };

      plugins = {
        nvim-colorizer.enable = true;
        transparent.enable = true;
        noice.enable = true;
        trouble.enable = true;
        fidget.enable = true;
        notify.enable = true;
        lsp-lines.enable = true;
        gitsigns.enable = true;
        lualine.enable = true;
        hmts.enable = true;
        nix.enable = true;
        nix-develop.enable = true;
        treesitter = {
          enable = true;
          ensureInstalled = [
            "nix"
            "lua"
          ];
          folding = false;
          indent = true;
          nixvimInjections = true;
          incrementalSelection.enable = true;
        };
        treesitter-context = {
          enable = true;
          settings = {
            line_numbers = true;
          };
        };
        treesitter-refactor = {
          enable = true;
          highlightCurrentScope.enable = false;
          navigation.enable = true;
          smartRename.enable = true;
        };
        treesitter-textobjects = {
          enable = true;
          lspInterop.enable = true;
        };
        luasnip.enable = true;
        friendly-snippets.enable = true;
        cmp = {
          enable = true;
          settings = {
            mapping = {
              __raw = # lua
                ''
                  cmp.mapping.preset.insert({
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
                  })
                '';
            };
            snippet = {
              expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            };
            sources = [
              { name = "nvim_lsp"; }
              { name = "luasnip"; }
              { name = "fuzzy_path"; }
              { name = "fuzzy_buffer"; }
              { name = "treesitter"; }
            ];
            formatting = {
              format = # lua
                ''
                  function(entry, vim_item)
                    local icons = {
                      Text = "󰈚",
                      Method = "",
                      Function = "󰊕",
                      Constructor = "󱌣",
                      Field = "󰽐",
                      Variable = "",
                      Class = "",
                      Interface = "",
                      Module = "󰕳",
                      Property = "",
                      Unit = "󱍓",
                      Value = "󰎠",
                      Enum = "",
                      Keyword = "",
                      Snippet = "",
                      Color = "",
                      File = "󰈙",
                      Reference = "",
                      Folder = "",
                      EnumMember = "",
                      Constant = "",
                      Struct = "",
                      Event = "",
                      Operator = "",
                      TypeParameter = "󰉺",
                    }
                    vim_item.kind = string.format("%s", icons[vim_item.kind])
                    vim_item.menu = ({
                      nvim_lsp = "[LSP]",
                      treesitter = "[Treesitter]",
                      luasnip = "[Snippet]",
                      fuzzy_buffer = "[Buffer]",
                      fuzzy_path = "[Path]",
                    })[entry.source.name]
                    return vim_item
                  end,
                '';
            };
          };
        };
        telescope = {
          enable = true;
          #keymapsSilent = true;
          extensions.fzf-native.enable = true;
          keymaps = {
            "<leader>?" = {
              action = "oldfiles";
              options = {
                desc = "[?] Find recently opened files";
              };
            };
            "<leader><space>" = {
              action = "buffers";
              options = {
                desc = "[ ] Find existing buffers";
              };
            };
            "<leader>/" = {
              action = "current_buffer_fuzzy_find";
              options = {
                desc = "[/] Fuzzily search in current buffer";
              };
            };
            "<leader>ft" = {
              action = "git_files";
              options = {
                desc = "[F]ind gi[T]";
              };
            };
            "<leader>ff" = {
              action = "find_files";
              options = {
                desc = "[F]ind [F]files";
              };
            };
            "<leader>fh" = {
              action = "help_tags";
              options = {
                desc = "[F]ind [H]elp";
              };
            };
            "<leader>fw" = {
              action = "grep_string";
              options = {
                desc = "[F]ind [W]ord";
              };
            };
            "<leader>fg" = {
              action = "live_grep";
              options = {
                desc = "[F]ind [G]rep";
              };
            };
            "<leader>fd" = {
              action = "diagnostics";
              options = {
                desc = "[F]ind [D]iagnostics";
              };
            };
          };
        };
        lsp = {
          enable = true;
          capabilities = # lua
            ''
              vim.lsp.protocol.make_client_capabilities()
            '';
          onAttach = # lua
            ''
              function attach(_, bufnr)
              	local nmap = function(keys, func, desc)
              		if desc then
              			desc = "LSP: " .. desc
              		end
              		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
              	end

              	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
              	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
              	nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
              	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
              	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
              	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
              	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]symbols")
              	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]symbols")

              	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
              	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

              	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
              	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
              	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
              	nmap("<leader>wl", function()
              		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              	end, "[W]orkspace [L]ist Folders")
              end
            '';
          servers = {
            nixd.enable = true;
          };
        };
        conform-nvim = {
          enable = true;
          formatOnSave = {
            lspFallback = true;
            timeoutMs = 250;
          };
          formattersByFt = {

            nix = [
              "nixfmt"
              "nixpkgs-fmt"
            ];
            "*" = [ "trim_whitespace" ];
          };
        };
        lint = {
          enable = true;
          lintersByFt = {
            nix = [ "nix" ];
          };
        };
      };
    };
  };
}
