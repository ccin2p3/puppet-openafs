* use `bos adduser localhost wernli -localauth` for admins
* add fact with module information, e.g. filename and/or vermagic
* unload module before starting service as service fails if already loaded
* sysconfig should be empty before installing package: otherwise it only contains one line
* setcell -suid
