{ lib, config, pkgs, ... }:

with lib;

let fishConfig = config.shells.fish;

in {
  options.shells.fish = {
    enable = mkOption {
      default = false;
      description = "Enable Fish Shell with sane standards";
    };
  };

  config = mkIf fishConfig.enable {
    programs.fish = {
      enable = true;
      shellAliases = {
        "..." = "cd ../..";
        "...." = "cd ../../..";
      };
      promptInit = ''
        any-nix-shell fish --info-right | source
      '';
    };

    users.defaultUserShell = pkgs.fish;
    environment.systemPackages = (with pkgs; [
      any-nix-shell
      fishPlugins.done
      fishPlugins.fzf-fish
      fishPlugins.forgit
      fishPlugins.pure
      fishPlugins.humantime-fish
      fishPlugins.colored-man-pages
      fishPlugins.autopair
      fzf
      grc
    ]);
  };
}
