# typed: false
# frozen_string_literal: true

class Nylas < Formula
  desc "CLI for Nylas API - manage email, calendar, and contacts"
  homepage "https://github.com/nylas/cli"
  version "3.1.20"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.20/nylas_3.1.20_darwin_amd64.tar.gz"
      sha256 "e8efda47d0a688a6047f9dcbcb8fc9f191f39394f76fc3de68dbe59a75285a01"
    end
    if Hardware::CPU.arm?
      url "https://github.com/nylas/cli/releases/download/v3.1.20/nylas_3.1.20_darwin_arm64.tar.gz"
      sha256 "f2075eed8c0e5810bd3d305700347196d874be086012ec539551051a21a2887c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nylas/cli/releases/download/v3.1.20/nylas_3.1.20_linux_amd64.tar.gz"
      sha256 "49832fd0fc4af5d63e2edd0ee7ce5abc81b906017f82b2584f3e77c3863ad8c0"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nylas/cli/releases/download/v3.1.20/nylas_3.1.20_linux_arm64.tar.gz"
      sha256 "082f50dcc6adf105d5825f3cc75747ebdc8fbe3efb9a70fb7b6aa1bb33698dbb"
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
