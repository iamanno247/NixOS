{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # VOXTYPE
    inputs.voxtype.packages.${pkgs.system}.vulkan
    wtype
    wl-clipboard

    # DEV
    neovim
    zed-editor
    python314Packages.pip
    vscode

    # CLI
    curl
    nmap
    wget
    fetch
    ncdu
    btop
    nh

    # TUI
    claude-code

    # GIT
    git
    lazygit
    github-cli

    # APPS
    openrgb
    chromium
    lact
    gpu-screen-recorder-ui
    easyeffects
    # discord - REMOVED: Managed by NixCord
    proton-vpn
    mission-center
    nwg-look
    hydralauncher
    obs-studio

    # PACKAGES
    nil
    nixd
    tumbler
    ffmpegthumbnailer
    ffmpeg-headless
    lm_sensors
    wlsunset
    lua5_1
    lua51Packages.luarocks
    vimPlugins.LazyVim
    lsp-plugins
    uv
    unzip

    # LARP
    unimatrix
    cbonsai
    lavat
  ];

  # STEAM WITH SLSSTEAM
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        LD_AUDIT = "${
          inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
        }/library-inject.so:${
          inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
        }/SLSsteam.so";
      };
    };
  };

  # COOLER CONTROL
  programs.coolercontrol = {
    enable = true;
  };

  # APPIMAGE SUPPORT FOR NIXOS
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
}
