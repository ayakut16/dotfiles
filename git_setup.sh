#!/usr/bin/env bash

# 1. Install Git
echo "Installing Git..."
sudo apt-get install -y git

# 2. Configure Git with your default GitHub user
GITHUB_USERNAME="ayakut16"
GITHUB_EMAIL="alperenyakut@gmail.com"

echo "Configuring Git with username: $GITHUB_USERNAME and email: $GITHUB_EMAIL"
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"

# 3. Generate SSH key for GitHub (if not already created)
SSH_KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$SSH_KEY" ]; then
    echo "Generating SSH key for GitHub..."
    ssh-keygen -t ed25519 -C "$GITHUB_EMAIL" -f "$SSH_KEY" -N ""
else
    echo "SSH key already exists."
fi

# 4. Display SSH key and instructions for adding it to GitHub
echo "Copy the SSH key below and add it to your GitHub SSH settings:"
echo "------------------------------------------------------------"
cat "$SSH_KEY.pub"
echo "------------------------------------------------------------"
echo "Go to: https://github.com/settings/keys and add this key."
echo "Once added, press ENTER to continue..."
read -r  # <-- Waits for the user to press Enter

# 5. Ensure SSH agent is running and add the key
eval "$(ssh-agent -s)"
ssh-add "$SSH_KEY"

# 6. Verify SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T git@github.com

echo "GitHub SSH setup complete!"
