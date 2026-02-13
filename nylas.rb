# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.7/nylas_3.0.7_darwin_amd64.tar.gz"
      sha256 "ba60c321fe9db6fde90146c78d5c96a15ad1189cfeaf9c2d190f82091b6abe42"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.0.7/nylas_3.0.7_darwin_arm64.tar.gz"
      sha256 "edd2b20b724a9e9e2443386810451c23ed741d6938f639bf1db05fc62ce185ed"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.0.7/nylas_3.0.7_linux_amd64.tar.gz"
      sha256 "4a99b0b5fad2b8e768399bbe7c0231e46ac0799e85a97569eedc826ebd42d70a"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.0.7/nylas_3.0.7_linux_arm64.tar.gz"
      sha256 "052098e01d461ba59b459e6d586a16172027ca3fa8113f25d5f8ef5dc4db40c6"
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
