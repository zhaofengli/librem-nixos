# Librem 5 NixOS Overlay

This Nixpkgs overlay contains patched versions of packages used for the Librem 5 phone.

## Packages

This overlay does not override any packages directly, but rather place the patched versions under `pkgs.librem`:

- `gtk3`

## Recommended Configurations

```nix
{
  powerManagement.enable = true;
  services.upower.enable = true;

  system.replaceRuntimeDependencies = [
    {
      original = pkgs.gtk3;
      replacement = pkgs.librem.gtk3;
    }
  ];

  environment.etc."machine-info".text = ''
    CHASSIS="handset"
  '';
}
```
