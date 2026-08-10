# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.29"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.29/nylas_3.1.29_darwin_amd64.tar.gz"
      sha256 "cfd9aafc5c3f41fa1fb6cf600606c8ca2d6635394afcd39d5ca211603cc514cd"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.29/nylas_3.1.29_darwin_arm64.tar.gz"
      sha256 "9add773624464981a4e88b1b231357e85a4109fd9394c4930408a1e36d5a6068"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.29/nylas_3.1.29_linux_amd64.tar.gz"
      sha256 "e80429883ef688739c2330daa1d8b30939bf884b4145b7f5854a3025dc29174e"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.29/nylas_3.1.29_linux_arm64.tar.gz"
      sha256 "ddd0ebf9195a0c96d25c6caecffea2389ccf6f0795b5f0d63292e94f10366305"
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
