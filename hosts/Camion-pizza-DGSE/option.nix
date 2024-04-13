let
  setUsername = "defaultuser";
  setHostname = "nixos";
in
{
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";

  gitUsername = "Abel Chartier";
  gitEmail = "abel.chartier@gmail.com";

  clock24h = false;
  aLocale = "en_US.UTF-8";
  Xkblayout = "us";
  XkbVariant = "";
  aTimezone = "Asia/Jakarta";

}
