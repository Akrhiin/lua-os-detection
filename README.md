# lua-os-detection
Function that returns two strings, describing OS name and architecture respectively. For Windows identification is based on env variables, and for unix a call to uname is used.  
Note that Windows provides limited information through env variables, so x64 architecture is not always properly indicated.
