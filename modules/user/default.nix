{options,config,pkgs,lib,...}:

with lib;
with lib.internal;
let
  cfg=config.creeper-config.user;
in
{
  options.creeper-config.user = with types; {
    name = mkOpt str "pinkcreeper100" "User account name.";
    fullName =mkOpt str "Oliver Morris" "Full name";
    email = mkOpt str "benmoreosm@gmail.com" "Email";
    initialPassword = mkOpt str "password" "Initial password";
    # icon = mkOpt (nullOr package) defaultIcon "Profile picture";
    extraGroups = mkOpt (listOf str) [] "extra groups";
    
  };
}
