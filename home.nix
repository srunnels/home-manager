{ lib, pkgs, ... };

{ 
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "srunnels";
    homeDirectory = "/home/srunnels";
    
    stateVersion = "26.05";
    };
}
