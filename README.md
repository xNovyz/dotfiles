# xNovyz's Dotfiles

This is my personal collection of dotfiles, managed with [chezmoi](https://www.chezmoi.io/).


![preview](https://github.com/user-attachments/assets/00cf33b7-f28c-4389-8d77-e04acd5222cf)

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

⚠️ Heads up! Chezmoi will overwrite your current configurations. I highly recommend making backups before proceeding.

  To preview the changes chezmoi will make without applying them, run:
  ```bash
  chezmoi diff
  ```
  Ok, now that you've made the backups and seen what will be changed, you can apply everything by running:
  ```bash
  chezmoi apply
  ```
