# external definition of the programs.firefox nix module
# moved to a separate file solely to reduce visual pollution in configuration.nix
{
  enable = true;
  policies = {
    # informed by https://www.stigviewer.com/stig/mozilla_firefox/
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    EnableTrackingProtection = {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
      DisabledCiphers = {
  "TLS_RSA_WITH_3DES_EDE_CBC_SHA" = true;
      };
      SSLVersionMin = "tls1.2";
    };
    FirefoxHome = {
      Search = true;
      TopSites = true;
      SponsoredTopSites = false;
      Pocket = false;
      SponsoredPocket = false;
      Highlights = true;
      Snippets = false;
      Locked = true;
    };
    Preferences = let
      lock-false = { Value = false; Status = "locked"; };
      lock-true = { Value = true; Status = "locked"; };
    in {
      "browser.contentblocking.category" = { Value = "strict"; };
      "browser.search.update" = lock-false;
      "dom.disable_window_flip" = lock-true;
      "dom.disable_window_move_resize" = lock-true;
      "exensions.pocket.enabled" = lock-false;
      "privacy.trackingprotection.cryptomining.enabled" = lock-true;
    };
  };
}
