# homebrew-chip-tool

Homebrew tap to install [`chip-tool`](https://github.com/project-chip/connectedhomeip/tree/master/examples/chip-tool),
the Matter (Project CHIP) controller CLI for commissioning and controlling Matter devices.

## Install

```sh
brew tap tomhoenderdos/chip-tool
brew install chip-tool
```

## How this works

connectedhomeip has no upstream Homebrew formula. Its from-source build requires
the **pigweed bootstrap**, which fetches toolchain packages over the network —
and Homebrew builds run in a no-network sandbox, so that bootstrap can't run
inside `brew install`.

So this tap ships a **prebuilt binary** as a GitHub Release asset. The formula
just downloads and installs it — no compilation. The binary links only macOS
system frameworks plus `libc++`/`libSystem`/`libobjc`, so it is fully relocatable
with zero Homebrew runtime dependencies.

- Built from connectedhomeip commit `c31ed09`.
- Currently `arm64` (Apple Silicon) only. x86_64 can be added as a second asset
  behind an `on_intel do ... end` block.

## Releasing a new build

```sh
# 1. Build chip-tool from connectedhomeip (source), then:
cp <connectedhomeip>/out/chip-tool/chip-tool dist/chip-tool
tar -czf dist/chip-tool-arm64.tar.gz -C dist chip-tool
shasum -a 256 dist/chip-tool-arm64.tar.gz   # update sha256 in the formula

# 2. Cut a release and upload the asset
gh release create vYYYY.M.D dist/chip-tool-arm64.tar.gz

# 3. Bump version, url tag, and sha256 in Formula/chip-tool.rb to match the
#    new release, then commit and push:
git add Formula/chip-tool.rb
git commit -m "Update chip-tool to vYYYY.M.D"
git push
```
