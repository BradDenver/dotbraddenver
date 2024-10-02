```
git clone https://github.com/BradDenver/dotbraddenver.git

# which shell
echo $0

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/braddenver/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

cd dotbraddenver
make brew

https://github.com/nvm-sh/nvm
eg `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash`

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

$(brew --prefix)/opt/fzf/install
