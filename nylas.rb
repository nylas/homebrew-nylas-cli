# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Nylas < Formula
  desc "Nylas Command Line Utility"
  homepage "https://nylas.com"
  version "1.0.0-preview10"
  bottle :unneeded
  depends_on :macos

  on_macos do
    if Hardware::CPU.intel?
      url "https://download.nylas.com/nylas-cli/v1.0.0-preview10/nylas-cli_1.0.0-preview10_darwin_amd64.tar.gz"
      sha256 "0b1cb9adc9864e2e54bb033f4f35112417619f43e81df5f80fc50ff190416938"
    end
  end

  def install
    bin.install "nylas"
  end
end
