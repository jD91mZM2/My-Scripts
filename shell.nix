{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby
    perl
    (python37.withPackages (pypkgs: with pypkgs; [
      tkinter
    ]))
  ];
}
