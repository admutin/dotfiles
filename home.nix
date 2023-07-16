{ config, pkgs, ... }: {
  home.username = "tobi";
  home.homeDirectory = "/home/tobi";
  home.stateVersion = "22.11";
  home.sessionVariables = {
    EDITOR = "code";
  };

  programs.home-manager.enable = true;

  xdg.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [ ];
    shellAliases = {
      "cd" = "z";
    };
  };

  programs.git = {
    enable = true;
    userName = "Tobias Schür";
    userEmail = "admutin@gmail.com";
    delta.enable = true;
    ignores = [".direnv"];
    extraConfig = {
      core = {
        editor ="code";
      };
      delta = {
        light = true;
      };
    };
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
  };

  programs.bat = { 
    enable = true; 
    config.theme = "GitHub";
    };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # programs.texlive = {
  #   enable = true;
  #   extraPackages = tpkgs: { inherit (tpkgs) scheme-full  collection-fontsrecommended algorithms; };
  # };

  programs.bottom = {
    enable = false;
    settings = {
      flags = {
        color="default-light";
      };
    };
  };

  programs.gallery-dl.enable = true;

  home.packages = with pkgs; [
    bottom
    fd
    neofetch
    nnn
    ranger
    ripgrep
    tealdeer
    tree
    tokei
    # electrum
    # handbrake
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "org.telegram.desktop.desktop"
        "com.gexperts.Tilix.desktop"
        "google-chrome.desktop"
      ];
      disable-extension-version-validation = true;
      disable-user-extensions = false;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
  };

  gtk = 
  let extraCss = ''
      VteTerminal,
      TerminalScreen,
      vte-terminal {
          padding: 20px 20px 20px 20px;
          -VteTerminal-inner-border: 10px 10px 10px 10px;
      }
    '';
  in
  {
    enable = true;
    cursorTheme = {
      name = "Numix-Cursor-Light";
      package = pkgs.numix-cursor-theme;
    };
    theme = {
      name = "Orchis-Pink";
    };
    gtk3.extraCss = extraCss;
  };


}
