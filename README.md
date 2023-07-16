initial:
```bash

```



after change:
`sudo cp *.nix /etc/nixos/ && sudo nixos-rebuild switch`


no space on efi:
`sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2 `