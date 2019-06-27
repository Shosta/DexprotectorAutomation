#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Bold
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BBlue='\033[1;34m'        # Blue
BWhite='\033[1;37m'       # White

# Determine Current Shell
currentShell="$(ps -p $$ -axco command | sed -n '$p')"
zsh="zsh"
bash="bash"

reloadShellCmd=""

reloadShell() {
    if [ "$currentShell" = "$zsh" ]; then
        echo -e "Reload your environment variables on your Shell using the following command : \n=> ${BWhite}source ~/.zshrc${Color_Off}"
        reloadShellCmd="source ~/.zshrc"
    elif [ "$currentShell" = "$bash" ]; then
        echo -e "Reload your environment variables on your Shell using the following command : \n=> ${BWhite}source ~/.bashrc${Color_Off}"
        reloadShellCmd="source ~/.bashrc"
    else
        echo "Current Shell is neither Zsh nor Bash"
    fi

}

# 1. Install or Update Homebrew.
echo -e "${BBlue}1.${Color_Off} ${BWhite}Install or Update Homebrew${Color_Off}"
if [[ $(command -v brew) = "" ]]; then
    echo -e "${BGreen}=>${Color_Off} ${BWhite}Installing${Color_Off} ${BGreen}Homebrew${Color_Off}..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo -e "${BGreen}=>${Color_Off} ${BWhite}Updating${Color_Off} ${BGreen}Homebrew${Color_Off}..."
    brew update
fi

# 2. Install jenv using Homebrew
echo -e "\n${BBlue}2.${Color_Off} ${BWhite}Install jenv using Homebrew${Color_Off}"
echo -e "${BGreen}=>${Color_Off} ${BWhite}Installing${Color_Off} ${BGreen}jenv${Color_Off}..."
brew install jenv

# Enable jenv on the Shell
if [ "$currentShell" = "$zsh" ]; then
    echo -e "${BGreen}=>${Color_Off} ${BWhite}Enabling${Color_Off} ${BGreen}jenv${Color_Off} on ${BGreen}ZSH${Color_Off}..."
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(jenv init -)"' >> ~/.zshrc
elif [ "$currentShell" = "$bash" ]; then
    echo -e "${BGreen}=>${Color_Off} ${BWhite}Enabling${Color_Off} ${BGreen}jenv${Color_Off} on ${BGreen}BASH${Color_Off}..."
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(jenv init -)"' >> ~/.bash_profile
else
    echo "Current Shell is neither Zsh nor Bash"
fi


# 3. Install Java JDK 8
echo -e "\n${BBlue}3.${Color_Off} ${BWhite}Install Java JDK 8 using Homebrew${Color_Off}"
echo -e "${BGreen}=>${Color_Off} ${BWhite}Installing${Color_Off} ${BGreen}Java JDK 8${Color_Off}..."
brew cask install adoptopenjdk/openjdk/adoptopenjdk8

# Adding the Java JDK 8 to jenv
echo -e "${BGreen}=>${Color_Off} ${BWhite}Adding${Color_Off} the ${BGreen}Java JDK 8${Color_Off} to ${BGreen}jenv${Color_Off}..."
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/

# Adding the Java JDK 12 to jenv
echo -e "${BGreen}=>${Color_Off} ${BWhite}Adding${Color_Off} the ${BGreen}Java JDK 12${Color_Off} (MacOS Mojave default) to ${BGreen}jenv${Color_Off}..."
jenv add /Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home

# 4. Check the Apple Developer Signing Certificate
echo -e "\n${BBlue}4.${Color_Off} ${BWhite}Check the Apple Developer Signing Certificate${Color_Off}"
echo -e "${BGreen}=>${Color_Off} ${BWhite}Checking${Color_Off} that you have a ${BGreen}Signing Certificate${Color_Off} on your computer"
security find-identity -v -p codesigning


# 5. Install Dexprotector Packages
echo -e "\n${BBlue}5.${Color_Off} ${BWhite}Install Dexprotector Packages${Color_Off}"
echo -e "${BGreen}=>${Color_Off} ${BWhite}Creating${Color_Off}, on a recursive manner, all the folders required to use ${BGreen}Dexprotector${Color_Off}..."
# Create on a recursive manner all the folders required to use Dexprotector.
mkdir -p ~/Development/HackingTools/Dexprotector

# Create the folder that is going to store the Dexprotector Packages
mkdir ~/Development/HackingTools/Dexprotector/DexproPackages
# Create the folder that is going to store the Dexprotector iOS Toolchain Tool
mkdir ~/Development/HackingTools/Dexprotector/iOS
# Create the folder that is going to store the Dexprotector Licence
mkdir ~/Development/HackingTools/Dexprotector/Licence


yesOrNo () {
    read -n 1 -p "=> " input
    if [ "$input" = "y" ]; then
            echo "es"
        elif [ "$input" = "n" ]; then
            echo -e "o\nMove the Dexprotector package zip file to the ${BWhite}\"~/Downloads\"${Color_Off} folder with the name ${BWhite}\"dexprotector.zip\"${Color_Off}
and try again.\n"
            echo -e "Is the Dexprotector package located in the ${BWhite}\"~/Downloads\"${Color_Off} folder with the name ${BWhite}\"dexprotector.zip\"${Color_Off}?"
            yesOrNo
        else
            echo -e "\nYou have entered an ${BRed}invalid${Color_Off} selection!
            Please try again!
            
            Press any key to continue..."
            read -n 1
            clear
            yesOrNo
        fi
}

echo -e "\nIs the ${BGreen}Dexprotector${Color_Off} package located in the ${BWhite}\"~/Downloads\"${Color_Off} folder with the name ${BWhite}\"dexprotector.zip\"${Color_Off}? [${BGreen}Y${Color_Off}][${BRed}n${Color_Off}]"
yesOrNo

# Store the package for future use to the relevant folder.
echo -e "${BGreen}=>${Color_Off} ${BWhite}Copying${Color_Off} the zip file to the ${BGreen}\"~/Development/HackingTools/Dexprotector/DexproPackages\"${Color_Off} folder..."
cp ~/Downloads/dexprotector.zip ~/Development/HackingTools/Dexprotector/DexproPackages
# Unzip the package to the relevant folder.
echo -e "${BGreen}=>${Color_Off} ${BWhite}Unzipping${Color_Off} the zip file to the ${BGreen}\"~/Development/HackingTools/Dexprotector/DexproPackages\"${Color_Off} folder..."
unzip ~/Downloads/dexprotector.zip -d ~/Development/HackingTools/Dexprotector/DexproPackages


echo -e "\nIs the ${BGreen}Dexprotector${Color_Off} package located in the ${BWhite}\"~/Downloads\"${Color_Off} folder with the name ${BWhite}\"ios-toolchain.zip\"${Color_Off}? [${BGreen}Y${Color_Off}][${BRed}n${Color_Off}]"
yesOrNo

# Store the Toolchain tool for future use
echo -e "${BGreen}=>${Color_Off}${Color_Off} ${BWhite}Copying${Color_Off} the zip file to the ${BGreen}\"~/Development/HackingTools/Dexprotector/iOS\"${Color_Off} folder..."
cp ~/Downloads/ios-toolchain-clang-7.zip ~/Development/HackingTools/Dexprotector/iOS/
# Unzip the toolchain
echo -e "${BGreen}=>${Color_Off} ${BWhite}Unzipping${Color_Off} the zip file to the ${BGreen}\"~/Development/HackingTools/Dexprotector/iOS\"${Color_Off} folder..."
unzip ~/Downloads/ios-toolchain-clang-7.zip -d ~/Development/HackingTools/Dexprotector/iOS/
# Copy it to the proper location within the Dexprotector folder as mentionned in the documentation
echo -e "${BGreen}=>${Color_Off} ${BWhite}Copying${Color_Off} the iOS Toolchain folder to the ${BGreen}\"dexprotector\"${Color_Off} folder..."
cp ~/Development/HackingTools/Dexprotector/iOS/ios-toolchain-clang-7 ~/Development/HackingTools/Dexprotector/DexproPackages/dexprotector/ios-toolchain/


# 6. Configure Java Environment
# Set up the Jdk 8 use locally
echo -e "\n${BBlue}6.${Color_Off} ${BWhite}Configure Java Environment${Color_Off} manually."
mvDexProDir="cd ~/Development/HackingTools/Dexprotector/DexproPackages/dexprotector/"
echo -e "\nMove to the dexprotector folder using the following command : \n=> 1. ${BWhite}cd ~/Development/HackingTools/Dexprotector/DexproPackages/dexprotector/${Color_Off}"
setUpLocalJenv="jenv local 1.8"
echo -e "Set up the Java JDK 8 to be used locally using the following command : \n=> 2. ${BWhite}jenv local 1.8${Color_Off}"

# Reload the shell to take the change into effect
reloadShell

# Put all the commands in the Clipboard on MacOS.
echo -e "Next steps : All the commands are in your Clipboard. Just hit ${BWhite}\"Cmd +v\"${Color_Off} in your terminal to launch it."
echo "$reloadShellCmd && $mvDexProDir && $setUpLocalJenv" | pbcopy
