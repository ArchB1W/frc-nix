{
  vscode-utils,
  allwpilibSources,
  fetchurl,
  lib,
}:
vscode-utils.buildVscodeExtension rec {
  pname = "${vscodeExtPublisher}-${vscodeExtName}";
  name = "${vscodeExtPublisher}-${vscodeExtName}-${version}";
  version = allwpilibSources.version;

  src = fetchurl {
    url = "https://github.com/wpilibsuite/vscode-wpilib/releases/download/v${version}/vscode-wpilib-${version}.vsix";
    hash = "sha256-MTIK4DAD57Ok4orgrcP2ZwtGMK2l+dUkYc4OfVkewp4=";
    # The `*.vsix` file is in the end a simple zip file. Change the extension
    # so that existing `unzip` hooks takes care of the unpacking.
    name = "${name}.zip";
  };

  # VSCode Metadata
  vscodeExtPublisher = "wpilibsuite";
  vscodeExtName = "vscode-wpilib";
  vscodeExtUniqueId = "wpilibsuite.vscode-wpilib-${version}";

  # Package metadata
  meta = with lib; {
    description = "Visual Studio Code WPILib extension";
    homepage = "https://github.com/wpilibsuite/vscode-wpilib";
    license = licenses.bsd3;
    maintainers = with maintainers; [max-niederman];
    platforms = ["x86_64-linux"];
  };
}
