# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.3/nylas_3.0.3_darwin_amd64.tar.gz"
      sha256 "c8cc3a80ce84ff198b1398958686fecf32a6371f80f7f2a3e15753d8b7154ae8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.3/nylas_3.0.3_darwin_arm64.tar.gz"
      sha256 "4e5c389b43c8d5f85899bab4739190afb43ac7581df21fb78b3124979ef14ee5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.3/nylas_3.0.3_linux_amd64.tar.gz"
      sha256 "0c745ad80472fde33d9c2e579b9af22fcbe9462500700b41654102814c058ec9"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.3/nylas_3.0.3_linux_arm64.tar.gz"
      sha256 "7172c4cbefa4ab7412d3fbc27bb190142af7b159bebaf689d9cab1a87bbc8636"
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
