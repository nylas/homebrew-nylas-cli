# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.8/nylas_3.0.8_darwin_amd64.tar.gz"
      sha256 "0c6be4982e257d2113188ec6c6f0ee343aefcc148555f431497d11488d38aeed"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.8/nylas_3.0.8_darwin_arm64.tar.gz"
      sha256 "9dfb2a62fd63ddd57c189ed723c2712b5290271eb023360611879f098430db00"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.8/nylas_3.0.8_linux_amd64.tar.gz"
      sha256 "248477f15434edb2eecc7222c7a3752c44575e6080258f6a013a005b5cc8ed61"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.8/nylas_3.0.8_linux_arm64.tar.gz"
      sha256 "86053fce84fad7c9b200fbe48b400987f9bd64cba113272def52d94636d5ee4e"
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
