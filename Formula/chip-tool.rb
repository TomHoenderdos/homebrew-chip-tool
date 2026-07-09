class ChipTool < Formula
  desc "Matter (Project CHIP) controller CLI for commissioning and controlling devices"
  homepage "https://github.com/project-chip/connectedhomeip/tree/master/examples/chip-tool"
  license "Apache-2.0"
  version "2026.7.9"

  # Prebuilt binary. connectedhomeip's from-source build requires the pigweed
  # bootstrap, which fetches toolchain packages over the network and cannot run
  # inside Homebrew's no-network build sandbox. So we ship an already-built binary
  # (built from connectedhomeip commit c31ed09) as a release asset instead.
  #
  # The binary links only macOS system frameworks + libc++/libSystem/libobjc,
  # so it is fully relocatable with no Homebrew runtime dependencies.
  on_arm do
    url "https://github.com/TomHoenderdos/homebrew-chip-tool/releases/download/v2026.7.9/chip-tool-arm64.tar.gz"
    sha256 "b28aa2d4899f7a0eb6512b4adfd7b9e5957eee959700f213623ae31e3927f2c4"
  end

  def install
    bin.install "chip-tool"
  end

  test do
    # Bare invocation prints usage and exits non-zero.
    output = shell_output("#{bin}/chip-tool 2>&1", 1)
    assert_match "Usage:", output
  end
end
