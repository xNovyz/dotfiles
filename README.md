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

### Now you are ready to apply the dots:

⚠️ Heads up! Chezmoi will overwrite your current configurations. We highly recommend making backups before proceeding.

  To preview the changes chezmoi will make without applying them, run:
  ```bash
  chezmoi diff
  ```
  Ok, now that you've made the backups and seen what will be changed, you can apply everything by running:
  ```bash
  chezmoi apply
  ```
