initial:
```bash
mkdir repos  
nix-shell -p github-cli git 
gh auth login
```



after change:  
```bash
sudo cp *.nix /etc/nixos/ && sudo nixos-rebuild switch
```


no space on efi:  
```bash
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
```







other stuff  
* steam: https://gist.github.com/jakehamilton/632edeb9d170a2aedc9984a0363523d3