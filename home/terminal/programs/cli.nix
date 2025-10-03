{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    chafa
    libnotify
    sshfs

    # utils
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
    ripdrag
  ];

  programs = {
    eza.enable = true;
    ssh = {
      enable = true;
      enableDefaultConfig = false;

      matchBlocks = {
        # default ssh config
        "*" = {
          addKeysToAgent = "no";
          certificateFile = [ ];
          checkHostIP = true;
          compression = false;
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
          dynamicForwards = [ ];
          extraOptions = { };
          forwardAgent = false;
          forwardX11 = false;
          forwardX11Trusted = false;
          hashKnownHosts = false;
          identitiesOnly = false;
          identityAgent = [ ];
          identityFile = [ ];
          localForwards = [ ];
          remoteForwards = [ ];
          sendEnv = [ ];
          serverAliveCountMax = 3;
          serverAliveInterval = 0;
          setEnv = { };
          userKnownHostsFile = "~/.ssh/known_hosts";
        };
      };
    };
  };
}