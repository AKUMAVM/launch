<!-- markdownlint-disable MD028 MD033 MD045 -->

[![Github Sponsors](https://img.shields.io/badge/sponsor-30363D?style=flat-square&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/bin456789)

![Sponsors](https://raw.githubusercontent.com/bin456789/sponsors/refs/heads/master/sponsors.svg)

## Highlights

- Supports one-click installation of Linux: allows install 17 common distributions.
- Supports one-click Windows installation: Uses the official ISO for installation instead of custom images. The script automatically retrieves the ISO link and installs `Virtio` and other drivers.
- Supports installation in any direction, i.e., `Linux to Linux`, `Linux to Windows`, `Windows to Windows`, `Windows to Linux`
- No need to input IP parameters; automatically recognizes dynamic and static IPs, supports `/32`, `/128`, `gateway outside subnet`, `IPv6 only`, `dual NIC` and other special network configurations
- Specially optimized for low-spec servers, requires less memory than the official netboot
- Uses partition table ID to identify hard drives throughout the process, ensuring no wrong disk is written
- Supports BIOS and EFI boot, and ARM architecture
- No homemades image included, all resources are obtained in real-time from source sites
- Includes many comments.

## System Requirements

The original system can be any system listed in the table.

The system requirements for the target system are as follows:

| Target System                                                                                                                                                                                                                                              | Version                               | Memory    | Disk                   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------- | --------- | ---------------------- |
| <img width="16" height="16" src="https://www.alpinelinux.org/alpine-logo.ico" /> Alpine                                                                                                                                                                    | 3.17, 3.18, 3.19, 3.20                | 256 MB    | 1 GB                   |
| <img width="16" height="16" src="https://www.debian.org/favicon.ico" /> Debian                                                                                                                                                                             | 9, 10, 11, 12                         | 256 MB    | 1 ~ 1.5 GB ^           |
| <img width="16" height="16" src="https://github.com/bin456789/reinstall/assets/7548515/f74b3d5b-085f-4df3-bcc9-8a9bd80bb16d" /> Kali                                                                                                                       | Rolling                               | 256 MB    | 1 ~ 1.5 GB ^           |
| <img width="16" height="16" src="https://netplan.readthedocs.io/en/latest/_static/favicon.png" /> Ubuntu                                                                                                                                                   | 16.04, 18.04, 20.04, 22.04, 24.04     | 512 MB \* | 2 GB                   |
| <img width="16" height="16" src="https://www.centos.org/assets/img/favicon.png" /> CentOS                                                                                                                                                                  | 9                                     | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://img.alicdn.com/imgextra/i1/O1CN01oJnJZg1yK4RzI4Rx2_!!6000000006559-2-tps-118-118.png" /> Anolis                                                                                                                   | 7, 8                                  | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://www.redhat.com/favicon.ico" /> RedHat &nbsp; <img width="16" height="16" src="https://almalinux.org/fav/favicon.ico" /> Alma &nbsp; <img width="16" height="16" src="https://rockylinux.org/favicon.png" /> Rocky | 8, 9                                  | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://opencloudos.org/qq.ico" /> OpenCloudOS                                                                                                                                                                            | 8, 9                                  | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://www.oracle.com/asset/web/favicons/favicon-32.png" /> Oracle                                                                                                                                                       | 7, 8, 9                               | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://fedoraproject.org/favicon.ico" /> Fedora                                                                                                                                                                          | 40, 41                                | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://www.openeuler.org/favicon.ico" /> openEuler                                                                                                                                                                       | 20.03, 22.03, 24.03                   | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://static.opensuse.org/favicon.ico" /> openSUSE                                                                                                                                                                      | 15.5, 15.6, Tumbleweed (Rolling)      | 512 MB \* | 5 GB                   |
| <img width="16" height="16" src="https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg" /> NixOS                                                                                                                                                        | 24.05                                 | 512 MB    | 5 GB                   |
| <img width="16" height="16" src="https://archlinux.org/static/favicon.png" /> Arch                                                                                                                                                                         | Rolling                               | 512 MB    | 5 GB                   |
| <img width="16" height="16" src="https://www.gentoo.org/assets/img/logo/gentoo-g.png" /> Gentoo                                                                                                                                                            | Rolling                               | 512 MB    | 5 GB                   |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (DD)                                                                                                  | Any                                   | 512 MB    | Depending on the image |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (ISO)                                                                                                 | Vista, 7, 8.x (Server 2008 ~ 2012 R2) | 512 MB    | 25 GB                  |
| <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows (ISO)                                                                                                 | 10, 11 (Server 2016 ~ 2025)           | 1 GB      | 25 GB                  |

\* Indicates installation using cloud images, not traditional network installation.

^ Indicates requiring either 256 MB memory + 1.5 GB disk, or 512 MB memory + 1 GB disk

> [!WARNING]
> ❌ This script does not support OpenVZ or LXC virtual machines.
>
> Please use <https://github.com/LloydAsp/OsMutation> instead.

## Usages (Current system is <img width="20" height="20" src="https://www.kernel.org/theme/images/logos/favicon.png" /> Linux)

```bash
curl -O https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.sh || wget -O mark.sh $_
```

## Usages (Current system is <img width="20" height="20" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows)

> [!IMPORTANT]
> Before proceeding, please disable the 'Real-time protection' feature in `Windows Defender`. This feature may prevent `certutil` from downloading any files.

<details>

<summary>😢Still unable to download?</summary>

### Try the following methods

1. For Windows 7, install this patch to enable TLS 1.2.

   <https://aka.ms/easyfix51044>

2. Update SSL root certificates.

   ```batch
   certutil -generateSSTFromWU root.sst
   certutil -addstore Root root.sst
   ```

3. Download manually by copying these two files through `Remote Desktop Connection`.

   <[(https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.bat)](https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.bat)>

   <[(https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.sh)](https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.sh)>

</details>

```batch
certutil -urlcache -f -split https://raw.githubusercontent.com/AKUMAVM/launch/main/mark.bat
```

## Usage

**All features** can be used on both Linux and Windows.

- on Linux, execute `bash mark.sh`
- on Windows, execute `.\mark.bat`

### Feature 1: Install <img width="16" height="16" src="https://www.kernel.org/theme/images/logos/favicon.png" /> Linux

- The username is `root` with a default password of `123@@@`. It may take a few minutes after the first boot to successfully log in.
- When installing the latest version, the version number does not need to be specified.
- Maximizes disk space usage: no boot partition (except for Fedora) and no swap partition.
- Automatically selects different optimized kernels based on machine type, such as `Cloud` or `HWE` kernels.
- When installing Red Hat, you must provide the `qcow2` image link obtained from <https://access.redhat.com/downloads/content/rhel>.
- After reinstallation, if you need to change the SSH port or switch to key-based login, make sure to also modify the files inside `/etc/ssh/sshd_config.d/`.

```bash
bash mark.sh centos      9
                  anolis      7|8
                  alma        8|9
                  rocky       8|9
                  redhat      8|9   --img='http://xxx.com/xxx.qcow2'
                  opencloudos 8|9
                  oracle      7|8|9
                  fedora      40|41
                  nixos       24.05
                  debian      9|10|11|12
                  openeuler   20.03|22.03|24.03
                  alpine      3.17|3.18|3.19|3.20
                  opensuse    15.5|15.6|tumbleweed
                  ubuntu      16.04|18.04|20.04|22.04|24.04 [--minimal]
                  kali
                  arch
                  gentoo
```

#### Optional Parameters

- `--password PASSWORD` Set the password
- `--ssh-port PORT` Change the SSH port (for log observation during installation and for the new system)
- `--web-port PORT` Change the Web port (for log observation during installation)
- `--hold 2` Prevent reboot after installation completes, allowing SSH login to modify system content; the system is mounted at `/os` (this feature is not supported on Debian/Kali).

> [!TIP]
> When installing Debian/Kali, x86 architectures can monitor the installation progress through VNC in the background, while ARM architectures can use the serial console.
>
> When installing other systems, can monitor the progress through various methods (SSH, HTTP 80 port, VNC in the background, serial console).
> <br />Even if errors occur during the installation process, you can still install to Alpine via SSH by running `/trans.sh alpine`

<details>

<summary>Experimental Features</summary>

Install Debian using a cloud image

- Suitable for machines with slower CPUs

```bash
bash mark.sh debian --ci
```

Install CentOS, Alma, Rocky, Fedora using ISO

- Only supports machines with more than 2G of memory and dynamic IP.
- Password is `123@@@`, and the SSH port is `22`; modifying them using parameters is not supported.

```bash
bash mark.sh centos --installer
```

Install Ubuntu using ISO

- Only supports machines with more than 1G of memory and dynamic IP.
- Password is `123@@@`, and the SSH port is `22`; modifying them using parameters is not supported.

```bash
bash mark.sh ubuntu --installer
```

</details>

### Feature 2: DD

- Supports `raw` and `vhd` image formats (either uncompressed or compressed as `.gz`, `.xz`, `.zst`, `.tar`, `.tar.gz`, `.tar.xz`, `.tar.zst`).
- When deploy a Windows image, the system disk will be automatically expanded, and machines with a static IP will have their IP configured, and may take a few minutes after the first boot for the configuration to take effect.
- When deploy a Linux image, will **NOT** modify any contents of the image.

```bash
bash mark.sh dd --img https://example.com/xxx.xz
```

#### Optional parameters

- `--allow-ping` Allow ping responses (DD Windows only)
- `--rdp-port PORT` Change RDP port (DD Windows only)
- `--ssh-port PORT` Change SSH port (for log observation during installation)
- `--web-port PORT` Change Web port (for log observation during installation)
- `--hold 2` Prevent reboot after the DD process finishes, allowing SSH login to modify system content. The Windows system will be mounted at `/os`, but Linux systems will **NOT** be automatically mounted.

> [!TIP]
> Can monitor the progress through various methods (SSH, HTTP 80 port, VNC in the background, serial console).
> <br />Even if errors occur during the installation process, you can still install to Alpine via SSH by running `/trans.sh alpine`

### Feature 3: Reboot to <img width="16" height="16" src="https://www.alpinelinux.org/alpine-logo.ico" /> Alpine Rescue System (Live OS)

- You can use SSH to backup/restore disk, manually perform DD operations, modify partitions, and manually install Alpine, Arch, Gentoo, and other systems.
- Username `root`, Default password `123@@@`
- If manual operations do not damage the original system, rebooting will return to the original system.

```bash
bash mark.sh alpine --hold=1
```

#### Optional parameters

- `--password PASSWORD` Set password
- `--ssh-port PORT` Change SSH port

### Feature 4: Reboot to <img width="16" height="16" src="https://netboot.xyz/img/favicon.ico" /> netboot.xyz

- Can manually install [more systems](https://github.com/netbootxyz/netboot.xyz?tab=readme-ov-file#what-operating-systems-are-currently-available-on-netbootxyz) using vendor backend VNC.
- If manual operations do not damage the original system, rebooting will return to the original system.

```bash
bash mark.sh netboot.xyz
```

![netboot.xyz](https://netboot.xyz/images/netboot.xyz.gif)

### Feature 5: Install <img width="16" height="16" src="https://blogs.windows.com/wp-content/uploads/prod/2022/09/cropped-Windows11IconTransparent512-32x32.png" /> Windows ISO

![Windows Installation](https://github.com/bin456789/reinstall/assets/7548515/07c1aea2-1ce3-4967-904f-aaf9d6eec3f7)

- Username `administrator`, Default password `123@@@`
- If remote login fails, try using the username `.\administrator`.
- The machine with a static IP will automatically configure the IP. It may take a few minutes to take effect on the first boot.
- Supports all languages.

#### 支持的系统

- Windows (Vista ~ 11)
- Windows Server (2008 ~ 2025)
  - Windows Server Essentials \*
  - Windows Server (Semi) Annual Channel \*
  - Hyper-V Server \*
  - Azure Stack HCI \*

#### Method 1: Let the Script Automatically Search for ISO (Recommended)

- Typically, Windows releases new official ISOs every month, which integrate the latest system patches, avoiding the need to download a bunch of updates right after installation.
- The script will search for ISOs from <https://massgrave.dev/genuine-installation-media>, a site that collects monthly released ISOs, ensuring that the ISOs found by the script are the official latest versions.
- Systems marked with \* do not support automatic ISO searching.

```bash
bash mark.sh windows \
     --image-name 'Windows 11 Enterprise LTSC 2024' \
     --lang zh-cn
```

<details>
<summary>Supported languages</summary>

```text
ar-sa
bg-bg
cs-cz
da-dk
de-de
el-gr
en-gb
en-us
es-es
es-mx
et-ee
fi-fi
fr-ca
fr-fr
he-il
hr-hr
hu-hu
it-it
ja-jp
ko-kr
lt-lt
lv-lv
nb-no
nl-nl
pl-pl
pt-pt
pt-br
ro-ro
ru-ru
sk-sk
sl-si
sr-latn-rs
sv-se
th-th
tr-tr
uk-ua
zh-cn
zh-hk
zh-tw
```

</details>

#### Method 2: Specify the ISO link manually

- If you don't know the `--image-name`, you can enter any value. After rebooting, connect via SSH and re-enter the correct value based on the error messages.

```bash
bash mark.sh windows \
     --image-name 'Windows 11 Enterprise LTSC 2024' \
     --iso 'https://drive.massgrave.dev/zh-cn_windows_11_enterprise_ltsc_2024_x64_dvd_cff9cd2d.iso'
```

<details>

<summary>The following website provides ISO links.</summary>

- <https://massgrave.dev/genuine-installation-media> (Recommended, iso sourced from official channels, updated monthly, includes the latest patches)
- <https://www.microsoft.com/software-download/windows10> (Need to open it with a non-Windows User-Agent)
- <https://www.microsoft.com/software-download/windows11>
- <https://www.microsoft.com/software-download/windowsinsiderpreviewiso> (Preview)
- <https://www.microsoft.com/evalcenter/download-windows-10-enterprise>
- <https://www.microsoft.com/evalcenter/download-windows-11-enterprise>
- <https://www.microsoft.com/evalcenter/download-windows-11-iot-enterprise-ltsc-eval>
- <https://www.microsoft.com/evalcenter/download-windows-server-2012-r2>
- <https://www.microsoft.com/evalcenter/download-windows-server-2016>
- <https://www.microsoft.com/evalcenter/download-windows-server-2019>
- <https://www.microsoft.com/evalcenter/download-windows-server-2022>
- <https://www.microsoft.com/evalcenter/download-windows-server-2025>

</details>

#### Optional parameters

- `--password PASSWORD` Set Password
- `--allow-ping` Allow ping responses
- `--rdp-port PORT` Change RDP port
- `--ssh-port PORT` Change SSH port (for log observation during installation)
- `--web-port PORT` Change Web port (for log observation during installation)
- `--hold 2` Allow SSH connections for modifying the disk content before rebooting into the official Windows installation program, with the disk mounted at `/os`.

#### How to Specify the Image Name `--image-name`

Typically, an ISO will contain multiple system versions, such as Home Edition and Professional Edition. The image name `--image-name` is used to specify the version to be installed, and it is case-insensitive when entered.

You can use tools like DISM, DISM++, or Wimlib to query the image names included in the ISO.

Commonly used image names include:

```text
Windows 7 Ultimate
Windows 11 Pro
Windows 11 Enterprise LTSC 2024
Windows Server 2025 SERVERDATACENTER
```

#### How to Use [DISM++](https://github.com/Chuyu-Team/Dism-Multi-language/releases) to Query the Image Names Included in the ISO

Open File menu > Open Image File, select the iso to be installed to get the image name (full system name), and all available image names are installable.

![image-name](https://github.com/bin456789/reinstall/assets/7548515/5aae0a9b-61e2-4f66-bb98-d470a6beaac2)

#### The script will install the following drivers as needed

- Virtio ([Virtio](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/), [Alibaba Cloud](https://www.alibabacloud.com/help/ecs/user-guide/update-red-hat-virtio-drivers-of-windows-instances))
- XEN ([XEN](https://xenproject.org/windows-pv-drivers/), [Citrix](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Upgrading_PV_drivers.html#win2008-citrix-upgrade), [AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/xen-drivers-overview.html))
- AWS ([ENA Network Adapter](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ena-driver-releases-windows.html), [NVMe Storage Controller](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/nvme-driver-version-history.html))
- GCP ([gVNIC Network Adapter](https://cloud.google.com/compute/docs/networking/using-gvnic), [GGA Display Adapter](https://cloud.google.com/compute/docs/instances/enable-instance-virtual-display))
- Azure ([MANA Network Adapter](https://learn.microsoft.com/azure/virtual-network/accelerated-networking-mana-windows))
- Intel ([VMD Storage Controller](https://www.intel.com/content/www/us/en/download/720755/intel-rapid-storage-technology-driver-installation-software-with-intel-optane-memory-11th-up-to-13th-gen-platforms.html))

> [!WARNING]
> Vista (Server 2008) and 32-bit systems may lack drivers.

> [!WARNING]
> For EFI machines without CSM enabled, Windows 7 (Server 2008 R2) cannot be installed.
>
> Hyper-V (Azure) requires selecting the appropriate VM generation: <https://learn.microsoft.com/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v>

> [!WARNING]
> In the Chinese version of Windows 10 LTSC 2021 ISO `zh-cn_windows_10_enterprise_ltsc_2021_x64_dvd_033b7312.iso`, the `wsappx` process may indefinitely consume CPU resources.
>
> The solution is to update the system patches or manually install the `VCLibs` library <https://www.google.com/search?q=ltsc+wsappx>.

#### Considerations for Installing Windows on ARM

Most ARM machines support installing Windows 11 24H2.

During the installation process, you might encounter a black screen, and the serial console may display `ConvertPages: failed to find range`, but neither issue affects the installation.

| Compatibility | Cloud Provider | Instance Type | Issues                                                                                                                                                 |
| ------------- | -------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ✔️            | Azure          | B2pts_v2      |                                                                                                                                                        |
| ✔️            | Alibaba Cloud  | g6r, c6r      |                                                                                                                                                        |
| ✔️            | Alibaba Cloud  | g8y, c8y, r8y | There is a chance of hanging at the boot logo during restart; forced reboot will resolve it.                                                           |
| ✔️            | AWS            | T4g           |                                                                                                                                                        |
| ✔️            | Scaleway       | COPARM1       |                                                                                                                                                        |
| ✔️            | Gcore          |               |                                                                                                                                                        |
| ❔            | Oracle Cloud   | A1.Flex       | Installation success is not guaranteed; newer instances are more likely to succeed.<br />Manual loading of GPU drivers is required after installation. |
| ❌            | Google Cloud   | t2a           | Missing network card drivers                                                                                                                           |

<details>

<summary>Loading Graphics Driver on Oracle Cloud</summary>

Log in to the server using Remote Desktop, open Device Manager, locate the graphics card, select "Update Driver," and choose `Red Hat VirtIO GPU DOD controller` from the list. There's no need to download the drivers in advance.

![virtio-gpu-1](https://github.com/user-attachments/assets/503e1d82-4fa9-4486-917e-73326ad7c988)
![virtio-gpu-2](https://github.com/user-attachments/assets/bf3a9af6-13d8-4f93-9d6c-d3b2dbddb37d)
![virtio-gpu-3](https://github.com/user-attachments/assets/a9006a78-838f-45bf-a556-2dba193d3c03)

</details>

## Discussion

[![GitHub Issues](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)](https://github.com/bin456789/reinstall/issues)
[![Telegram Group](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/reinstall_os)
