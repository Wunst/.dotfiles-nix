{ config, ... }:

{
  services.random-background = {
    enable = true;
    interval = "10m";
    imageDirectory = "${./images}";
  };
}
