class Rtg < Formula
  desc "A terminal-first Telegram client written in Rust."
  homepage "https://github.com/bercly0b/rtg"
  version "0.1.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.16/rtg-tui-aarch64-apple-darwin.tar.xz"
      sha256 "ef3a2f3eb7c02f2409b2b1a6f07d65a41d3a6553503fba5c456bdc615ece4f2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.16/rtg-tui-x86_64-apple-darwin.tar.xz"
      sha256 "55fcbec7070c43b618f5e48259bf0f3b1a95985390c5cd5d6f74486f142350c6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.16/rtg-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "91aa2e864065f19d9f0ddac32e751754bdea1f0c85cc283a2f094d729cd18e16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bercly0b/rtg/releases/download/v0.1.16/rtg-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf885991a0141e4a7f97bfa143dc45e999215ca5ccd8d1f601567874e3ec75c1"
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
