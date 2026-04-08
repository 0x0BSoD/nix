{...}: {
  launchd.daemons.limit.maxfiles = {
    soft = 10240;
    hard = 10240;
  };

  launchd.user.agents.limit.maxfiles = {
    soft = 10240;
    hard = 10240;
  };
}
