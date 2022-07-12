#!/bin/bash
export TMPDIR=$XDG_CACHE_HOME/tmp
exec /app/bin/pulse-browser "$@"
