#!/bin/bash

which -s brew
if [[ $? != 0 ]] ; then
    -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

brew install git
brew tap microsoft/git
brew install --cask git-credential-manager-core
brew install --cask powershell
brew install --cask visual-studio-code
brew install kubernetes-cli
brew install azure-cli
brew install helm
brew install minikube
brew install node
brew tap instrumenta/instrumenta
brew install kubeval

# install vscode extensions
code --install-extension ms-vscode.azure-account --force
code --install-extension ms-azure-devops.azure-pipelines --force
code --install-extension msazurermtools.azurerm-vscode-tools --force
code --install-extension ms-azuretools.vscode-bicep --force
code --install-extension eamodio.gitlens --force
code --install-extension Tim-Koehler.helm-intellisense --force
code --install-extension streetsidesoftware.code-spell-checker --force
code --install-extension blackmist.LinkCheckMD --force
code --install-extension docsmsft.docs-build --force
code --install-extension docsmsft.docs-authoring-pack --force
code --install-extension shd101wyy.markdown-preview-enhanced --force
code --install-extension bierner.markdown-mermaid --force
code --install-extension DavidAnson.vscode-markdownlint --force
code --install-extension redhat.vscode-yaml --force
code --install-extension ms-dotnettools.csharp --force
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools --force
code --install-extension ms-vscode.PowerShell --force

# git auto-complete for zsh
hasAutoComplete=$(grep -i "autoload -Uz compinit && compinit" ~/.zshrc)
if [ -z "$hasAutoComplete" ]; 
then 
    echo 'autoload -Uz compinit && compinit' >> ~/.zshrc
    source ~/.zshrc
fi