# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, inputs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  # boot.initrd.secrets = { "/crypto_keyfile.bin" = null; };

  # Enable swap on luks
  # boot.initrd.luks.devices."luks-598b7e8d-f49a-4f96-999c-6052d5f7a7b3".device =
  #   "/dev/disk/by-uuid/598b7e8d-f49a-4f96-999c-6052d5f7a7b3";
  # boot.initrd.luks.devices."luks-598b7e8d-f49a-4f96-999c-6052d5f7a7b3".keyFile =
  #   "/crypto_keyfile.bin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "NiX1-Carbon"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.extraHosts = "";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable screenrotation
  hardware.sensor.iio.enable = true;
  hardware.opengl.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tobi = import ./tobi.nix;
  fileSystems."/home/tobi/nextcloud" = {
    fsType = "davfs";
    device = "https://nextcloud.admutin.de/remote.php/dav/files/tobi/";
    options = [ "nofail" "auto" ];
  };
  # fileSystems."/home/tobi/olat" = {
  #   fsType = "davfs";
  #   device = "https://olat.vcrp.de/webdav";
  #   options = [ "nofail" "auto" ];
  # };
  # Enable automatic login for the user.
  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "tobi";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget +
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs;
    [
      wget
      curl
      google-chrome
      killall
      htop
      gotop
      # gnumake
      # qmk
      (vscode-with-extensions.override {
        # vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          brettm12345.nixfmt-vscode
          ms-python.python
          gencer.html-slim-scss-css-class-completion
          ms-vscode-remote.remote-ssh
          # xaver.clang-format
          # llvm-vs-code-extensions.vscode-clangd
          # editorconfig.editorconfig
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vs-code-prettier-eslint";
          publisher = "rvest";
          version = "5.0.4";
          sha256 = "sha256-aLEAuFQQTxyFSfr7dXaYpm11UyBuDwBNa0SBCMJAVRI=";
        }];
      })
      discord-canary
      tdesktop
      tilix
      python3
      git
      obsidian
      wireguard-tools
      jetbrains.rider
      # inkscape
      # gimp
      # blender
      nixfmt
      firefox
      thunderbird
      orchis-theme
      zoxide
      direnv
      xournalpp
      krita
      rsync
      vlc
      mpv
      zip
      gzip
      unzip
      virt-manager
      dotnet-sdk #todo: versions
      steamtinkerlaunch
    ] ++ [ cool-retro-term jellyfin-media-player ]
    ++ (with inputs.nixpkgs-wayland; [ wl-clipboard xdg-desktop-portal-wlr ]);
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  nixpkgs.overlays = [
    (self: super: {
      steam-run = (super.steam.override {
        extraLibraries = pkgs: with pkgs;
          [
            libxkbcommon
            mesa
            wayland
            (sndio.overrideAttrs (old: {
              postFixup = old.postFixup + ''
                ln -s $out/lib/libsndio.so $out/lib/libsndio.so.6.1
              '';
            }))
          ];
      }).run;
    })
  ];

  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.davfs2.enable = true;

  system.stateVersion = "22.11"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  virtualisation.docker.enable = true;
}
