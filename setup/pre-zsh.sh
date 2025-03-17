#!/usr/bin/env bash

# Install git - todo

# Install Homebrew - todo

# Install JQ - ToDo

# Install HTTPIE - ToDo

# Install VIM - ToDo

# Setup Github SSH

echo "Creating SSH key for personal Github..."

# ssh-keygen -o -t rsa -C "ssh-keygen@mcnz.com"
ssh-keygen -t ed25519 -C "lucas.gansberg@gmail.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/personalGH
# ssh-add ~/.ssh/id_rsa_work # not using keychain

echo "Personal Github ssh key created!"

echo "Setting up git creds..."

# Setup global config for the machine you primarily use it for
git config --global user.name "Lucas Gansberg"
git config --global user.email "lucas.gansberg@gmail.com"

# Setup local config per repo for others
# git config user.name "Lucas Gansberg"
# git config user.email "lucas.gansberg@gmail.com"