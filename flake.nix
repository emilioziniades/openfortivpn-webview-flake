{
  description = "openfortivpn-webview flake";

  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.default = self.packages.x86_64-linux.openfortivpn-webview;
    packages.x86_64-linux.openfortivpn-webview = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
    in
      pkgs.stdenv.mkDerivation {
        pname = "openfortivpn-webview";
        version = "1.1.0-electron";
        src = pkgs.fetchFromGitHub {
          owner = "gm-vm";
          repo = "openfortivpn-webview";
          rev = "48aab35f79c0feca3bfc9f79cf266dbf796b1040";
          sha256 = "sha256-SZaC5bN2cYaMIOhqxisd3AXqKO4P/kmBcbg0IaEflr4=";
        };
        nativeBuildInputs = with pkgs; [
          libsForQt5.qt5.qtwebengine
          libsForQt5.qt5.qtbase
          libsForQt5.qt5.wrapQtAppsHook
          gnumake
          gcc
        ];
        buildPhase = ''
          cd openfortivpn-webview-qt
          qmake .
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp openfortivpn-webview /$out/bin
        '';
      };
  };
}
