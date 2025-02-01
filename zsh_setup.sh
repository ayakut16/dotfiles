#!/usr/bin/env bash

# 1. Update and install zsh
echo "Updating apt and installing zsh..."
sudo apt-get update
sudo apt-get install -y zsh

# 2. Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# 3. Install fzf
echo "Installing fzf..."
sudo apt-get install -y fzf

# 4. Ensure Zsh is the default shell for the current user
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell for $USER..."
    sudo chsh -s "$(which zsh)" "$USER"
else
    echo "Zsh is already the default shell."
fi

# 5. Symlink .zshrc from dotfiles
echo "Ensuring ~/.zshrc is linked to ~/dotfiles/.zshrc..."
rm -f ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

# 6. Ensure the shell is restarted properly
echo "Setup complete. Restarting shell to ensure Zsh is fully applied..."

# If running inside SSH or a terminal, exit to force a relogin
if [ -n "$SSH_TTY" ] || [ -n "$TERM" ]; then
    echo "Please log out and log back in for Zsh to be the default shell."
    exit
else
    exec zsh -l
fi

