{pkgs, ...}: {
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override {enableHybridCodec = true;};
  };

  boot.kernelParams = [
    "i915.enable_guc=3" # Enable GuC/HuC firmware loading
    "i915.force_probe=7dd1"
    # "intel_pstate=active"
    # "i915.modeset=1"
    # "i915.enable_psr=0" # Panel Self Refresh for power savings
    # "i915.enable_fbc=1" # Framebuffer compression
    # "i915.fastboot=1" # Skip unnecessary mode sets at boot
    # "i915.enable_dc=2" # Display power saving
    # "nvme.noacpi=1" # Helps with NVME power consumption
    # "mem_sleep_default=deep" # Allow deepest sleep states
  ];

  # Load the driver
  # services.xserver.videoDrivers = ["modesetting"];
  services.xserver.videoDrivers = ["intel"];
  services.xserver.deviceSection = ''
    Option "DRI" "2"
    Option "TearFree" "true"
  '';
  # OpenGL
  hardware = {
    # May help if FFmpeg/VAAPI/QSV init fails (esp. on Arc with i915):
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # VA-API (iHD) userspace
        vpl-gpu-rt # oneVPL (QSV) runtime

        # intel-media-driver
        # (intel-vaapi-driver.override {enableHybridCodec = true;})
        # libva-vdpau-driver
        # libvdpau-va-gl
      ];
    };
  };

  # Thermal and Noise Management
  services.thermald.enable = true;
  services.throttled.enable = false;
}
