with import <nixpkgs> {};

let
  unstable = import
    (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/b172a41aea589d5d71633f1fe77fc4da737d4507.tar.gz")
    # reuse the current configuration
    { config = config; };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    unstable.zls
    zig_0_13
    zlib
    libcxx
    cmake
    clang
    clang-tools
    coreutils
    llvmPackages.libclang
    llvmPackages.lld
    llvmPackages.llvm
    # valgrind
    # For linter script on push hook
    # python3
    # glfw
    # libGL
    # ffmpeg
    # libpulseaudio
    # rustPlatform.bindgenHook
    # rustup
    # clang-tools
  ];

  shellHook = ''
    # We unset some NIX environment variables that might interfere with the zig
    # compiler.
    # Issue: https://github.com/ziglang/zig/issues/18998
    unset NIX_CFLAGS_COMPILE
    unset NIX_LDFLAGS
  '';

  # LD_LIBRARY_PATH = with pkgs.xorg; "${pkgs.mesa}/lib:${libX11}/lib:${libXcursor}/lib:${libXxf86vm}/lib:${libXi}/lib:${libXrandr}/lib:${pkgs.libGL}/lib:${pkgs.gtk3}/lib:${pkgs.cairo}/lib:${pkgs.gdk-pixbuf}/lib:${pkgs.fontconfig}/lib:${wayland}/lib:${libxkbcommon}/lib";
}
