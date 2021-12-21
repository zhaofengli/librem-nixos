{ lib, gtk3, fetchurl, fetchFromGitLab }:
let
  purismGtk = fetchFromGitLab {
    domain = "source.puri.sm";
    owner = "Librem5";
    repo = "debs/gtk";
    rev = "40761f98da563488cdea5b7de7bbb5d2d43988d5";
    sha256 = "sha256-XXgJePVlzjXjjrayVH/aCMPyfWtvvYTxKwVBKhsDRsU=";
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
    "pureos/librem5-Drop-reftests.patch"
    "pureos/Drop-prebuilt-files-in-gtk.patch"
    "pureos/gdk-wayland-Take-transform-into-account-when-setting-phys.patch"
    "pureos/gtkapplication-dbus-Fetch-inital-screen-saver-state-async.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyViewSwitcherButton.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyViewSwitcher.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyViewSwitcherBar.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyAnimation.patch"
    "pureos/adaptive/libhandy/Add-GtkHdySqueezer.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyViewSwitcherTitle.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyShadowHelper.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyNavigationDirection.patch"
    "pureos/adaptive/libhandy/Add-GtkHdySwipeable-and-GtkHdySwipeTracker.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyClamp.patch"
    "pureos/adaptive/libhandy/Add-GtkHdyFlap.patch"
    "pureos/adaptive/libhandy/theme-Add-libhandy-styles.patch"
    "pureos/adaptive/libhandy/Add-padding-for-HdyViewSwitcherTitle.patch"
    "pureos/adaptive/libhandy/hdy-flap-Use-natural-size-for-folding-instead-of-minimum.patch"
    "pureos/adaptive/Add-org.gtk.Settings.Purism.patch"
    "pureos/adaptive/gtkprivate-Add-an-API-to-check-if-phone.patch"
    "pureos/adaptive/aboutdialog-Port-to-phones.patch"
    "pureos/adaptive/Add-the-view-sidebar-symbolic-icon.patch"
    "pureos/adaptive/Port-file-chooser-to-phones.patch"
    "pureos/adaptive/messagedialog-Set-orientation-based-on-device.patch"
    "pureos/adaptive/dialog-Maximize-resizable-dialogs-on-phones.patch"
    "pureos/adaptive/window-Maximize-resizable-pseudo-dialogs-on-mobile.patch"
    "pureos/adaptive/headerbar-Use-a-back-button-in-dialogs-on-mobile.patch"
    "pureos/adaptive/infobar-Move-the-action-area-below-on-the-phone.patch"
    "pureos/adaptive/Reduce-the-font-chooser-minimum-size.patch"
    "pureos/adaptive/printunixdialog-Adapt-for-phones.patch"
    "pureos/adaptive/window-Disable-window-dragging-on-phones.patch"
    "pureos/adaptive/librem5-Make-GtkShortcutsWindow-adaptive.patch"
    "pureos/adaptive/scrolledwindow-Set-deceleration-value-based-on-the-device.patch"
    "pureos/events-Compress-touch-update-events.patch"
  ];
in gtk3.overrideAttrs (old: rec {
  version = "3.24.27";

  src = fetchurl {
    url = "mirror://gnome/sources/gtk+/${lib.versions.majorMinor version}/gtk+-${version}.tar.xz";
    sha256 = "09ksflq5j257bf5zn8q2nnf2flicg9qqgfy7za79z7rkf1shc77p";
  };

  patches = (old.patches or []) ++ (map (p: "${purismGtk}/debian/patches/${p}") patchset);
})
