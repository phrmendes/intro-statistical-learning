{
  description = "Dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {

        packages = with pkgs; [
          python313
          uv
        ];

        env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
          with pkgs;
          [
            stdenv.cc.cc.lib
            zlib
          ]
        );
      };
    };
}
