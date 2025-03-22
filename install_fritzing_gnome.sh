#!/bin/bash

# Pfadeingabe in einer Schleife, bis eine gültige AppImage-Datei angegeben wird
while true; do
    read -p "Bitte gib den vollständigen Pfad zur Fritzing .AppImage-Datei ein: " APPIMAGE_PATH
    if [ -f "$APPIMAGE_PATH" ]; then
        echo "Die Datei wurde gefunden: $APPIMAGE_PATH"
        break
    else
        echo "Die Datei wurde nicht gefunden. Bitte versuche es erneut oder STRG+C."
    fi
done

# Pfadeingabe in einer Schleife, bis eine gültige ICON-Datei angegeben wird
while true; do
    read -p "Bitte gib den vollständigen Pfad zum Fritzing-Icon eingeben: " ICON_PATH
    if [ -f "$ICON_PATH" ]; then
        echo "Die Datei wurde gefunden: $ICON_PATH"
        break
    else
        echo "Die Datei wurde nicht gefunden. Bitte versuche es erneut oder STRG+C."
    fi
done

# Verzeichnisse anlegen


# Ensure the necessary directories exist
mkdir -p ~/.local/share/mime/packages
mkdir -p ~/.local/share/icons/hicolor/64x64/mimetypes
mkdir -p ~/.local/share/icons/hicolor/128x128/mimetypes
mkdir -p ~/.local/share/icons/hicolor/256x256/mimetypes
mkdir -p ~/.local/share/applications

echo "🔹 Step 1: Creating MIME type definition file..."
cat <<EOF > ~/.local/share/mime/packages/x-fritzing.xml
<?xml version="1.0"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
    <mime-type type="application/x-fritzing">
        <comment>Fritzing project file</comment>
        <glob pattern="*.fz"/>
        <glob pattern="*.fzz"/>
        <glob pattern="*.fzpz"/>
        <glob pattern="*.fzb"/>
        <glob pattern="*.fzbz"/>
        <icon name="application-x-fritzing"/>
    </mime-type>
</mime-info>
EOF

echo "MIME type file created!"

echo "Step 2: Installing the new MIME type..."
xdg-mime install ~/.local/share/mime/packages/x-fritzing.xml
update-mime-database ~/.local/share/mime
echo "MIME type installed!"

echo "Step 3: Installing icons..."
xdg-icon-resource install --context mimetypes --size 64 fritzing_64.png application-x-fritzing
xdg-icon-resource install --context mimetypes --size 128 fritzing_128.png application-x-fritzing
xdg-icon-resource install --context mimetypes --size 256 fritzing_256.png application-x-fritzing
echo "Icons installed!"

echo "Step 4: Creating desktop entry..."
cat <<EOF > ~/.local/share/applications/fritzing.desktop
[Desktop Entry]
Version=1.1
Type=Application
Name=Fritzing
Comment=Fritzing Circuit Designer
Icon=$ICON_PATH
Exec=$APPIMAGE_PATH
Actions=
MimeType=application/x-fritzing;
Categories=Development;
StartupNotify=true
EOF

xdg-mime default fritzing.desktop application/x-fritzing
echo "Desktop entry created and set as default!"

echo "Step 5: Linking icons to Adwaita theme..."
sudo ln -sf ~/.local/share/icons/hicolor/64x64/mimetypes/application-x-fritzing.png /usr/share/icons/Adwaita/64x64/mimetypes/application-x-fritzing.png
sudo ln -sf ~/.local/share/icons/hicolor/256x256/mimetypes/application-x-fritzing.png /usr/share/icons/Adwaita/256x256/mimetypes/application-x-fritzing.png
sudo gtk-update-icon-cache /usr/share/icons/Adwaita
echo "Icons linked and cache updated!"

echo "Step 6: Restarting file manager..."
killall nautilus && nautilus &
echo "Installation complete! Try opening a .fz or .fzz file to check if Fritzing opens correctly."

exit 0
