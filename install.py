import os
os.system("xcode-select -—install")
os.system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
os.system("curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh")
os.system('sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"')
brew_packages = [
    "neovim",
    "cloc",
    "lua",
    "cmake",
    "fzf",
    "tree",
    "miniconda",
    "lazygit",
    "trash",
    "npm"
]
for package in brew_packages:
    os.system(f"brew install {package}")
os.system('curl -s "https://get.sdkman.io" | bash')
os.system('source "$HOME/.sdkman/bin/sdkman-init.sh"')
sdkman_packages = [
    "java 20.0.1-oracle",
    "java 8.0.382-amzn",
    "groovy 4.0.0",
    "gradle 8.3"
]

for package in sdkman_packages:
    os.system("sdk install {package}")
