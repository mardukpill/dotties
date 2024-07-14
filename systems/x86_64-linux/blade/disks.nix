_: {
  fileSystems = {
    "/media/shared" = {
      device = "/dev/disk/by-uuid/17DDE0D865E0DD6C";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" "gid=100" "windows_names" "locale=en_US.UTF-8" "dmask=027" "fmask=137"];
    };

		"/media/windows" = {
      device = "/dev/disk/by-uuid/2AFE8EADFE8E713D";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" "gid=100" "windows_names" "locale=en_US.UTF-8" "dmask=027" "fmask=137"];
    };
  };
}
