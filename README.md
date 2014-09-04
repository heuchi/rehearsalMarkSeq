rehearsalMarkSeq
================

A plugin for MuseScore for automatic rehearsal mark sequencing

This prototype (running only with PR1275 merged) can be configured in
the qml code to:

* use letters A-Z, Aa-Zz skipping I, Ii, J, Jj, O and Oo
* use letters A-Z, Aa-Zz using I, Ii, J, Jj, O and Oo
* use numbers
* start at given index

Any other array of marks could easily be added.

It is configured in the qml source since there is no GUI yet.

However, once PR1275 or something similar is merged, this prototype
can easily be developed to a version that can be configured by the user.
