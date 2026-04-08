{...}: {
  launchd.user.agents.set-maxfiles = {
    serviceConfig = {
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "launchctl limit maxfiles 10240 10240"
      ];
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "/tmp/set-maxfiles.out";
      StandardErrorPath = "/tmp/set-maxfiles.err";
    };
  };
}
