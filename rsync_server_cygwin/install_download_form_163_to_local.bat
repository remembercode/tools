@echo off
set parent=%CD%
pushd %~dp0
if exist setup-x86.exe (
	setup-x86.exe --disable-buggy-antivirus --download --local-package-dir "%CD%" -R "C:\cygwin" --site "http://mirrors.163.com/cygwin/" --no-verify --quiet-mode --packages "alternatives,attr,base-cygwin,base-files,bash,bzip2,ca-certificates,coreutils,crypt,csih,cygrunsrv,cygutils,cygwin,dash,diffutils,dos2unix,e2fsprogs,editrights,file,findutils,gawk,gcc,gdbm,getent,gettext,gmp,grep,groff,gzip,hostname,ipc-utils,krb5,less,libargp,libedit,libffi,libiconv,libpipeline,libsigsegv,libtasn1,login,lynx,man-db,mintty,mpfr,ncurses,openssh,openssl,p11-kit,pcre,popt,readline,rebase,rsync,run,sed,tar,texinfo,tzcode,util-linux,vim,wh,ch,xz,zlib,_autorebase"
) else (
	echo setup-x86.exe do not exist
)
pushd %parent%