# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.18/nylas_3.1.18_darwin_amd64.tar.gz"
      sha256 "3e12ea6039c752b7c6b890a86d1c189936bb4cf1c2d2bb36e925d15fc24bf569"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.18/nylas_3.1.18_darwin_arm64.tar.gz"
      sha256 "a5045f84146d17ef7bf869ba6bd4ad81cad76f66a5273b1eba5c4641764012ce"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.18/nylas_3.1.18_linux_amd64.tar.gz"
      sha256 "5aee2bac3d538b1ec117ed7949238d76402ae1177227346ecd62348bc9ec61b5"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.18/nylas_3.1.18_linux_arm64.tar.gz"
      sha256 "f369f633e68194451652af5d745395ae82544111a1bc49f11cbbbb1cd6b878bc"
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
