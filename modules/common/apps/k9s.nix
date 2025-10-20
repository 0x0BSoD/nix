{...}: {
  programs.k9s = {
    enable = true;

    settings = {
      k9s = {
        refreshRate = 2;
        maxConnRetry = 5;
        readOnly = false;
        noExitOnCtrlC = false;
        skipLatestRevCheck = false;
        disablePodCounting = false;
        ui = {
          skin = "nord";
          enableMouse = false;
          headless = false;
          logoless = true;
          crumbsless = false;
          reactive = true;
          noIcons = true;
        };
      };
    };

    aliases = {
      dp = "deployments";
      sec = "v1/secrets";
      jo = "jobs";
      cr = "clusterroles";
      crb = "clusterrolebindings";
      ro = "roles";
      rb = "rolebindings";
      np = "networkpolicies";
    };

    skins = {
      nord = ./k9s.nord.yaml;
    };
  };
}
