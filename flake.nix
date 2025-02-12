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
          buildInputs = with pkgs; [
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
            libgcc
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
            libv4l
          ];

          CMAKE_INCLUDE_PATH = lib.makeIncludePath [
            libv4l
          ];

          # shellHook = ''
            # alias ls=eza
            # alias find=fd
          # '';
          LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [
            libv4l
            libclang
            xorg.libX11
            xorg.libXfixes
            gtk3
            glib
            pango
            gdk-pixbuf
            cairo
            xorg.libxcb
            libgcc
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
