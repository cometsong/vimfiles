" Only do this when not yet done for this buffer
if exists('b:did_ftplugin') | finish | endif

setlocal ts=2 sts=-1 sw=0 expandtab fdm=marker
