{ pkgs, lib, fetchFromGitHub }:

lib.makeScope pkgs.newScope (self: with self; {
  allwpilibSources = fetchFromGitHub rec {
    passthru.version = "2024.3.1";

    owner = "wpilibsuite";
    repo = "allwpilib";
    rev = "v${passthru.version}";
    hash = "sha256-H/dMLI2wOiJ+/Z8//Q7QzAFc51dZ3L16evLJI1UaS8c=";
  };

  buildBinTool = callPackage ./suite/build-bin-tool.nix { };
  buildJavaTool = callPackage ./suite/build-java-tool.nix { };

  datalogtool = callPackage ./suite/datalogtool.nix { };
  glass = callPackage ./suite/glass.nix { };
  outlineviewer = callPackage ./suite/outlineviewer.nix { };
  pathweaver = callPackage ./suite/pathweaver.nix { };
  roborioteamnumbersetter = callPackage ./suite/roborioteamnumbersetter.nix { };
  robotbuilder = callPackage ./suite/robotbuilder.nix { };
  shuffleboard = callPackage ./suite/shuffleboard.nix { };
  smartdashboard = callPackage ./suite/smartdashboard.nix { };
  sysid = callPackage ./suite/sysid.nix { };

  vscode-wpilib = callPackage ./vscode-extension { };
})
