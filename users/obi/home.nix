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
  home.packages = with pkgs;[
    nixfmt-rfc-style

    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Ubuntu" ];})
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
    serif = ["Firacode Nerd Font"];
    sansSerif = ["JetBrainsMono Nerd Font"];
    monospace = ["JetBrainsMono Nerd Font"];
    };
  };

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
  
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
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

  programs.starship = {
  enable = true;
  # You can add custom settings here if needed
  settings = {
    # Your Starship configuration goes here
    add_newline = false;
    # Add more configuration options as needed
    format = "[](fg:#7DF9AA)\[󱄅 ](bg:#7DF9AA fg:#090c0c)\[](fg:#7DF9AA bg:#1C3A5E)\$time\[](fg:#1C3A5E bg:#3B76F0)\$directory\[](fg:#3B76F0 bg:#FCF392)\$git_branch\$git_status\$git_metrics\$character";
    directory = {
      format = "[ ﱮ $path ]($style)";
      style = "fg:#E4E4E4 bg:#3B76F0";
      };

    git_branch = {
      format = ''[ $symbol$branch(:$remote_branch) ]($style)'';
      symbol = "  ";
      style = "fg:#1C3A5E bg:#FCF392";
      };

    git_status = {
        format = ''[$all_status]($style)'';
        style = "fg:#1C3A5E bg:#FCF392";
      };

    git_metrics = {
        format = ''([+$added]($added_style))[ ]($added_style)'';
        added_style = "fg:#1C3A5E bg:#FCF392";
        deleted_style = "fg:bright-red bg:235";
        disabled = false;
      };

    hg_branch = {
        format = ''$symbol$branch ]($style)'';
        symbol = " ";
      };

    cmd_diration = {
        format = ''[  $duration ]($style)'';
        style = "fg:bright-white bg:18";
      };

    character = {
        success_symbol = ''[](bold green) '';
        error_symbol = ''[](#E84D44) '';
      };

    time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = ''[[ 󱑍 $time ](bg:#1C3A5E fg:#8DFBD2)]($style)'';
      };
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

}
