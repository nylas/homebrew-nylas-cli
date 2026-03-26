# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.0/nylas_3.1.0_darwin_amd64.tar.gz"
      sha256 "b50f63c29a2f53f37d9c8ef9689bb7afb993e87b8543f4d061475112a551bb09"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.0/nylas_3.1.0_darwin_arm64.tar.gz"
      sha256 "5400277e3ed53485b5fcf9217bd5fd7aa53043a25fb8b733484cd86c9823eb44"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.0/nylas_3.1.0_linux_amd64.tar.gz"
      sha256 "2fb995b0303710af350aaf1d972559d238db84afd4d26cce6066e588251a4dbf"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.0/nylas_3.1.0_linux_arm64.tar.gz"
      sha256 "c5d2838375ebc3caefdb5718d0114266c960f333e56622f1fa44ba270b4dd8fd"
    end
  end

  def install
    bin.install "nylas"

    # Install shell completions
    # Disable keyring during completion generation to avoid macOS Keychain prompts
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    generate_completions_from_executable(bin/"nylas", "completion")
  end

  test do
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    system "#{bin}/nylas", "--version"
  end
end
