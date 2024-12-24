# Fedora Packaging Guidelines

           install upgrade uninstall
%pretrans  $1 == 1 $1 == 2 (N/A)
%pre       $1 == 1 $1 == 2 (N/A)
%post      $1 == 1 $1 == 2 (N/A)
%preun     (N/A)   $1 == 1 $1 == 0
%postun    (N/A)   $1 == 1 $1 == 0
%posttrans $1 == 1 $1 == 2 (N/A) 

The scriptlets in %pre and %post are respectively run before and after a package is installed. The scriptlets %preun and %postun are run before and after a package is uninstalled. The scriptlets %pretrans and %posttrans are run at start and end of a transaction. On upgrade, the scripts are run in the following order:

     1. %pretrans of new package
     2. %pre of new package
     3. (package install)
     4. %post of new package
     5. %triggerin of other packages (set off by installing new package)
     6. %triggerin of new package (if any are true)
     7. %triggerun of old package (if it’s set off by uninstalling the old package)
     8. %triggerun of other packages (set off by uninstalling old package)
     9. %preun of old package
    10. (removal of old package)
    11. %postun of old package
    12. %triggerpostun of old package (if it’s set off by uninstalling the old package)
    13. %triggerpostun of other packages (if they’re set off by uninstalling the old package)
    14. %posttrans of new package

/usr/lib/rpm/macros.d/macros.systemd

%post
    %systemd_post
    1: /usr/lib/systemd/systemd-update-helper install-system-units
    systemctl --no-reload preset "$@"

%preun
    %systemd_preun
    # Removal, not upgrade.
    0: /usr/lib/systemd/systemd-update-helper remove-system-units
    # Do not reload the _service_ config (_system_ daemon-reload is different).
    systemctl --no-reload disable --now --no-warn "$@"

%postun
    %systemd_postun
    %{expand:%%{?__systemd_someargs_%#:%%__systemd_someargs_%# systemd_postun}} \
    %{nil}

    %systemd_postun_with_restart
               install upgrade uninstall
    %postun    (N/A)   $1 == 1 $1 == 0
    1: /usr/lib/systemd/systemd-update-helper mark-restart-system-units
    systemctl set-property "$unit" Markers=+needs-restart

https://docs.fedoraproject.org/en-US/packaging-guidelines/Scriptlets/#_systemd

- "On upgrade, a package may only restart a service if it is running; it may not start it if it is off. Also, the service may not enable itself if it is currently disabled."
