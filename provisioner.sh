#!/bin/bash
yum -y groupinstall "development tools"
yum -y install git vim wget curl tmux
yum -y install gcc glibc-devel make ncurses-devel openssl-devel autoconf

# Clone some repos
git clone https://github.com/elixir-lang/elixir.git
git clone https://github.com/davidk01/vimrc.git

# Make sure vimrc is up to date
pushd vimrc
git pull
popd

# Copy rc files into place
cp vimrc/vimrc ~/.vimrc
cp vimrc/vimrc /home/vagrant/.vimrc

# Update elixir to latest
pushd elixir
git pull
popd

# Install pathogen
if [[ ! -e ~/.vim/autoload/pathogen.vim ]]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
  su -l vagrant -c 'mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
fi

# Install vim-elixir
if [[ ! -e ~/.vim/bundle/vim-elixir ]]; then
  git clone https://github.com/elixir-lang/vim-elixir.git ~/.vim/bundle/vim-elixir
  su -l vagrant -c 'git clone https://github.com/elixir-lang/vim-elixir.git ~/.vim/bundle/vim-elixir'
fi

# Get erlang source if we don't have it
erlang="otp_src_18.0"
if [[ ! -e ${erlang}.tar.gz ]]; then
  wget http://www.erlang.org/download/${erlang}.tar.gz
  tar xf ${erlang}.tar.gz
fi

# Install erlang
pushd ${erlang}
./configure && make -j2 && make install
popd

# Symlink erlang binaries so we don't have to mess with path
for binary in /usr/local/lib/erlang/bin/*; do
  link=/usr/bin/$(basename ${binary})
  if [[ ! -e ${link} ]]; then
    ln -s -T ${binary} ${link}
  fi
done

# Install elixir
pushd elixir
make -j2 && make install
popd

# Symlink elixir binaries
for binary in /home/vagrant/elixir/bin/*; do
  link=/usr/bin/$(basename ${binary})
  if [[ ! -e ${link} ]]; then
    ln -s -T ${binary} ${link}
  fi
done

# Guest additions
if [[ ! -e VBoxGuestAdditions_4.3.28.iso ]]; then
  wget http://dlc-cdn.sun.com/virtualbox/4.3.28/VBoxGuestAdditions_4.3.28.iso
fi
