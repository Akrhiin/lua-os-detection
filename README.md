# lua-os-detection
Function that returns two strings, describing OS name and architecture respectively. For Windows identification is based on env variables, and for unix a call to uname is used.  
Note that Windows provides limited information through env variables, so x64 architecture is not always properly indicated.

This code was originally used as part of a build package for a game that I never finished, but seemed useful enough to keep around even after I changed my approach.
