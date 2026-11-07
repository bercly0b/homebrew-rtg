class Rtg < Formula
  desc "A terminal-first Telegram client written in Rust."
  homepage "https://github.com/bercly0b/rtg"
  version "0.1.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.15/rtg-tui-aarch64-apple-darwin.tar.xz"
      sha256 "1e83d7983b3f59a5cea51abf7b1647069828c6d36ebda00167a1981f706dc94e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.15/rtg-tui-x86_64-apple-darwin.tar.xz"
      sha256 "b8d2d5269f34b8d8c965a0b4e9b912203332a1ef6d9d14bd34313450f7753d34"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.15/rtg-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ce77865545cc0167ec9ce3d49b2eba16a69f094f768be8f391b594768369a605"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.15/rtg-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8df0bb856eba7ac2f8543975abaa49e535ce7fd516913ad7601b6d4929bd59f6"
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
