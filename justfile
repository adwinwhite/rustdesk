build:
    docker run --rm -it -v $PWD:/home/user/rustdesk -v rustdesk-git-cache:/home/user/.cargo/git -v rustdesk-registry-cache:/home/user/.cargo/registry -e PUID="$(id -u)" -e PGID="$(id -g)" rustdesk-builder

# And finally figured out how to build natively.
build-lib:
    cargo build --features "flutter,linux-pkg-config" --ignore-rust-version --lib

[no-cd]
build-flutter:
    docker run --rm -v .:/app -w /app instrumentisto/flutter:3.24.4 flutter build linux

run $LD_RUN_PATH="$LD_LIBRARY_PATH" $RUSTDESK_FORCED_DISPLAY_SERVER="x11":
    ./target/debug/rustdesk

run2 $LD_RUN_PATH="$LD_LIBRARY_PATH" $RUSTDESK_FORCED_DISPLAY_SERVER="x11" $RUSTDESK_IPC_DIR="RustDesk2" $RUSTDESK_HOST_ID="1234567890":
    ./target/debug/rustdesk
