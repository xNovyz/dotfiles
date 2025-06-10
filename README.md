# xNovyz's Dotfiles

This is my personal collection of dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## ⚡ Quick Setup

To install these dotfiles on a new machine:

First install chezmoi:

```bash
sudo pacman -S chezmoi
```

Then initialize chezmoi with my dots:

```bash
chezmoi init xNovyz
```

Now you are ready to apply the dots:

⚠️ Carefull! chezmoi will overwrite all your current cofigs so make backup before you apply

  if you want to the changes before applying use this command:
  ```bash
  chezmoi diff
  ```
  Ok, now that you have made the backups and saw what would be changed apply everything with:

  ```bash
  chezmoi apply
  ```
