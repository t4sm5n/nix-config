{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../common
    ./backup.nix
    ./desktop.nix
    ./disko.nix
    ./hardware-additional.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ./vm.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = with pkgs; [
    curl
    git
    kitty
    neovim
  ];

  fonts.packages = [ pkgs.fira-code ];

  virtualisation = {
    podman.enable = true;
    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
  };

  environment.sessionVariables = {
    FLAKE = "/home/t4sm5n/nix-config";
  };

  programs.steam = {
    enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  age.identityPaths = [ "${config.users.users.t4sm5n.home}/.ssh/id_ed25519" ];

  networking = {
    hostName = "yoshizawa";
    networkmanager.enable = true;
  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  system.stateVersion = "24.05";
}
