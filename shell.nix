{ pkgs ? import <nixpkgs> {} }:
let
  libs = with pkgs; [
    boost
    cmake
    clang
    clang-tools
    clang-tidy-sarif
    clang-analyzer
    libclang
    llvm
    libffi
    stb
    entt
    gcc
    lld
    bolt
    pkg-config
    gdb
    catch2
    nodejs
    catch2_3
    cargo
    valgrind
    libxml2
  ];
  lib = libs;
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    cppcheck
    clang-tools
    codespell
    conan
    doxygen
    gtest
    lcov
    vcpkg
    vcpkg-tool
  ];
  buildInputs = libs;
  # XDG_DATA_DIRS = builtins.getEnv "XDG_DATA_DIRS";
  # XDG_RUNTIME_DIRS = "/run/user/1001/";
  shellHook = ''
    echo "morning.lang Dev Shell"
    # Ensure proper environment setup for GCC and glibc
    # Correct the CXXFLAGS by removing `.dev` from the GCC path
    export CXXFLAGS="-I${pkgs.gcc}/include/c++/${pkgs.gcc.version} -I${pkgs.glibc}/include"

    export CC=clang
    export CXX=clang++

    uv venv
    source ~/.venv/bin/activate
    uv sync
  '';
}

