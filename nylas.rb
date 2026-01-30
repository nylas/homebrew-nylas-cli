# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.0/nylas_3.0.0_darwin_amd64.tar.gz"
      sha256 "cf7320376ba14b3d881673823825485510932bdbc74fd8403ed193217b2622e5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.0/nylas_3.0.0_darwin_arm64.tar.gz"
      sha256 "b16b7fc1d6c1ebf0044e296b92e2e21f81dc12bb1659a0f70bdbde946adb087f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.0/nylas_3.0.0_linux_amd64.tar.gz"
      sha256 "50f3cb2cc073f8d425db07c04a4d9390a01fff7867f810a5a7bf76fe02442718"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.0/nylas_3.0.0_linux_arm64.tar.gz"
      sha256 "35bf5f31b90434f9572245279154563f10888b2cdc09536e4fa0c4b5cfaaa76a"
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
