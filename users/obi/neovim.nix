{
pkgs,
config,
...
}: {
  programs = {
    neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        xclip
        wl-clipboard
        nixd
      ];

      plugins = with pkgs.vimPlugins; [

        {
          plugin = nvim-lspconfig;
          config = toLuaFile ../../programs/nvim/plugin/lsp.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\").setup()";
        }

         {
          plugin = gruvbox-nvim;
           config = "colorscheme gruvbox";
         }

        neodev-nvim

        {
          plugin = nvim-cmp;
          config = toLuaFile ../../programs/nvim/plugin/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ../../programs/nvim/plugin/telescope.lua;
        }

        telescope-fzf-native-nvim

        cmp_luasnip
        cmp-nvim-lsp

        luasnip
        friendly-snippets

        lualine-nvim
        nvim-web-devicons

        vim-nix

        {
          plugin = (nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
          ]));
          config = toLuaFile ../../programs/nvim/plugin/treesitter.lua;
        }
        
        {
          plugin = conform-nvim;
          config = toLuaFile ../../programs/nvim/plugin/conform.lua;
        }

        # {
        #   plugin = vimPlugins.own-onedark-nvim;
        #   config = "colorscheme onedark";
        # }

        {
      plugin = codeium-nvim;
      type = "lua";
      config = ''
        require('codeium').setup({})
      '';
    }
      ];

      extraLuaConfig = ''
  
  ${builtins.readFile ../../programs/nvim/options.lua}

  ${builtins.readFile ../../programs/nvim/plugin/lsp.lua}

'';


    };
  };
}
