#!/bin/bash

set -e
echo "Login screen setup script ver 0.1 by Novyz"
echo "[1/6] Installing greetd and tuigreet..."
sudo pacman -S --noconfirm greetd
yay -S --noconfirm greetd-tuigreet-git || true # Skip if already installed

echo "[2/6] Installing console font package..."
sudo pacman -S --noconfirm terminus-font

echo "[3/6] Creating tuigreet wrapper script..."
sudo tee /etc/greetd/tuigreet-wrapper.sh >/dev/null <<'EOF'
#!/bin/bash

# Set console font (requires root)
setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psf.gz

# Launch tuigreet as configured user (greeter)
exec /usr/bin/tuigreet --user-menu --remember --remember-user-session --time \
  --cmd /etc/greetd/launch-session.sh \
  --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red
EOF

echo "[4/6] Setting permissions for wrapper..."
sudo chown root:greeter /etc/greetd/tuigreet-wrapper.sh
sudo chmod 750 /etc/greetd/tuigreet-wrapper.sh

echo "[5/6] Writing greetd config.toml..."
sudo tee /etc/greetd/config.toml >/dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "/etc/greetd/tuigreet-wrapper.sh"
user = "greeter"
EOF

echo "[6/6] Enabling greetd service..."
sudo systemctl enable greetd.service
echo "Done! Reboot to test the login screen with the new font and theme."
