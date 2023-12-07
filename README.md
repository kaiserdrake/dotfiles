# dotfiles

## How to install

Install via snippet:
```
curl -lKs https://gist.githubusercontent.com/kaiserdrake/0406658292f73208435845bb4d6622d5/raw/84c753abdde630b8f1fc18aa8c67eb5e1ad03c22/fetch-dotfiles.sh | /bin/bash
```

Manual installation procedure:
```
git clone https://github.com/kaiserdrake/dotfiles.git .dotfiles
sh .dotfiles/metascripts/bootstrap.sh
sh .dotfiles/metascripts/bootstrap.sh nvim
```

## How to uninstall
```
sh .dotfiles/metascripts/bootstrap.sh uninstall
```
