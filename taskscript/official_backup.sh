#!/bin/bash

#define a dir to be archived

src_dir="/var/www/html/official"

#define the name of archive file

arch_file="xfusioncorp_official.zip"


#define a destination dir

dest_dir="/backup/"

#archive the dir

zip -r $dest_dir/$arch_file $src_dir

#copy the archive to backup server

scp /backup/xfusioncorp_official.zip clint@stbkp01:/backup/
