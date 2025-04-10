# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
boot.kernelPackages = pkgs.linuxPackages_latest;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
 /*
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  */
  boot.loader.grub ={ enable = true; efiSupport = true; device = "nodev"; useOSProber = true; }; # For Grub 
  boot.loader.efi.canTouchEfiVariables = true; #For Grub
  
   networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	boot.loader.grub.splashImage = "/boot/anime-nix-wallpaper-i-created-v0-0f6oxa9y9jlb1.png"; #grub boot menu picture
	boot.plymouth.enable = true; # for playmouth logo

	programs.nix-ld.enable = true;

	#boot.plymouth.theme = "bgrt";
	#config.boot.plymouth.theme == "breeze"

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  #Flatpak Service Enable
  services.flatpak.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pritam = {
    isNormalUser = true;
    description = "Pritam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

   programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  wget															#Download Online 
  micro															#Terminal Esey Text Editor
  neovim														#Text Editor
  gnuchess
  blender
  # opera														#Chess Game
  firefox-bin													#Firefox Perfect
  xonotic
  steam-run														#Single Person Shooting Game
  #assaultcube
  gnome-browser-connector										#Connect gnome With Browser(Firefox)
  gnomeExtensions.gsconnect										#Connecting Android Mobile With Gnome Desktop
  gnomeExtensions.blur-my-shell									#Gnome Extention for Blur Effect
  gnomeExtensions.dash-to-panel									#For Dash To Pannel
  gnomeExtensions.compiz-windows-effect							#For wabbily Windows
  gnomeExtensions.coverflow-alt-tab	
  hblock							#for Coverflow Windows
  gnome-boxes
  gnome-mahjongg
  gnome-chess
  papirus-icon-theme
  #spotify
  parabolic
  heimdall
  git
  ventoy-full
  #warp-terminal
  rustc
  rustup-toolchain-install-master
  gnuchess
  rustus
  cargo
  rustfmt
  clippy
  ruby 
  bundler
  rustup
  pkgs.android-tools
  adb-sync
  #waydroid
  freetube
  signal-desktop
  wpsoffice
  hyfetch
  neofetch
  anydesk
  #vscode
  vscodium
  obs-studio
  amberol
  klavaro
  tuxtype
  krita
  shotcut
  #google-chrome
  #brave
  obs-studio
  appimage-run
  htop
  vlc
  whitesur-icon-theme
  bibata-cursors
  telegram-desktop
  gimp
  #ventoy
  gnomeExtensions.gsconnect
  fish
  gparted
  gnome-tweaks
  gnome-software
  ];


virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  
 programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };


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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
