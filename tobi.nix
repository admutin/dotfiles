{ config, pkgs, ... }: {
  isNormalUser = true;
  description = "";
  extraGroups = [ "networkmanager" "wheel" "video" "audio" "davfs2" "docker"];
  packages = with pkgs; [  ];
    
 
}
