#!/usr/bin/env bash
cd "$(dirname "$0")"
cd ..

# default usage: run script, hit enter

pypircfile=$HOME/.pypirc

# if exists, ask to use + continue, or overwrite + continue
if [[ -e "$pypircfile" ]]; then
  if whiptail --yesno "Use existing ${pypircfile}?" 10 60; then
    echo "Using existing ${pypircfile}."
  else
    if whiptail --yesno "Overwrite existing ${pypircfile}?" 10 60; then
      # delete old
      rm -rf "$pypircfile";
      printf "enter username "; read username
      printf "enter password "; read password

      # make new
      cat > "$pypircfile" << EOF
[distutils]
index-servers =
    pypi

[pypi]
username:$username
password:$password
EOF

    else
      exit 1
    fi
  fi
fi


# update PyPI with PyPIReadme.rst
python setup.py register

# update PyPI with fpdf2 package

