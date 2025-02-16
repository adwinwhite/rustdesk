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
        flutterRustBridge = pkgs.rustPlatform.buildRustPackage rec {
          pname = "flutter_rust_bridge_codegen";
          version = "1.80.1"; # https://github.com/rustdesk/rustdesk/blob/1.3.2/.github/workflows/bridge.yml#L10

          src = pkgs.fetchFromGitHub {
            owner = "fzyzcjy";
            repo = "flutter_rust_bridge";
            rev = "v${version}";
            hash = "sha256-SbwqWapJbt6+RoqRKi+wkSH1D+Wz7JmnVbfcfKkjt8Q=";
          };

          useFetchCargoVendor = true;
          cargoHash = "sha256-4khuq/DK4sP98AMHyr/lEo1OJdqLujOIi8IgbKBY60Y=";
          cargoBuildFlags = [
            "--package"
            "flutter_rust_bridge_codegen"
          ];
          doCheck = false;
        };
      in
      with pkgs;
      {
        devShell = mkShell rec {
          nativeBuildInputs = [ pkg-config ];
          buildInputs = with pkgs; [
            sysprof
            nasm
            cargo-expand
            mold
            just
            rustup
            flutterRustBridge
            # too new
            # flutter_rust_bridge_codegen
            flutter324
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
            ninja
            cmake
            clang
            pam
            libgit2
            libsodium
            zlib
            xdotool
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
          CMAKE_INCLUDE_PATH = C_INCLUDE_PATH;
          VCPKG_ROOT = "homeless-shelter";
          LIBGIT2_NO_VENDOR = "1"; 
          SODIUM_USE_PKG_CONFIG = "1";
          RUSTDESK_FORCED_DISPLAY_SERVER = "x11";

          # shellHook = ''
          # '';
          LD_LIBRARY_PATH = lib.concatStrings [
            "${libgcc}/lib/gcc/x86_64-unknown-linux-gnu/14.2.1:"
            "/home/adwin/Code/rust/rustdesk-docker/target/debug:"
            (lib.makeLibraryPath (with pkgs; [
              harfbuzz.out
              at-spi2-atk.out
              libdeflate
              libepoxy
              gdk-pixbuf
              fontconfig.lib
              libvmaf.out
              # libgcc
              # glibc
              # iconv.out
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
            ]))
          ];
          LD_RUN_PATH = LD_LIBRARY_PATH;
          CMAKE_LIBRARY_PATH = LD_LIBRARY_PATH;
          LIBRARY_PATH = LD_LIBRARY_PATH;
        };
      }
    );
}
