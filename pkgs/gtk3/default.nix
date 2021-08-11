{ lib, gtk3, fetchurl, fetchFromGitLab }:
let
  purismGtk = fetchFromGitLab {
    domain = "source.puri.sm";
    owner = "Librem5";
    repo = "debs/gtk";
    rev = "f05e4021ed82bfbabf566398d0511b6745a5745e";
    sha256 = "sha256-Wq6pPKF+c3n/eCEZdYtN9HSLfWJDFJI7YqKA7ciRj+M=";

  };
  patchset = [
    "updateiconcache-Sort-list-of-entries.patch"
    "gdk-Don-t-distribute-generated-files-in-tarballs.patch"
    "gtk-Really-don-t-distribute-built-files.patch"
    "demos-examples-tests-Don-t-distribute-built-files.patch"
    "016_no_offscreen_widgets_grabbing.patch"
    "017_no_offscreen_device_grabbing.patch"
    "060_ignore-random-icons.patch"
    "reftest-known-fail.patch"
    "Disable-accessibility-dump-aka-a11ytests-test.patch"
    "librem5-Drop-reftests.patch"
    "Drop-prebuilt-files-in-gtk.patch"
    "Add-GtkHdyViewSwitcherButton.patch"
    "Add-GtkHdyViewSwitcher.patch"
    "Add-GtkHdyViewSwitcherBar.patch"
    "Add-GtkHdyAnimation.patch"
    "Add-GtkHdySqueezer.patch"
    "Add-GtkHdyViewSwitcherTitle.patch"
    "Add-GtkHdyShadowHelper.patch"
    "Add-GtkHdyNavigationDirection.patch"
    "Add-GtkHdySwipeable-and-GtkHdySwipeTracker.patch"
    "Add-GtkHdyClamp.patch"
    "Add-GtkHdyFlap.patch"
    "theme-Add-libhandy-styles.patch"
    "Add-padding-for-HdyViewSwitcherTitle.patch"
    "Add-org.gtk.Settings.Purism.patch"
    "gtkprivate-Add-an-API-to-check-if-phone.patch"
    "aboutdialog-Port-to-phones.patch"
    "Add-the-view-sidebar-symbolic-icon.patch"
    "Port-file-chooser-to-phones.patch"
    "hdy-flap-Use-natural-size-for-folding-instead-of-minimum.patch"
    "messagedialog-Set-orientation-based-on-device.patch"
    "scrolledwindow-Set-deceleration-value-based-on-the-device.patch"
    "dialog-Maximize-resizable-dialogs-on-phones.patch"
    "window-Maximize-resizable-pseudo-dialogs-on-mobile.patch"
    "headerbar-Use-a-back-button-in-dialogs-on-mobile.patch"
    "infobar-Move-the-action-area-below-on-the-phone.patch"
    "Reduce-the-font-chooser-minimum-size.patch"
    "printunixdialog-Adapt-for-phones.patch"
    "window-Disable-window-dragging-on-phones.patch"
    "events-Compress-touch-update-events.patch"
    "librem5-Make-GtkShortcutsWindow-adaptive.patch"
    "gdk-wayland-Take-transform-into-account-when-setting-phys.patch"
    "gtkapplication-dbus-Fetch-inital-screen-saver-state-async.patch"
  ];
in gtk3.overrideAttrs (old: rec {
  version = "3.24.27";

  src = fetchurl {
    url = "mirror://gnome/sources/gtk+/${lib.versions.majorMinor version}/gtk+-${version}.tar.xz";
    sha256 = "09ksflq5j257bf5zn8q2nnf2flicg9qqgfy7za79z7rkf1shc77p";
  };

  patches = (old.patches or []) ++ (map (p: "${purismGtk}/debian/patches/${p}") patchset);
})
