# test

![Stars](https://img.shields.io/github/stars/ximimoments/katifetch?style=for-the-badge)
![License](https://img.shields.io/github/license/ximimoments/katifetch?style=for-the-badge)
![Repo size](https://img.shields.io/github/repo-size/ximimoments/katifetch?style=for-the-badge)
![Last commit](https://img.shields.io/github/last-commit/ximimoments/katifetch?style=for-the-badge)

ubuntu 23.10.1:

```bash
deb http://old-releases.ubuntu.com/ubuntu/ mantic main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ mantic-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ mantic-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ mantic-backports main restricted universe multiverse
```
ubuntu 23.04
```bash
deb http://old-releases.ubuntu.com/ubuntu/ lunar main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ lunar-updates main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ lunar-security main restricted universe multiverse
deb http://old-releases.ubuntu.com/ubuntu/ lunar-backports main restricted universe multiverse
```

sudo nano /etc/apt/sources.list



https://github.com/user-attachments/assets/c2ce2774-3f2e-42c7-8d7b-1321ef8600e6

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=ximimoments/katifetch&type=Date)](https://star-history.com/#ximimoments/katifetch&Date)

## 📈 GitHub Stats

| Stars Over Time |
|-----------------|
| [![Star History](https://api.star-history.com/svg?repos=ximimoments/katifetch&type=Date)](https://star-history.com/#ximimoments/katifetch&Date) |

[![Star History Chart](https://api.star-history.com/svg?repos=ximimoments/katifetch,octocat/hello-world&type=Date)](https://star-history.com/#ximimoments/katifetch&Date)

<blockquote class="reddit-embed-bq" style="height:500px" data-embed-height="546"><a href="https://www.reddit.com/r/unixporn/comments/1lu9m0z/gnome_simple_but_i_like_it/">[GNOME] Simple, but I like it</a><br> by<a href="https://www.reddit.com/user/sunref_/">u/sunref_</a> in<a href="https://www.reddit.com/r/unixporn/">unixporn</a></blockquote><script async="" src="https://embed.reddit.com/widgets.js" charset="UTF-8"></script>

https://www.reddit.com/r/unixporn/comments/1lu9m0z/gnome_simple_but_i_like_it/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button





https://www.reddit.com/r/mascotas/comments/1lr6yu3/cuál_es_el_mensaje/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button




https://www.reddit.com/r/mascotas/comments/1ltjfz9/me_ayudas_a_buscar_nombre_para_mí_adoptado/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

gdonavm

https://drive.google.com/file/d/1SXQUmlo504LQ4tDJFFzcaqWTxP-fKF6J/view?usp=sharing

https://drive.google.com/file/d/1rluWVwRUuCp83tJCcTGPLgCt9pPUUHMo/view?usp=sharing

sudo apt install flatpak

sudo apt install gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo


```bash
# 1. Crear nueva tabla GPT
sudo parted /dev/sda mklabel gpt yes

# 2. Crear partición EFI (512 MB)
sudo parted -a optimal /dev/sda mkpart ESP fat32 1MiB 513MiB
sudo parted /dev/sda set 1 boot on

# 3. Crear partición /boot (1 GB)
sudo parted -a optimal /dev/sda mkpart primary ext4 513MiB 1537MiB

# 4. Crear partición swap (4 GB)
sudo parted -a optimal /dev/sda mkpart primary linux-swap 1537MiB 5633MiB

# 5. Crear partición raíz / (resto del disco)
sudo parted -a optimal /dev/sda mkpart primary ext4 5633MiB 100%

# 6. Formatear cada partición
sudo mkfs.fat -F32 /dev/sda1      # EFI
sudo mkfs.ext4 /dev/sda2          # /boot
sudo mkswap /dev/sda3             # swap
sudo mkfs.ext4 /dev/sda4          # /

# 7. Activar swap
sudo swapon /dev/sda3

```
❯ sudo parted /dev/sda            
GNU Parted 3.6
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mklabel yes
parted: invalid token: yes
New disk label type? gpt
Warning: The existing disk label on /dev/sda will be destroyed and all data on
this disk will be lost. Do you want to continue?
Yes/No? tes                                                               
parted: invalid token: tes
Yes/No? yes                                                               
(parted)      


(parted) mkpart ESP fat32 1MiB 513MiB

(parted) set 1 boot on

(parted) mkpart primary ext4 513MiB 1537MiB

(parted) mkpart primary linux-swap 1537MiB 5633MiB

(parted) mkpart primary ext4 5633MiB 100%

(parted) print        # para verificar cómo quedaron

(parted) quit

sudo mkfs.fat -F32 /dev/sda1

sudo mkfs.ext4 /dev/sda2

sudo mkswap /dev/sda3

sudo mkfs.ext4 /dev/sda4

sudo swapon /dev/sda3








liveuser on localhost-live ~ 
❯ sudo parted /dev/sda 
GNU Parted 3.6
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) print
Model: ATA Hitachi HTS54755 (scsi)
Disk /dev/sda: 500GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system     Name     Flags
 1      1049kB  538MB   537MB   fat32           ESP      boot, esp
 2      538MB   1612MB  1074MB  ext4            primary
 3      1612MB  5907MB  4295MB  linux-swap(v1)  primary  swap
 4      5907MB  500GB   494GB   ext4            primary

(parted)      

```bash
sudo parted /dev/sda --script mklabel gpt \
  mkpart ESP fat32 1MiB 513MiB \
  set 1 boot on \
  mkpart primary ext4 513MiB 1537MiB \
  mkpart primary linux-swap 1537MiB 5633MiB \
  mkpart primary ext4 5633MiB 46.6GiB \
  mkpart primary ext4 46.6GiB 100%
```


```bash
sudo mkfs.fat -F32 /dev/sda1
sudo mkfs.ext4 /dev/sda2
sudo mkswap /dev/sda3
sudo mkfs.ext4 /dev/sda4
sudo mkfs.ext4 /dev/sda5
sudo swapon /dev/sda3
```

  GNU nano 6.2                                                                                               /etc/apt/sources.list                                                                                                         
#deb cdrom:[Ubuntu 22.04.5 LTS _Jammy Jellyfish_ - Release amd64 (20240911)]/ jammy main restricted

# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb http://uy.archive.ubuntu.com/ubuntu/ jammy main restricted
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://uy.archive.ubuntu.com/ubuntu/ jammy-updates main restricted
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://uy.archive.ubuntu.com/ubuntu/ jammy universe
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy universe
deb http://uy.archive.ubuntu.com/ubuntu/ jammy-updates universe
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu 
## team, and may not be under a free licence. Please satisfy yourself as to 
## your rights to use the software. Also, please note that software in 
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://uy.archive.ubuntu.com/ubuntu/ jammy multiverse
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy multiverse
deb http://uy.archive.ubuntu.com/ubuntu/ jammy-updates multiverse
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://uy.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse
# deb-src http://uy.archive.ubuntu.com/ubuntu/ jammy-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu jammy-security main restricted
# deb-src http://security.ubuntu.com/ubuntu jammy-security main restricted
deb http://security.ubuntu.com/ubuntu jammy-security universe
# deb-src http://security.ubuntu.com/ubuntu jammy-security universe
deb http://security.ubuntu.com/ubuntu jammy-security multiverse
# deb-src http://security.ubuntu.com/ubuntu jammy-security multiverse

# This system was installed using small removable media
# (e.g. netinst, live or single CD). The matching "deb cdrom"
# entries were disabled at the end of the installation process.
# For information about how to configure apt package sources,
# see the sources.list(5) manual.

