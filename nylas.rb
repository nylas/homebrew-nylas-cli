# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.7/nylas_3.1.7_darwin_amd64.tar.gz"
      sha256 "98362d74ca88f98569bd5027c8a003bef57198d411e39447ddb7888f06ab04ff"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.7/nylas_3.1.7_darwin_arm64.tar.gz"
      sha256 "01c23b4e9e76032be54d3ce8c09a9bc50f3b85f976d067fa930b83ec0b0546e6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.7/nylas_3.1.7_linux_amd64.tar.gz"
      sha256 "f8fbec002c4f4ed08e23513e3c54c82e227785d57be8825b5daf652a8980610f"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.7/nylas_3.1.7_linux_arm64.tar.gz"
      sha256 "60c4cdfc67723418f0ac5c624ef4064fbb92e57cd8b1595957c348f973bf2225"
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
