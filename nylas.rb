# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.3/nylas_3.1.3_darwin_amd64.tar.gz"
      sha256 "92d05a1e03184a71c90ba0e3b69ceeb35b9067cfd8323bb5037a7175a9fe93c9"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.3/nylas_3.1.3_darwin_arm64.tar.gz"
      sha256 "54511612c54ff9e91995b96b46bdd296091f50da2dcb1290876997f910d31bba"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.3/nylas_3.1.3_linux_amd64.tar.gz"
      sha256 "7998385a9d478709f123194bb5889abf0384a5fc40104dd84fd4a6b21324a26e"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.3/nylas_3.1.3_linux_arm64.tar.gz"
      sha256 "85b9cea69e1e9cd142b73303d3e1f51e5020fd4636a4998755b771bac85987c2"
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
