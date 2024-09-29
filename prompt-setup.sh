#!/bin/bash

# Function to check and install Visual Studio Code
install_vscode() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v code &> /dev/null; then
            echo "Visual Studio Code not found. Installing..."
            brew install --cask visual-studio-code
            echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
            source ~/.zshrc
        else
            echo "Visual Studio Code is already installed."
        fi
    elif [[ "$OSTYPE" == "msys" ]]; then
        if ! command -v code &> /dev/null; then
            echo "Visual Studio Code not found. Installing..."
            powershell -Command "Invoke-WebRequest -Uri https://update.code.visualstudio.com/latest/win32-x64/stable -OutFile vscode_installer.exe; Start-Process -Wait -FilePath vscode_installer.exe -ArgumentList '/silent', '/mergetasks=!runcode'; Remove-Item vscode_installer.exe"
            echo 'if (!(Test-Path -Path $PROFILE)) { New-Item -Type File -Path $PROFILE -Force }; Add-Content -Path $PROFILE -Value "Set-Location -Path $(Get-Command code).Source"' | powershell -NoProfile
        else
            echo "Visual Studio Code is already installed."
        fi
    fi
}

# Function to check and install Azure Storage Explorer
install_storage_explorer() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if ! command -v storage-explorer &> /dev/null; then
            echo "Azure Storage Explorer not found. Installing..."
            brew install --cask microsoft-azure-storage-explorer
        else
            echo "Azure Storage Explorer is already installed."
        fi
    elif [[ "$OSTYPE" == "msys" ]]; then
        if ! command -v storage-explorer &> /dev/null; then
            echo "Azure Storage Explorer not found. Installing..."
            powershell -Command "Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=866472 -OutFile storage_explorer_installer.exe; Start-Process -Wait -FilePath storage_explorer_installer.exe -ArgumentList '/silent'; Remove-Item storage_explorer_installer.exe"
        else
            echo "Azure Storage Explorer is already installed."
        fi
    fi
}

# Function to check and install Git
install_git() {
    if [[ "$OSTYPE" == "msys" ]]; then
        if ! command -v git &> /dev/null; then
            echo "Git not found. Installing..."
            powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/latest/download/Git-2.41.0-64-bit.exe -OutFile git_installer.exe; Start-Process -Wait -FilePath git_installer.exe -ArgumentList '/silent'; Remove-Item git_installer.exe"
        else
            echo "Git is already installed."
        fi
    fi
}

# Function to install VSCode extensions
install_vscode_extensions() {
    extensions=("eamodio.gitlens" "docsmsft.docs-authoring-pack" "mechatroner.rainbow-csv")
    for extension in "${extensions[@]}"; do
        if ! code --list-extensions | grep -q $extension; then
            echo "Installing VSCode extension $extension..."
            code --install-extension $extension
        else
            echo "VSCode extension $extension is already installed."
        fi
    done
}

# Main script execution
install_vscode
install_storage_explorer
install_git
install_vscode_extensions

echo "All installations and configurations checked and completed."
