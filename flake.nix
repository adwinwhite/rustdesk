{
  description = "A basic project devShell";

  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      with pkgs;
      {
        devShell = mkShell {
          nativeBuildInputs = [ pkg-config ];
          buildInputs = with pkgs; [
            nasm
            cargo-expand
            mold
            just
            rustup
            flutter_rust_bridge_codegen
            flutter
            pkg-config
            glib
            gst_all_1.gst-plugins-base
            gst_all_1.gstreamer
            gdk-pixbuf
            gtk3
            pango
            cairo
            # libgcc
            dbus
            ffmpeg
            fuse3
            xorg.libxcb
            xorg.libXtst
            xorg.libX11
            xorg.libXfixes
            libaom
            libopus
            libpulseaudio
            libva
            libvdpau
            libvpx
            pipewire
            libxkbcommon
            libyuv
            libclang
            pam
            libgit2
            libsodium
            zlib
          ];

          C_INCLUDE_PATH = lib.concatStrings [
            # "${libclang.lib}/lib/clang/19/include:"
            "${stdenv.cc.cc}/lib/gcc/x86_64-unknown-linux-gnu/14.2.1/include:"
            (lib.makeIncludePath [
              linuxHeaders
              glibc
              pam
              libopus.dev
              libvpx.dev
              libaom.dev
              libpulseaudio.dev
              libva.dev
              libvdpau.dev
              libxkbcommon.dev
              libyuv.out
              libgit2.dev
            ])
          ];
          VCPKG_ROOT = "homeless-shelter";
          LIBGIT2_NO_VENDOR = "1"; 
          SODIUM_USE_PKG_CONFIG = "1";

          # shellHook = ''
            # alias ls=eza
            # alias find=fd
          # '';
          LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [
            libgit2
            libsodium
            libclang
            xorg.libX11
            xorg.libXfixes
            gtk3
            glib
            pango
            gdk-pixbuf
            cairo
            xorg.libxcb
            # libgcc
            dbus
            ffmpeg
            fuse3
            gst_all_1.gst-plugins-base
            gst_all_1.gstreamer
            xorg.libXtst
            libaom
            libopus
            libpulseaudio
            libva
            libvdpau
            libvpx
            pipewire
            libxkbcommon
            libyuv
            pam
            xdotool
          ]);
        };
      }
    );
}
