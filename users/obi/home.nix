{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
  ];

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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;[
    nixfmt-rfc-style

    direnv
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
      eval "$(direnv hook bash)"
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


}
