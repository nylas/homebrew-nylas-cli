# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.2/nylas_3.0.2_darwin_amd64.tar.gz"
      sha256 "d0773d20ed7dbdd207565dc47bb3986e763d1567ba472572eb9f30e26c4e5e39"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.2/nylas_3.0.2_darwin_arm64.tar.gz"
      sha256 "2d93b24a01668a00607feb2ca3d116e5c4d5ca9d36feb6b4530b44850e4a4d70"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.2/nylas_3.0.2_linux_amd64.tar.gz"
      sha256 "396eb46653f498a5840124c5d4c96be1c575437e97131ab338284fad637df90a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.2/nylas_3.0.2_linux_arm64.tar.gz"
      sha256 "5bb69dc9884247e57bfb20b903d22f33ce53a200b4f725ce19c8f89a210fd897"
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
