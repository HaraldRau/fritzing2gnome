# fritzing2gnome
Fritzing AppImage in GNOME installieren
---

# **How to Integrate Fritzing AppImage into GNOME on Ubuntu/Debian**
<img src="fritzing.svg" alt="Fritzing">

Hi everyone,  

I always had issues properly integrating the **Fritzing AppImage** into my desktop environment on **Ubuntu and Debian**.

This guide may differ for other desktop environments like Linux Mint or KDE.  

Here is the **step-by-step method** that finally worked for me:
## **1️⃣ Create the MIME Type File (`x-fritzing.xml`)**  
This file defines a new MIME type for Fritzing-related file formats:  
```xml
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
```
This configuration ensures that **`.fz`, `.fzz`, `.fzpz`, `.fzb`, and `.fzbz`** files are recognized as Fritzing project files.  
## **2️⃣ Install the New MIME Type**  
Run the following command to install the MIME type:  
```bash
xdg-mime install x-fritzing.xml
```
## **3️⃣ Install the Icon**  
I extracted the icon from the **Fritzing AppImage** and installed it with:  
```bash
xdg-icon-resource install --context mimetypes --size 64 fritzing_64.png application-x-fritzing
xdg-icon-resource install --context mimetypes --size 128 fritzing_128.png application-x-fritzing
xdg-icon-resource install --context mimetypes --size 256 fritzing_256.png application-x-fritzing
```
This registers the icon in different sizes for better appearance across the system.  
## **4️⃣ Create the `fritzing.desktop` Launcher**  
mime default fritzing.desktop application/x-fritzing
```
First, create the file **`~/.local/share/applications/fritzing.desktop`** with the following content:  
```ini
[Desktop Entry]
Version=1.1
Type=Application
Name=Fritzing
Comment=Fritzing
Icon=/home/user/Software/AppImage/fritzing/fritzing.svg
Exec=/home/user/Software/AppImage/fritzing/fritzing.AppImage
Actions=
MimeType=application/x-fritzing;
Categories=Development;
StartupNotify=true
```
📌 **Replace `/home/user/Software/AppImage/fritzing/`** with the actual path to your **Fritzing AppImage** and **icon file**.  
Then, associate Fritzing as the default application for its file type:  
```bash
xdg-

## **5️⃣ Link Icons to Adwaita (Critical Step!)**  
GNOME might not display the correct icons unless they are linked to the **Adwaita** icon theme:  
```bash
sudo ln -s ~/.local/share/icons/hicolor/64x64/mimetypes/application-x-fritzing.png /usr/share/icons/Adwaita/64x64/mimetypes/application-x-fritzing.png

sudo ln -s ~/.local/share/icons/hicolor/256x256/mimetypes/application-x-fritzing.png /usr/share/icons/Adwaita/256x256/mimetypes/application-x-fritzing.png

sudo gtk-update-icon-cache /usr/share/icons/Adwaita
```  

---
