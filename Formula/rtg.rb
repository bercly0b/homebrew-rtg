class Rtg < Formula
  desc "A terminal-first Telegram client written in Rust."
  homepage "https://github.com/bercly0b/rtg"
  version "0.1.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.17/rtg-tui-aarch64-apple-darwin.tar.xz"
      sha256 "504c2560f2fd43118d2c69422411d7c0edb1fa9cec8b3b281de0c338de91e535"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.17/rtg-tui-x86_64-apple-darwin.tar.xz"
      sha256 "bf970c3e8fd8522ba2d6d22acc3950c7abaf08d3d4867e1594bce69a7d4fe4b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.17/rtg-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4bc7ff1b903dc3ee9088a5860d2daa2194e54df84bef9dcdf748076709bf9bea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.17/rtg-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f92b9aa0340869a2ce4280c7f345ecebd4f19649fc91a00487d6aec78c51ba29"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rtg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rtg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rtg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rtg"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
