# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.9/nylas_3.1.9_darwin_amd64.tar.gz"
      sha256 "b99778be46cbe4c4122d3c00f0d34ffd58302e34f86e0af6e591f0df0e02dec5"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.9/nylas_3.1.9_darwin_arm64.tar.gz"
      sha256 "e6bd1a9b2caa4cceebc635264e270c346077e228f4186c6713c7783712863c2e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.9/nylas_3.1.9_linux_amd64.tar.gz"
      sha256 "be1a575ddeb037fad5661bdbc6c3e684ff1803b6920c519a266dcbdb434ba40d"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.9/nylas_3.1.9_linux_arm64.tar.gz"
      sha256 "0818ebcec2aab6b6d89220507f2c656a2383293779fea2c354ad385d072eeac2"
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
