This site is hosted on a VPS running an outdated Fedora Core release. Upgrading Fedora Core between major versions is unsupported, and the previous attempt at upgrading failed horribly. Therefore, I'm stuck on this release.

This also means that there are no up-to-date packages anymore, so the only way to upgrade installed stuff is to compile it from source.

## Managing Packages by Hand Sucks… usually

Usually, packages not maintained by the system or a package manager live in <span class="path">/usr/local</span>. Using this location to install packages compiled from source is not a bad choice, because that way it can't interfere with packages installed either by the system or a package manager.

One problem with this approach is that it is very hard to figure out what package a file belongs to. For example, what installed <span class="path">/usr/local/bin/spawn-fcgi</span>? (Answer: lighttpd, not FastCGI). This makes uninstalling packages hard.

Uninstalling packages is not a problem when using a package manager, because nothing is easier than `sudo pkg uninstall blah`. Some source tarballs have a makefile with an "uninstall" target, which can be quite useful as well, but most makefiles don't.

There is an easy way to make managing packages by hand a lot easier.

## An Alternative Filesystem Hierarchy

As a small experiment, I've started using an alternative filesystem layout for managing packages I install from source. The idea comes from [GoboLinux](http://www.gobolinux.org/), which uses a drastically different filesystem hierarchy as well. Here's what I do:

Every package lives in its own directory, and every version lives in its own subdirectory. For example, the latest version of Lighttpd is installed in <span class="path">/opt/pkgs/lighttpd/1.4.18</span>. The lighttpd configuration file lives at <span class="path">/opt/pkgs/lighttpd/common/etc/lighttpd.conf</span> since it's not version-dependent.

This filesystem hierarchy doesn't work right out of the box, though. To start an app, you have to specify the absolute path to the executable. Or, you can also adjust `$PATH`, but `$PATH` may grow to enormous proportions that way. I've decided to create <span class="path">/opt/bin</span> and <span class="path">/opt/sbin</span> directories with symlinks to the actual binaries.

Here's an example of what my directories look like now:

    /
        opt/
            bin/
                transmission-cli    (symlink)
                transmission-daemon (symlink)
                transmission-proxy  (symlink)
                transmission-remote (symlink)
            pkgs/
                lighttpd/
                    common/
                        etc/
                            lighttpd.conf
                    1.4.18/
                        bin/
                            spawn-fcgi
                        lib/
                            mod_access.la
                            mod_access.so
                        sbin/
                            lighttpd
                            lighttpd-angel
                transmission/
                    0.96/
                        bin/
                            transmission-cli
                            transmission-daemon
                            transmission-proxy
                            transmission-remote
            sbin/
                lighttpd       (symlink)
                lighttpd-angel (symlink)

This filesystem layout has a few advantages:

<ul class="sentences">
    <li>Files are grouped together in packages. Figuring out what package a given file is from is trivially easy.</li>
    <li>Multiple versions of a single package can be installed at a time. Software that require a specific version can therefore still work without breaking.</li>
    <li>Removing a package is as easy as a simple <kbd>rm -r</kbd>.</li>
    <li>Upgrading a package can be as simple as installing the new package, and then changing the symlinks to point to the new binaries.</li>
</ul>

This way of organising files is not entirely compatible with the [Filesystem Hierarchy Standard](http://www.pathname.com/fhs/). According to the FHS, The `/opt` directory can have subdirectories for each package, but packages can't have subdirectories for each version. Also, configuration files for `/opt` have to be stored in `/etc/opt`. Whatever. I don't care much about the FHS anyway.

You'd expect using such a different filesystem layout would break a lot of functionality, but I've been using this file hierarchy for a few days without any trouble at all.

Whether this alternative hierarchy really works well in the long run remains to be seen, but I'm optimistic. I'll let you know how this worked out in a year or so.
