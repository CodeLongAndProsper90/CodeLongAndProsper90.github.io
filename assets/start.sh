qemu-system-i386 -hda win31.img -cdrom data.iso -fda sound.img -boot ca -cpu pentium -m 16 -vga vmware -net nic,model=pcnet -net user -soundhw sb16
