{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    config = {
        user.name = "anno247";
        user.email = "iamanno247@gmail.com";
        pull.rebase = false;

        # GitHub CLI authentication
        credential."https://github.com".helper = [
          ""
          "!${pkgs.gh}/bin/gh auth git-credential"
        ];
      };
  };

  programs.fish.shellFunctions = {
    gs = {
      body = ''
        git status
      '';
    };
  };
}
