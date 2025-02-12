build:
    docker run --rm -it -v $PWD:/home/user/rustdesk -v rustdesk-git-cache:/home/user/.cargo/git -v rustdesk-registry-cache:/home/user/.cargo/registry -e PUID="$(id -u)" -e PGID="$(id -g)" rustdesk-builder

run $LD_RUN_PATH="$LD_LIBRARY_PATH" $RUSTDESK_FORCED_DISPLAY_SERVER="x11":
    ./target/debug/rustdesk

run2 $LD_RUN_PATH="$LD_LIBRARY_PATH" $RUSTDESK_FORCED_DISPLAY_SERVER="x11" $RUSTDESK_IPC_DIR="RustDesk2" $RUSTDESK_HOST_ID="1234567890":
    ./target/debug/rustdesk
