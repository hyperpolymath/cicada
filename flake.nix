# SPDX-License-Identifier: AGPL-3.0-or-later
# SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
# flake.nix - Nix fallback for CIcaDA
# Primary package manager: Guix (see guix.scm)
{
  description = "CIcaDA - Quantum-Resistant Cryptographic Identity Management";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "cicada-dev";

          buildInputs = with pkgs; [
            # Julia environment
            julia-bin

            # Build tools
            git
            gnumake

            # SSH key generation dependencies
            openssh
            openssl

            # Development tools
            just

            # Optional: for documentation
            asciidoctor
          ];

          shellHook = ''
            echo "CIcaDA Development Environment (Nix)"
            echo "====================================="
            echo "Julia version: $(julia --version)"
            echo ""
            echo "Run 'julia --project=. -e \"using Pkg; Pkg.instantiate()\"' to install Julia deps"
            echo "Run 'julia --project=. src/main.jl --help' for CLI usage"
            echo ""
            echo "Note: Guix is the primary package manager. See guix.scm"
          '';

          # Environment variables
          JULIA_PROJECT = ".";
        };

        # Package definition (for nix build)
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "cicada";
          version = "0.1.0";

          src = ./.;

          buildInputs = with pkgs; [
            julia-bin
            openssh
            openssl
          ];

          # Julia packages are typically not compiled this way
          # This is a placeholder for potential future packaging
          dontBuild = true;

          installPhase = ''
            mkdir -p $out/share/cicada
            cp -r src $out/share/cicada/
            cp -r test $out/share/cicada/
            cp Project.toml $out/share/cicada/
            cp README.md $out/share/cicada/ || true
            cp LICENSE $out/share/cicada/ || true

            mkdir -p $out/bin
            cat > $out/bin/cicada <<EOF
            #!/bin/sh
            exec ${pkgs.julia-bin}/bin/julia --project=$out/share/cicada $out/share/cicada/src/main.jl "\$@"
            EOF
            chmod +x $out/bin/cicada
          '';

          meta = with pkgs.lib; {
            description = "Quantum-Resistant Cryptographic Identity Management";
            homepage = "https://github.com/hyperpolymath/cicada";
            license = licenses.agpl3Plus;
            platforms = platforms.unix;
            maintainers = [ ];
          };
        };
      }
    );
}
