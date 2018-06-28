# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source all files in ~/.bashrc.d/
for i in ~/.bashrc.d/* ; do
  if [ -r "$i" ]; then
    source $i
  fi
done
