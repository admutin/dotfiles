{ config, pkgs, ... }: {
  isNormalUser = true;
  description = "";
  extraGroups = [ "networkmanager" "wheel" "video" "audio" "davfs2"];
  packages = with pkgs; [  ];
    
 
}
