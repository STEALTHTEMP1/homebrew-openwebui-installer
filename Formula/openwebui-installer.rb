class OpenwebuiInstaller < Formula
  desc "Easy installer and manager for Open WebUI - User-friendly AI Interface"
  homepage "https://github.com/STEALTHTEMP1/openwebui-installer"
  url "https://github.com/STEALTHTEMP1/openwebui-installer/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "0f50c067ae1604c3825defed7e935f7841e49b125be96af63e4b953f5d1c163e"
  license "MIT"
  head "https://github.com/STEALTHTEMP1/openwebui-installer.git", branch: "main"

  depends_on "curl"
  depends_on "git"
  depends_on "python@3.11"

  def install
    libexec.install Dir["*"]

    (bin/"openwebui-installer").write <<~EOS
      #!/bin/bash
      cd "#{libexec}"
      exec python3 install.py "$@"
    EOS

    chmod 0755, bin/"openwebui-installer"
  end

  def post_install
    ohai "Open WebUI Installer has been installed!"
    ohai "Run 'openwebui-installer --help' to get started"
    ohai ""
    ohai "Common commands:"
    ohai "  openwebui-installer install    # Install Open WebUI"
    ohai "  openwebui-installer start      # Start Open WebUI service"
    ohai "  openwebui-installer stop       # Stop Open WebUI service"
    ohai "  openwebui-installer update     # Update Open WebUI"
    ohai "  openwebui-installer uninstall  # Remove Open WebUI"
  end

  def caveats
    <<~EOS
      Open WebUI Installer has been installed to:
        #{bin}/openwebui-installer

      To get started:
        openwebui-installer install

      The installer will guide you through the setup process.

      For more information, visit:
        https://github.com/STEALTHTEMP1/openwebui-installer
    EOS
  end

  test do
    assert_match "Open WebUI Installer", shell_output("#{bin}/openwebui-installer --version")
  end
end
