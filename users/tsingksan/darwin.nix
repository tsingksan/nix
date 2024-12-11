{ config, pkgs, ... }:

{
	imports = [
		./homebrew.nix
	];

	nix = {
		channel.enable = false;
		settings = {
			use-xdg-base-directories = true;
			experimental-features = "nix-command flakes";
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
		optimise = {
			automatic = true;
			interval = [
			{
				Weekday = 7;
			}
			];
		};
	};

	programs = {
		zsh = {
			enableGlobalCompInit = false;
			promptInit = "\n";
		};
		bash = {
			enable = false;
			completion.enable = false;
		};
	};

	users.users.todd = {
		home = "/Users/todd";
	};

	# environment.variables = {
	# TERMINFO_DIRS = "${pkgs.kitty.terminfo.outPath}/share/terminfo";
	# };
	programs.nix-index.enable = true;

	environment.darwinConfig = "$HOME/.config/nix-darwin/configuration.nix";

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 5;

	# The platform the configuration will be used on.
	nixpkgs.hostPlatform = "aarch64-darwin";

	environment.launchDaemons.mihomo = {
		enable = true;
		text = ''
			<?xml version="1.0" encoding="UTF-8"?>
			<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
			<plist version="1.0">
			<dict>
			<key>Label</key>
			<string>mihomo</string>
			<key>ProgramArguments</key>
			<array>
				<string>${pkgs.mihomo}/bin/mihomo</string>
				<string>-d</string>
				<string>${config.users.users.todd.home}/.config/mihomo</string>
			</array>
			<key>KeepAlive</key>
			<true/>
			<key>RunAtLoad</key>
			<true/>
			<key>WorkingDirectory</key>
			<string>${config.users.users.todd.home}</string>
			<key>StandardOutPath</key>
			<string>${config.users.users.todd.home}/Library/Logs/mihomo.log</string>
			<key>StandardErrorPath</key>
			<string>${config.users.users.todd.home}/Library/Logs/mihomo.err</string>
			</dict>
			</plist>
		'';
		target = "mihomo.plist"; # 文件名
	};
}
