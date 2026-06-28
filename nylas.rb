# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.28"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.28/nylas_3.1.28_darwin_amd64.tar.gz"
      sha256 "a9206ba77c1d5ca0220ef5c46902769158fd229df569056bb00fffec327526d8"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.28/nylas_3.1.28_darwin_arm64.tar.gz"
      sha256 "17334f5fca77fc37f4ecb1a7d87863b011f115e556597302d892fab6378f53ce"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.28/nylas_3.1.28_linux_amd64.tar.gz"
      sha256 "c136237a41bc3d8496a75391ac8234d39f05aa87c45050865f1f3ed11fa0c3bc"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.28/nylas_3.1.28_linux_arm64.tar.gz"
      sha256 "ac20355a41edec874dfd4a9cca6b4e0d6853aac4a3e2118762c49888c3045fc1"
    end
  end

  def install
    bin.install "nylas"

    # Install shell completions
    # Disable keyring during completion generation to avoid macOS Keychain prompts
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    generate_completions_from_executable(bin/"nylas", "completion")
  end

  def caveats
    <<~EOS
      Get started:
        nylas init

      Install Nylas skills for AI Agents (https://github.com/nylas/skills):
        npx skills add nylas/skills                          # all skills
        npx skills add nylas/skills --skill nylas-api        # individual
        npx skills add nylas/skills --skill nylas-cli

      Documentation: https://cli.nylas.com/
      Issues: https://github.com/nylas/cli/issues
      Changelog: https://github.com/nylas/cli/releases
    EOS
  end

  test do
    ENV["NYLAS_DISABLE_KEYRING"] = "true"
    system "#{bin}/nylas", "--version"
  end
end
