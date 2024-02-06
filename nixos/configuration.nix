# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "iris"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #Nix
  nix = {
   package = pkgs.nixFlakes;
   settings = {
    warn-dirty = false;
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
   };        
};

  #Hyprland
  programs.hyprland.enable = true;

  #XDG
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [
         pkgs.xdg-desktop-portal
         pkgs.xdg-desktop-portal-gtk
       ];
     };
  };
  
  # Utils
  sound.enable = true;
  nixpkgs.config.pipewire = true;
  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;
 };
  hardware.opentabletdriver.enable = true;
  programs.fish.enable = true;
  hardware.opentabletdriver.daemon.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.greenclip.enable = true;
  #Fonts
  fonts.packages = with pkgs; [
   noto-fonts-cjk
   liberation_ttf
   nerdfonts
 ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
  };
  services.xserver.displayManager.sddm.enable = true; 
  services.xserver.displayManager.sddm.theme = "where_is_my_sddm_theme";
  programs.kdeconnect.enable = true;
  services.gvfs.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.risa = {
    isNormalUser = true;
    description = "Risa";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      xournalpp
      joplin-desktop
      ranger
      projectlibre
      rnote
      strawberry
      neofetch
      starship
      libsForQt5.kdeconnect-kde
      obs-studio
      gtk-engine-murrine
      orchis-theme
      vlc
];
  };
  users.defaultUserShell = pkgs.fish;
  
# Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    firefox-wayland
    kitty
    wlr-randr
    brightnessctl
    rofi-wayland
    xdg-desktop-portal-hyprland
    swww
    grim
    slurp
    dunst
    hyprland-protocols
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    sddm
    where-is-my-sddm-theme
    mate.engrampa
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    gvfs    
    pipewire
    wireplumber
    pwvucontrol
    networkmanager
    networkmanagerapplet
    bluez
    bluez-tools
    blueman
    libsForQt5.sddm
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    zathura
    libreoffice-fresh
    waybar
    hyprpaper
    gedit
    tela-circle-icon-theme
    feh
    opentabletdriver
    haskellPackages.greenclip
    cmus
    xdg-utils
    vscode
    nwg-look
  ];
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
