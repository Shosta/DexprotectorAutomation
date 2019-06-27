---
title: Application Obfuscation on iOS
published: false
description: Obfuscate your iOS Application with Dexprotector
tags: Security, iOS
---

### Introduction

---

As explained on [Wikipedia](https://en.wikipedia.org/wiki/Obfuscation_(software))
> In software development, obfuscation is the deliberate act of creating source or machine code that is difficult for humans to understand.
> 
> Like obfuscation in natural language, it may use needlessly roundabout expressions to compose statements. Programmers may deliberately obfuscate code to conceal its purpose (security through obscurity) or its logic or implicit values embedded in it, primarily, in order to prevent tampering, deter reverse engineering, or even as a puzzle or recreational challenge for someone reading the source code. 
>
> This can be done manually or by using an automated tool, the latter being the preferred technique in industry.

----

### Advantages of obfuscation

There are several advantages of automated code obfuscation that have made it popular and widely useful across many platforms. 
On some platforms (such as Java, Android, and .NET) a decompiler can reverse-engineer source code from an executable or library. 

A main advantage of automated code obfuscation is that it helps protect the trade secrets (intellectual property) contained within software by making **reverse-engineering a program difficult and economically unfeasible**. 

Other advantages might include helping to **protect licensing mechanisms and unauthorized access**, and shrinking the size of the source code, and possibly shrinking the size of the executable.

Decompilation is sometimes called a man-at-the-end attack, based on the traditional cryptographic attack known as "man-in-the-middle".

> So Obfuscation makes you less prone to "**Licencing fraud**", "**Reverse-engineering**" and "**Intellectual property theft**" by making it economically unprofitable.


### Disadvantages of obfuscation

While obfuscation can make reading, writing, and reverse-engineering a program difficult and time-consuming, it will not necessarily make it impossible.

Some anti-virus software, such as AVG AntiVirus, will also alert their users when they land on a site with code that is manually obfuscated, as **one of the purposes of obfuscation can be to hide malicious code**.

However, some developers may employ code obfuscation for the purpose of reducing file size or increasing security. **The average user may not expect their antivirus software to provide alerts** about an otherwise harmless piece of code, especially from trusted corporations, so such a feature may actually deter users from using legitimate software.

> So it could be interesting to test your obfuscating software against the big names in antivirus.


### Obfuscating software

A variety of tools exist to perform or assist with code obfuscation. These include experimental research tools created by academics, hobbyist tools, commercial products written by professionals, and open-source software. 

One of the best in class commercial obfuscation product for Mobile Applications is [Dexprotector](https://dexprotector.com/).

## Install Dexprotector on MacOS (Mojave)

----

As we want to obfuscate our iOS application, we first have to install Dexprotector on a MacOS computer (as the obfuscation can only run on a MacOS computer as it is based on XCode to perform some actions).

## 1. Install Homebrew Package Manager

----

[Homebrew](https://brew.sh/) is the package manager that Apple is missing on MacOS.

Install [Homebrew](https://brew.sh/) on your MacOS if you didn't do it yet.

Homebrew installs the stuff you need that Apple didn’t.

To install Homebrew, just paste that in a macOS Terminal prompt.
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## 2. Install Jenv to handle multiple Java JDK

----

It is good to manage the Java Jdk you are going to use based on the location of your project.

[jEnv](http://www.jenv.be/) is perfect to efficiently and easily manage your Java environments.

### 2.1. Install Jenv using Homebrew

```bash
brew install jenv
```

### 2.2. Enable jenv on your Shell
As mentionned at the end of `jenv` installation on your terminal, you have to notify your shell where is `jenv` so that you can use it system-wide.

**Bash**
```bash
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(jenv init -)"' >> ~/.bash_profile
```
**Zsh**
```zsh
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc
```

### 2.3. Reload your shell environment

Bash
```bash
source ~/.bash_profile
```
Zsh
```zsh
source ~/.zshrc
```
Or just close and reopen your Terminal.

## 3. Install Java JDK 8

----

To use Dexprotector on MacOS, it is mandatory to use the Java JDK 8 because of a deprecated Java method that Dexprotector is using.

Indeed, on the latest MacOS (Mojave) Java is installed by default. The default Java JDK is JDK 12.

### 3.1 Install Java JDK 8 using Homebrew

Install the [Java JDK 8](https://github.com/AdoptOpenJDK/homebrew-openjdk) using Homebrew :
```bash
brew cask install adoptopenjdk/openjdk/adoptopenjdk8
```

The Java 8 Jdk should installed in the following location :
```bash
ls /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk
```

### 3.2 Register JDKs with jenv

We are going to make the Java JDK 8 and Java JDK 12 (MacOS default) available on `jenv`.
```bash
# Adding the Java JDK 8 to jenv
jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home/

# Adding the Java JDK 12 to jenv
jenv add /Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Home
```

Check that everything was correctly added to jenv:
```bash
jenv versions
```
You should see that the `openjdk64-1.8.0.212`and `oracle64-12.0.1` are added to jenv.

## 4. Apple Developer Console Configuration

----

In order to make Dexprotector running to obfuscate iOS applications, we have to get some information from the Apple Developer account that is publishing the application.

First, we have to get a "**Signing Certificate Name**"

### 4.1 Check the Installed Signing Certificate

The identity of the signing certificate can be **iOS Development** or **iOS Distribution**. For example, *iPhone Distribution: Licel Corporation (1NKDRJYKBE)*. 

If you have more than one signing certificate with the same name but different validity period, you can use its ID. The ID can be gotten via the following console command:

```
security find-identity -v -p codesigning

      1) 869B7011A78D50FFD7B9F9488A18BE8A5F1500A1 "iPhone Distribution: Licel Corporation (1NKDRJYKBE)"
```   
The value of 869B7011A78D50FFD7B9F9488A18BE8A5F1500A1 is the certificate ID.

### 4.2 How to get a valid signing certificate? 

Go to "[Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list)" on your Apple Developer account.

Click on the "+" icon to create a new certificate.
![](https://thepracticaldev.s3.amazonaws.com/i/xl593gr6f377rywtw9yt.jpg)


Choose "iOS App Development" as you want to obfuscate an iOS application.

Click on the "Continue" button.
![](https://thepracticaldev.s3.amazonaws.com/i/vv1mq91nez0ue5q2t208.jpg)

Follow these steps to create a certificate signing request.

1. Launch Keychain Access located in /Applications/Utilities.

1. Choose Keychain Access > Certificate Assistant > Request a Certificate from a Certificate Authority.

1. In the Certificate Assistant dialog, enter an email address in the User Email Address field.

1. In the Common Name field, enter a name for the key (for example, Gita Kumar Dev Key).

1. Leave the CA Email Address field empty.

1. Choose “Saved to disk”, and click Continue.
![](https://thepracticaldev.s3.amazonaws.com/i/rpnl439sf15iectip7af.png)

Upload the Certificate Signing Request you just created and then click "Continue".
Then you can download you Certificate and add it to your Keychain just double clicking on it.
![](https://thepracticaldev.s3.amazonaws.com/i/ivo4ty5g1ztmywnj5jjf.jpg)

Check that everything is properly configured :
```
security find-identity -v -p codesigning
```
You should see you new signing identity properly installed and available on your Mac.

## 5. Install and Configure Dexprotector on iOS

----

### 5.1 Retrieve Dexprotector Packages

I assume that you receive the Dexprotector package from the editor.

If you don't have a licence for dexprotector and just want to try it to see if it is working, you can request a free trial licence [here](https://dexprotector.com/trial-request).

So now that you have a valid licence, let's install our Dexprotector environment for iOS.

### 5.2 Install the Packages

I usually gather all the Hacking tools I need in a single folder.

Let's create all the required folders to use Dexprotector.
```bash
# Create on a recursive manner all the folders required to use Dexprotector.
mkdir -p ~/Development/HackingTools/Dexprotector

# Create the folder that is going to store the Dexprotector Packages
mkdir ~/Development/HackingTools/Dexprotector/DexproPackages
# Create the folder that is going to store the Dexprotector iOS Toolchain Tool
mkdir ~/Development/HackingTools/Dexprotector/iOS
# Create the folder that is going to store the Dexprotector Licence
mkdir ~/Development/HackingTools/Dexprotector/Licence
```

All the tools (Dexprotector Package and Toolchain tool) are stored in the "`Downloads`" folder as we downloaded them from the Internet.
```bash
# Store the package for future use to the relevant folder.
cp ~/Downloads/dexprotector.zip ~/Development/HackingTools/Dexprotector/DexproPackages

# Unzip the package to the relevant folder.
unzip ~/Downloads/dexprotector.zip -d ~/Development/HackingTools/Dexprotector/DexproPackages
```

```bash 
# Store the Toolchain tool for future use
cp ~/Downloads/ios-toolchain-clang-7.zip ~/Development/HackingTools/Dexprotector/iOS/

# Unzip the toolchain
unzip ~/Downloads/ios-toolchain-clang-7.zip -d ~/Development/HackingTools/Dexprotector/iOS/

# Copy it to the proper location within the Dexprotector folder as mentionned in the documentation
cp ~/Development/HackingTools/Dexprotector/iOS/ios-toolchain-clang-7 ~/Development/HackingTools/Dexprotector/DexproPackages/dexprotector/ios-toolchain/
```

You should then have a folder tree that looks like that : 
![](https://thepracticaldev.s3.amazonaws.com/i/8op8szf59kt87v2w3nhi.jpg)

### 5.3 Configure Java Environment

As I said earlier, the Dexprotector is only working on the Java JDK8, due to a deprecated method.
Jenv was configure in step 3.2.

As described in the [jenv documentation](http://www.jenv.be/), you can set up which JDK to use globally, locally or based on the shell. 

So, we are going to set up the use of the Jdk 8 locally, within the dexprotector folder.
```bash
# Move to the proper directory
cd ~/Development/HackingTools/Dexprotector/DexproPackages/dexprotector/

# Set up the Jdk 8 use locally
jenv local 1.8

# Reload the shell to take the change into effect
# Bash
source ~/.bash_profile
# Zsh
source ~/.zshrc

# Check that everything works
# You should see a "star" in front of the 1.8
jenv versions
```

### 5.4 Check that Dexprotector is working

Just check that your licence is correct
```bash 
java -jar dexprotector.jar -info
```

### 6. Script to Automate It

----

To Automate all of this, I created a script that you can use to do all of that at once.

#### Available on Github:

Fork this repository, clone it on your computer and use to configureDexproEnv.sh script.

```bash
cd /path/to/configureDexproEnv.sh
chmod +x configureDexproEnv.sh
./configureDexproEnv.sh
```

Here is the result of the Script execution :
![](https://thepracticaldev.s3.amazonaws.com/i/2torcs5qjdfrkfr7in2r.jpg)