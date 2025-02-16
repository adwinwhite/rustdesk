build:
    docker run --rm -it -v $PWD:/home/user/rustdesk -v rustdesk-git-cache:/home/user/.cargo/git -v rustdesk-registry-cache:/home/user/.cargo/registry -e PUID="$(id -u)" -e PGID="$(id -g)" rustdesk-builder

# And finally figured out how to build natively.
build-lib:
    cargo build --features "flutter,linux-pkg-config" --ignore-rust-version --lib

[no-cd]
build-flutter:
    docker run --rm -v /home/adwin/Code/rust/rustdesk-docker/target:/home/adwin/Code/rust/rustdesk-docker/target:ro -v /nix/store:/nix/store:ro -v /home/adwin/.pub-cache:/home/adwin/.pub-cache:ro -v .:/app -w /app instrumentisto/flutter:3.24.4 flutter build linux --debug


[no-cd]
flutter *ARGS:
    docker run --rm -v /home/adwin/Code/rust/rustdesk-docker/target:/home/adwin/Code/rust/rustdesk-docker/target:ro -v /nix/store:/nix/store:ro -v /home/adwin/.pub-cache:/home/adwin/.pub-cache:ro -v .:/app -w /app instrumentisto/flutter:3.24.4 flutter {{ARGS}}


run:
    ./flutter/build/linux/x64/debug/bundle/rustdesk

run2 $RUSTDESK_IPC_DIR="RustDesk2" $RUSTDESK_HOST_ID="1234567890":
    ./flutter/build/linux/x64/debug/bundle/rustdesk
