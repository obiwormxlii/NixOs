{ pkgs, config, ... }:

{
programs.starship = {
  enable = true;
  # You can add custom settings here if needed
  settings = {
    # Your Starship configuration goes here
    add_newline = false;
    # Add more configuration options as needed
    format = "[](fg:#7DF9AA)\[󱄅 ](bg:#7DF9AA fg:#090c0c)\[](fg:#7DF9AA bg:#1C3A5E)\$time\[](fg:#1C3A5E bg:#3B76F0)\$directory\[](fg:#3B76F0 bg:#FCF392)\$git_branch\$git_status\$git_metrics\$character";
    directory = {
        format = "[  $path ]($style)";
        style = "fg:#E4E4E4 bg:#3B76F0";
        truncation_length = 2;
        truncation_symbol = "...";
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

    cmd_duration = {
        format = ''[  $duration ]($style)'';
        style = "fg:bright-white bg:18";
      };

    character = {
        success_symbol = ''[](bold green) '';
        error_symbol = ''[](#E84D44) '';
      };

    time = {
        disabled = false;
        time_format = "%a %b %d, %I:%M"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = ''[[ 󱑍 $time ](bg:#1C3A5E fg:#8DFBD2)]($style)'';
      };
    };
  };
}
