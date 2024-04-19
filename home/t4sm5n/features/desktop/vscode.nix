{ pkgs, ... }: {
  programs = {
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          arcticicestudio.nord-visual-studio-code
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
          arrterian.nix-env-selector
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
          name = "linuxkeybindings";
          publisher = "fredhappyface";
          version = "1.87.2";
          sha256 = "YGFyYuOcTCwUrc6mGaM3vm7c7+XW5TxHiAAs5n86rOM=";
        }];
      mutableExtensionsDir = false;
      userSettings = {
        # behavior
        "editor.formatOnSave" = true;

        # nix
        "[nix]"."editor.tabSize" = 2;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings.nil.formatting.command" = [ "nixfmt" ];
        "nix.serverSettings.nil.nix.flake.autoArchive" = true;

        # style
        "workbench.colorTheme" = "Nord";
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "terminal.integrated.fontSize" = 14;
      };
      package = pkgs.unstable.vscode;
    };
  };
}