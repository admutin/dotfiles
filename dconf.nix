{ inputs, ... }: {
    "org/gnome/shell" = {
      favorite-apps = [
        "code.desktop"
        "org.gnome.Terminal.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      disable-extension-version-validation = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
}
