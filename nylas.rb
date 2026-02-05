# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.6/nylas_3.0.6_darwin_amd64.tar.gz"
      sha256 "900d4d5e3bf1708701d9257bf07f82111060b82e6abcde06416225b79bea2f87"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.6/nylas_3.0.6_darwin_arm64.tar.gz"
      sha256 "b17419176d0f2307b70d82aa8a2a5301329915510f46cb9c1c7c3b82627aeb55"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.6/nylas_3.0.6_linux_amd64.tar.gz"
      sha256 "47c4ea080eaedb721170f64b96df7c98a01c979efe93707e96e57dec78e97143"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.6/nylas_3.0.6_linux_arm64.tar.gz"
      sha256 "edb76cf2c361506846927c250aaed365c7669a5dad4696c94838d2821c4ee75a"
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
