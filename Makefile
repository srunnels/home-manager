.PHONY: update
update:
	home-manager switch --flake .#myprofile

.PHONY: clean
	nix-collect-garbage -d
