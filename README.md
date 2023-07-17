initial:
```bash
mkdir repos  
nix-shell -p github-cli git 
gh auth login
```



after change:
`sudo cp *.nix /etc/nixos/ && sudo nixos-rebuild switch`


no space on efi:
`sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2 `



webdav:  
`sudo chmod 600 /etc/davfs2/secrets`

app name:  
`alt + F2`
`lg` -> `windows` upper right