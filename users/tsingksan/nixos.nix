{ config, lib, pkgs, modulesPath, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
in {
	nix = {
		settings = {
			use-xdg-base-directories = true;
			# substituters = [
			#   "https://mirrors.ustc.edu.cn/nix-channels/store"
			#   "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
			#   "https://cache.nixos.org/"
			# ];
			# trusted-public-keys = [
			#   "mirrors.ustc.edu.cn:UmPCkKFZlHGKKMEMW4Cambh2I6WDhQQCCwMD1YzuFRw="
			#   "mirrors.tuna.tsinghua.edu.cn:du5vxltwrm73p1l7qr4p0hglqkck2rqmqvh5psqh5xq="
			#   "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
			# ];
		};
	};

    users.users.tsingksan = {
		isNormalUser = true;
		home = "/Users/tsingksan";
		extraGroups = [ "docker" "wheel" ];
		shell = pkgs.zsh;
		hashedPassword = "$6$tKg08JXcXZ7H2dhW$bd1dEPD9ZM6XK2LkIX5bC0HjXerfkUxKEHMk8tIy/KssnE5mHJBtncmjRHfbF5tPDyDwNUMvOd9yfIohFdHBQ0";
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5Hz44CGQ8CW2nN17ZWl1EQb2PNvusWU6cD9BD8tlmk none"
		];
    };

	programs = {
		zsh = {
			enable = true;
			enableGlobalCompInit = false;
			promptInit = "\n";
		};
		bash = {
			completion.enable = false;
		};
	};
}
