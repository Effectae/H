set -x EDITOR vi
set -x MANPAGER nvim\x20\x2bMan\x21
set -x PAGER nvim\x20\x2bMan\x21

function start-sway
    WLR_DRM_DEVICES="/dev/dri/card0" dbus-run-session -- sway
end

if not set -q "$ANDROID_HOME" 
    set -x ANDROID_HOME "$HOME/Android"
    if test -d "$ANDROID_HOME"
        set -a PATH "$ANDROID_HOME/cmdline-tools/latest/bin"
    else
        set -e ANDROID_HOME
    end
end

abbr cls clear

abbr lms 'meson setup build --buildtype release --prefix "~/.local"'
abbr msi meson install -C build

set -l cms 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -GNinja -Bbuild'
abbr cms $cms
abbr cmsp $cms -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_CXX_FLAGS='-stdlib=libc++'
abbr cmc cmake --build build

abbr ca cargo

abbr fei for e in

export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

set_home LOCAL_LLVM "$HOME/.local/llvm" -Bp

set_home GO "$HOME/go" -B
set_home CARGO "$HOME/.cargo" -Bp
set_home ZIG "$HOME/.local/zig" -B
set_home LOCAL_PYTHON "$HOME/dev_env/local_pip" -Bp

set_home FLUTTER "$HOME/dev_env/flutter/flutter" -B
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export PUB_HOSTED_URL="https://pub.flutter-io.cn"

