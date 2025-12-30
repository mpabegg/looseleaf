#!/usr/bin/env bash
set -euo pipefail

# Regenerate initramfs so Plymouth assets are included at boot.
if [[ "${KERNEL_FLAVOR:-}" == "surface" ]]; then
  KERNEL_SUFFIX="surface"
else
  KERNEL_SUFFIX=""
fi

QUALIFIED_KERNEL="$(dnf5 repoquery --installed --latest-limit 1 --queryformat='%{evr}.%{arch}' "kernel${KERNEL_SUFFIX:+-${KERNEL_SUFFIX}}")"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree --add fido2 -f "/usr/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 "/usr/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
