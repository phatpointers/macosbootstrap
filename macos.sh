#!/bin/zsh

# ask for the administrator password upfront.
sudo -v

# thank you https://github.com/donnybrilliant/install.sh
# keep sudo until script is finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

echo "installing brew..."
if ! command -v brew 2>&1 >/dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "...brew installed"
else
    echo "...brew already installed"
fi

echo "install brew casks"
brew install --cask zed iterm2 firefox rectangle obsidian alfred

echo "install fish..."
if ! command -v fish 2>&1 >/dev/null
then
    brew install fish

    # adding brew to fish path.
    /bin/bash -c "fish && fish_add_path /opt/homebrew/bin"

    # create config file.
    echo >> /Users/phatp/.config/fish/config.fish

    # TODO: figure out what this is actually doing.
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/phatp/.config/fish/config.fish
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # add fish to available shells (if needed)
    grep -qxF "/opt/homebrew/bin/fish" /etc/shells || echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells > /dev/null

    # make fish the default shell
    chsh -s /opt/homebrew/bin/fish

    echo "... fish installed"
else
    echo "...fish already installed"
fi
