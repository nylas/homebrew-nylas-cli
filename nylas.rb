# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v1.0.0/nylas_1.0.0_darwin_amd64.tar.gz"
      sha256 "bf24147b0060845b3d46354be27c4ebc29ee4d8af2943513528b9f9b1c43ca65"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v1.0.0/nylas_1.0.0_darwin_arm64.tar.gz"
      sha256 "85cea6166fde7fae056115c25aa22a547451e04de776c3d69c59deaf6d601e0f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v1.0.0/nylas_1.0.0_linux_amd64.tar.gz"
      sha256 "130ebb281f881bbe1f51022c7078d8f0294b75da84448f21536f429c0503e6e2"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v1.0.0/nylas_1.0.0_linux_arm64.tar.gz"
      sha256 "4788684fa91c063de7c8b1a8ae7f05741518d646162fbaf750c9f0ae398e682a"
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
