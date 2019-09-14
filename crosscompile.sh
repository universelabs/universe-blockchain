# Cross compiles for myriad platforms
gox
# Removes FreeBSD, OpenBSD, Windows386, Mac386, s390x
rm gaiacli_freebsd* gaiacli_linux_m* gaiacli_openbsd_* gaiacli_windows_386* gaiacli_linux_s390x gaiacli_darwin_386
# Moves binaries to match uname -m
mv gaiacli_darwin_amd64 gaiacli_darwin_x86_64
mv gaiacli_linux_386 gaiacli_linux_x86
mv gaiacli_linux_amd64 gaiacli_linux_x86_64
mv gaiacli_linux_arm gaiacli_linux_armv7l
# Builds for Pi W Zero, original Pi
env GOOS=linux GOARCH=arm GOARM=5 go build
mv gaiacli gaiacli_linux_armv6l
