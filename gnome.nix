{ lib, config, pkgs, ... }:

with lib;

let gnomeConfig = config.services.gnome;

in {
  options.services.gnome = {
    enable = mkOption {
      default = false;
      description = "Enable the GNOME desktop environment";
    };
    theme = mkOption {
      default = "Adwaita";
      description = "The name of the GNOME theme to use";
      example = "Yaru-dark";
    };
    noExtras = mkOption {
      default = true;
      description = "Do not install the gnome extra packages";
    };
  };

  config = mkIf gnomeConfig.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    programs.dconf.enable = true;

    environment.gnome.excludePackages = mkIf gnomeConfig.noExtras (with pkgs;
      with gnome; [
        gnome-tour
        gnome-music
        epiphany
        geary
        tali
        iagno
        hitori
        atomix
        yelp
        gnome-initial-setup
      ]);

    environment.systemPackages = with pkgs; with gnomeExtensions; [
      gnome.adwaita-icon-theme
      gnome.pomodoro
      breeze-icons
      gnome.gnome-tweaks
      gnome-extension-manager
      user-themes-x
      user-themes
      burn-my-windows
      gesture-improvements
      gsconnect
      draw-on-you-screen-2
      clipboard-indicator
      gtk-title-bar
      rounded-window-corners
    ];
    # environment.sessionVariables.QT_QPA_PLATFORMTHEME = lib.mkDefault "breeze";
    # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
