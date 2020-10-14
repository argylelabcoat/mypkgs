The C++/Cmake part of this builds fine.

Issue is that the yottadb/mumps executable, wants to relink M Code & Object Files and /nix/store is ro.

Solution seems to be to create a state dir in /var/lib/yottadb/$version/r or something for the m files and o files. 
