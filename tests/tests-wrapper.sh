#!/usr/bin/env bash

set -ex

logfile=tests/output.txt

rm -f "$logfile"

# check if we need to copy the sample config file over
mkdir -p local
[ -f local/settings.tcl ] || cp modules/settings.sample.tcl local/settings.tcl

# tcltest doesn't know how to do exit codes, sigh
tclsh tests/run-tests.tcl | tee "$logfile"

grep -qF 'Files with failing tests' "$logfile" && exit 1
grep -qF 'Test files exiting with errors' "$logfile" && exit 1

# consume grep's error if the were no matches
exit 0
