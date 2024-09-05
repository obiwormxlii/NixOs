{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "obi";
  home.homeDirectory = "/home/obi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nixfmt-rfc-style
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userName = "obiwormxlii";
    userEmail = "babrayton0811@gmail.com";
  };

  programs.gh = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      theme = "jonathan";
    };

  };
  programs.neovim =
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
          config = toLuaFile ./nvim/plugin/lsp.lua;
        }

        {
          plugin = comment-nvim;
          config = toLua "require(\"Comment\".setup()";
        }

         {
          plugin = gruvbox-nvim;
           config = "colorscheme gruvbox";
         }

        neodev-nvim

        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/cmp.lua;
        }

        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugin/telescope.lua;
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
          config = toLuaFile ./nvim/plugin/treesitter.lua;
        }
        
        {
          plugin = conform-nvim;
          config = toLuaFile ./nvim/plugin/conform.lua;
        }

        # {
        #   plugin = vimPlugins.own-onedark-nvim;
        #   config = "colorscheme onedark";
        # }

        codeium-nvim
      ];

      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
      '';
    };

}
