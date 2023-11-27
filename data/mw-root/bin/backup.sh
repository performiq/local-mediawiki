#!/bin/sh

TSTAMP=`date "+%Y%m%d_%H%M%S"`

# ------------------------------------------------------------------------------

cd /var/www

tar cvzf /bak/mw-${TSTAMP}.tz html


