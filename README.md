Eie
---
Eie is a Perl script that serves as a revision control system.

Usage:

`eie init` initializes the Eie repository.

`eie add _file1_ _file2_ ...` adds to the list of files to be committed.

`eie clear` clears the list of files to be committed.

`eie commit` commits the files added.

`eie killall` removes the Eie repository (but not the actual files). The removes all Eie history.

`eie history _time1_ _time2_...` displays locations of files in each commit. Not extremely practical.
More to come.

`eie list _filename_` lists all the commit-files that hold committed versions of _filename_.