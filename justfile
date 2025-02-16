build:
    docker run --rm -it -v $PWD:/home/user/rustdesk -v rustdesk-git-cache:/home/user/.cargo/git -v rustdesk-registry-cache:/home/user/.cargo/registry -e PUID="$(id -u)" -e PGID="$(id -g)" rustdesk-builder

# And finally figured out how to build natively.
build-lib:
    cargo build --features "flutter,linux-pkg-config" --ignore-rust-version --lib

[no-cd]
build-flutter:
    docker run --rm -v /home/adwin/Code/rust/rustdesk-docker/target:/home/adwin/Code/rust/rustdesk-docker/target:ro -v /nix/store:/nix/store:ro -v /home/adwin/.pub-cache:/home/adwin/.pub-cache:ro -v .:/app -w /app instrumentisto/flutter:3.24.4 flutter build linux --debug

[no-cd]
build-bridge:
    flutter_rust_bridge_codegen --rust-input ../src/flutter_ffi.rs --dart-output ./lib/generated_bridge.dart --llvm-path /nix/store/isxsfmzsxsh1xa3lyh66zkv8w0qziai8-clang-19.1.5-lib/lib/libclang.so


[no-cd]
flutter *ARGS:
    docker run --rm -v /home/adwin/Code/rust/rustdesk-docker/target:/home/adwin/Code/rust/rustdesk-docker/target:ro -v /nix/store:/nix/store:ro -v /home/adwin/.pub-cache:/home/adwin/.pub-cache:ro -v .:/app -w /app instrumentisto/flutter:3.24.4 flutter {{ARGS}}


run $RUST_LOG="debug":
    ./flutter/build/linux/x64/debug/bundle/rustdesk

run2 $RUSTDESK_IPC_DIR="RustDesk2" $RUSTDESK_HOST_ID="1234567890" $RUST_LOG="debug":
    ./flutter/build/linux/x64/debug/bundle/rustdesk
