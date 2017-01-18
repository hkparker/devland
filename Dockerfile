FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
                    golang ruby2.3 \
                    tmux vim git \
		    curl wget docker-compose

RUN echo "root:developer" | chpasswd && \
    mkdir /src

RUN git config --global user.signingkey 7D57A017321531E5006E9B8F16B4B424EB576EE3 && \
    git config --global commit.gpgsign true

RUN useradd -ms /bin/bash developer && \
    chown developer:developer /src && \
    chown -R developer:developer /home/developer

USER developer

COPY bash_profile /home/developer/.bashrc
COPY tmux.conf /home/developer/.tmux.conf
COPY vimrc /home/developer/.vimrc

RUN mkdir -p /home/developer/.vim/autoload /home/developer/.vim/bundle && \
    curl -LSso /home/developer/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim && \
    git clone https://github.com/fatih/vim-go.git /home/developer/.vim/bundle/vim-go

WORKDIR /src

CMD ["/bin/bash"]
