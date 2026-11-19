#!/bin/sh

# dkms scripts for broadcom-wl
dkms_install() {
    # shellcheck disable=SC2045
    kernel_version="$(find /usr/lib/modules -maxdepth 1 -type d -iname '*-linux' -printf "%f\n" | sort -V | tail -n1)"

    [ -n "${kernel_version}" ] || kernel_version="$(uname -r)"
    printf "dkms: building broadcom-wl modules for kernel %s...\n" "${kernel_version}"

    dkms add     -m broadcom-wl/%version%
    dkms build   -m broadcom-wl/%version% -k "${kernel_version}"
    dkms install -m broadcom-wl/%version% -k "${kernel_version}"
}

dkms_remove() {
    dkms remove -m broadcom-wl --all
}

case "${1}" in
    install) dkms_install ;;
    remove) dkms_remove ;;

    *)
        dkms_remove
        dkms_install
    ;;
esac
