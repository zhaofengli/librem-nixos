{ lib, autoreconfHook, fetchpatch, gtk_doc, upower }: upower.overrideAttrs (old: {
  nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
    autoreconfHook gtk_doc
  ];
  patches = (old.patches or []) ++ [
    (fetchpatch {
      name = "0001-Add-torch-support.patch";
      url = "https://gitlab.freedesktop.org/upower/upower/-/merge_requests/50.patch";
      sha256 = "1qw0jsnwfgljad8pv22xgnw235sb9lqsmpgy68m73zxsydb2h16r";
    })
  ];
})
