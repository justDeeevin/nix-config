{ config, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  # sops.secrets.SONARR_API_KEY.owner = "recyclarr";
  # sops.secrets.RADARR_API_KEY.owner = "recyclarr";

  services.recyclarr =
    let
      mkTemplateIncludes = builtins.map (template: {
        inherit template;
      });
    in
    {
      # enable = true;
      configuration = {
        sonarr =
          let
            base_url = "http://localhost:${builtins.toString config.services.sonarr.settings.server.port}";
            api_key._secret = config.sops.secrets.SONARR_API_KEY.path;
          in
          {
            # Recyclarr template config - WEB-2160p
            web-2160p-v4 = {
              inherit base_url api_key;

              include = mkTemplateIncludes [
                "sonarr-quality-definition-series"
                "sonarr-v4-quality-profile-web-2160p"
                "sonarr-v4-custom-formats-web-2160p"
              ];
            };
            # Recyclarr template config - Anime
            anime-sonarr-v4 = {
              inherit base_url api_key;

              include = mkTemplateIncludes [
                "sonarr-quality-definition-anime"
                "sonarr-v4-quality-profile-anime"
                "sonarr-v4-custom-formats-anime"
              ];

              custom_formats = [
                {
                  # Uncensored
                  # not that i plan on getting any censorable content? lol
                  trash_ids = [ "026d5aadd1a6b4e550b134cb6c72b3ca" ];
                  assign_scores_to = [
                    {
                      name = "Remux-1080p - Anime";
                      # Adjust scoring as desired
                      # TODO: figure out what that means 😭
                      score = 0;
                    }
                  ];
                }
                {
                  # 10bit
                  trash_ids = [ "b2550eb333d27b75833e25b8c2557b38" ];
                  assign_scores_to = [
                    {
                      name = "Remux-1080p - Anime";
                      score = 0;
                    }
                  ];
                }
                {
                  # Anime Dual Audio
                  trash_ids = [ "418f50b10f1907201b6cfdf881f467b7" ];
                  assign_scores_to = [
                    {
                      name = "Remux-1080p - Anime";
                      score = 0;
                    }
                  ];
                }
              ];
            };
          };
        radarr =
          let
            base_url = "http://localhost:${builtins.toString config.services.radarr.settings.server.port}";
            api_key._secret = config.sops.secrets.RADARR_API_KEY.path;
          in
          {
            # Recyclarr template config - UHD Bluray + WEB
            uhd-bluray-web = {
              inherit base_url api_key;

              include = mkTemplateIncludes [
                "radarr-quality-definition-movie"
                "radarr-quality-profile-uhd-bluray-web"
                "radarr-custom-formats-uhd-bluray-web"
              ];
            };
          };
      };
    };
}
