# Steve Rock Wheelhouser Fedora RPM Repository

This is a custom RPM repository containing Fedora packages for Steve Rock Wheelhouser's utilities.

---

## Installation Instructions

You can set up this repository and install packages on your Fedora system in one of two ways:

### Option A: Install via Release Bootstrap RPM (Recommended)
This method automatically configures the repository and imports the GPG signing keys:

```bash
sudo dnf install https://raw.githubusercontent.com/steve-rock-wheelhouser/fedora-repo/main/steve-rock-wheelhouser-release-1.0-1.fc44.noarch.rpm
sudo dnf install antigravity
```

---

### Option B: Manual Repository Setup (Alternative)
If you prefer to configure the repository manually, you can download the `.repo` configuration file directly:

```bash
# 1. Download repository config file
sudo curl -sL https://raw.githubusercontent.com/steve-rock-wheelhouser/fedora-repo/main/steve-rock-wheelhouser.repo -o /etc/yum.repos.d/steve-rock-wheelhouser.repo

# 2. Install the package
sudo dnf install antigravity
```
