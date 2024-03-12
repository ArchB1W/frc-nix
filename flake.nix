{
  description = "Nix packages and NixOS modules for the FIRST Robotics Competition, maintained by team 3636.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, flake-utils, nixpkgs }:
    let
      frcOverlay = final: prev: with final; {
        advantagescope = callPackage ./pkgs/advantagescope { };
        choreo = callPackage ./pkgs/choreo { };
        pathplanner = callPackage ./pkgs/pathplanner { };
        photonvision = callPackage ./pkgs/photonvision { };
        wpilib = recurseIntoAttrs (callPackage ./pkgs/wpilib { });
      };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "armv7l-linux"
        "armv6l-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
    in
    {
      overlays.default = frcOverlay;
      nixosModules.default = import ./modules inputs;
    }
    //
    (flake-utils.lib.eachSystem supportedSystems
      (system:
        let pkgs = import nixpkgs { inherit system; overlays = [ frcOverlay ]; }; in {
          packages = {
            inherit (pkgs)
              advantagescope
              choreo
              pathplanner
              photonvision;
            inherit (pkgs.wpilib)
              datalogtool
              glass
              outlineviewer
              pathweaver
              roborioteamnumbersetter
              robotbuilder
              shuffleboard
              smartdashboard
              sysid;
          };

          devShell = pkgs.mkShell {
            name = "frc-nix";
            packages = with pkgs; [
              nushell
              xxd

              nixos-generators

              typst
            ];

            TYPST_FONT_PATHS = nixpkgs.lib.strings.concatStringsSep ":" (with pkgs; [ montserrat libre-baskerville ]);
          };
        }));
}
