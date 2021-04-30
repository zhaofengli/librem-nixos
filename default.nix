self: super:
{
  librem = {
    gtk3 = super.callPackage ./pkgs/gtk3 {};
    upower = super.callPackage ./pkgs/upower {};
  };
}
