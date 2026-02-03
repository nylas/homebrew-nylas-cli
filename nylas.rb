# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.4/nylas_3.0.4_darwin_amd64.tar.gz"
      sha256 "49175dc648d618b01dcb9954bae800a99a62d4a7661786f2b1c1da4bb4697b92"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.4/nylas_3.0.4_darwin_arm64.tar.gz"
      sha256 "45815e23f2fdddb6e34eb6a321faf081bf2901879dae2a11f4e64115a515774e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.4/nylas_3.0.4_linux_amd64.tar.gz"
      sha256 "151c6c201534055c044d490a91c5c65bed020b7db935714363668673f9f84278"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.4/nylas_3.0.4_linux_arm64.tar.gz"
      sha256 "26d9eb18cf57647e3e7413b914c91139867ffe2d61a340bb3a413ce6b0ef4f58"
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
