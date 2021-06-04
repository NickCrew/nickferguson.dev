#!/usr/bin/env bash

set -x

tar -cvjf site.tar.bz2 ./site
scp site.tar.bz2 dev1:/home/nick/.
ssh dev1 /home/nick/bin/deploy-blog.sh
rm -f site.tar.bz2
