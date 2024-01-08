{
  description = "A flake providing the source for the zig-sqlite zig package";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.zig-sqlite = import "${self}" { pkgs = nixpkgs.legacyPackages.x86_64-linux; };

    packages.x86_64-linux.default = self.packages.x86_64-linux.zig-sqlite;

  };
}
