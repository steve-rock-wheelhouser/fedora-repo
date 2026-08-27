#!/bin/bash
set -euo pipefail

# Ensure script runs from its own directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Ensure standard system paths are in the PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:${PATH:-}"

echo "Signing RPM packages..."
RPMS=(*.rpm)
if [ -f "${RPMS[0]}" ]; then
    rpmsign --resign "${RPMS[@]}"
fi

echo "Updating README.md available packages list..."
python3 -c '
import os, glob, subprocess

repo_dir = os.getcwd()
readme_path = os.path.join(repo_dir, "README.md")
rpms = glob.glob(os.path.join(repo_dir, "*.rpm"))

packages = {}
for r in rpms:
    base = os.path.basename(r)
    if "release" in base:
        continue
    try:
        name = subprocess.check_output(["rpm", "-q", "--qf", "%{NAME}", "-p", r], stderr=subprocess.DEVNULL).decode().strip()
        summary = subprocess.check_output(["rpm", "-q", "--qf", "%{SUMMARY}", "-p", r], stderr=subprocess.DEVNULL).decode().strip()
        packages[name] = summary
    except Exception:
        pass

if packages and os.path.exists(readme_path):
    with open(readme_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    header = "### Available Packages"
    if header in content:
        base_content = content.split(header)[0]
        new_section = header + "\n\n"
        for pkg in sorted(packages.keys()):
            summary = packages[pkg].rstrip(".")
            new_section += f"* **`{pkg}`**: {summary}.\n  ```bash\n  sudo dnf install {pkg}\n  ```\n\n"
        with open(readme_path, "w", encoding="utf-8") as f:
            f.write(base_content + new_section)
'

echo "Generating RPM repository metadata..."
createrepo_c .

# Check if Git is initialized
if [ -d ".git" ]; then
    echo "Staging changes in Git..."
    git add -A
    
    # Check if there are changes to commit
    if git diff --cached --quiet; then
        echo "No repository changes to commit."
    else
        echo "Committing updates..."
        git commit -m "Update repository metadata and packages: $(date +'%Y-%m-%d %H:%M:%S')"
        
        # Check if remote exists before trying to push
        if git remote | grep -q "^origin$"; then
            BRANCH=$(git rev-parse --abbrev-ref HEAD)
            echo "Pushing changes to GitHub ($BRANCH)..."
            git push origin "$BRANCH" || echo "Warning: Git push failed. Please ensure the repository 'steve-rock-wheelhouser/fedora-repo' exists on GitHub and your SSH keys are set up correctly."
        else
            echo "Warning: No remote named 'origin' configured. Skipping push."
        fi
    fi
fi

echo "Repository update complete!"
