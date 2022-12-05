import os
os.system("xcode-select -—install")
os.system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
os.system("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")
os.system("brew install neovim")
os.system("brew install ripgrep")
os.system("brew install cloc")
os.system("brew install lua")
