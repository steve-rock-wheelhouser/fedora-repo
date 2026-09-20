# ⚠️ DEPRECATED: Steve Rock Wheelhouser Fedora RPM Repository

> [!WARNING]
> **This standalone repository (`fedora-repo`) is deprecated and is no longer actively maintained.**
> 
> All Fedora and Enterprise Linux packages have been consolidated into the unified multi-distribution repository:
> 
> **👉 [steve-rock-wheelhouser/wheelhouserllc-repo](https://github.com/steve-rock-wheelhouser/wheelhouserllc-repo)**

---

## Migration Instructions for Existing Users

If you are currently using this repository, upgrade your repository configuration package to automatically transition to `wheelhouserllc-repo`:

```bash
sudo dnf install -y https://raw.githubusercontent.com/steve-rock-wheelhouser/wheelhouserllc-repo/main/fedora/44/x86_64/steve-rock-wheelhouser-release-1.0-3.fc44.noarch.rpm
sudo dnf clean all
```

Alternatively, configure the new repository manually:

```bash
sudo curl -sL https://raw.githubusercontent.com/steve-rock-wheelhouser/wheelhouserllc-repo/main/steve-rock-wheelhouser-fedora.repo -o /etc/yum.repos.d/steve-rock-wheelhouser.repo
sudo dnf makecache
```

---

## Available Packages in `wheelhouserllc-repo`

All active packages—including `antigravity-ide` and `web-browser`—are actively updated and maintained in [wheelhouserllc-repo](https://github.com/steve-rock-wheelhouser/wheelhouserllc-repo).
