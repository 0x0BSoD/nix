{...}: {
  security = {
    pam.services = {
      sudo_local = {
        touchIdAuth = false;
        reattach = false;
      };
    };
  };
}
