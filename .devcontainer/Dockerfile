FROM mcr.microsoft.com/devcontainers/base:ubuntu

# install pre-commit
RUN apt-get update \
    && apt-get -y install pre-commit xz-utils tar wget unzip fontconfig

# install typst
RUN wget -qO typst.tar.xz https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz
RUN tar xf typst.tar.xz --strip-components=1 -C /usr/local/bin typst-x86_64-unknown-linux-musl/typst

# install necessary fonts
RUN wget https://mirrors.ctan.org/fonts/fontawesome6.zip &&\
    unzip fontawesome6.zip &&\
    mkdir -p /usr/share/fonts/truetype/fontawesome6 &&\
    cp fontawesome6/opentype/* /usr/share/fonts/truetype/fontawesome6/ &&\
    wget https://mirrors.ctan.org/fonts/roboto.zip &&\
    unzip roboto.zip &&\
    mkdir -p /usr/share/fonts/truetype/roboto &&\
    cp roboto/opentype/* /usr/share/fonts/truetype/roboto/ &&\
    rm /usr/share/fonts/truetype/roboto/*Condensed* &&\
    wget https://mirrors.ctan.org/fonts/xcharter.zip &&\
    unzip xcharter.zip &&\
    mkdir -p /usr/share/fonts/truetype/xcharter &&\
    cp xcharter/opentype/* /usr/share/fonts/truetype/xcharter &&\
    wget https://mirrors.ctan.org/fonts/noto-emoji.zip &&\
    unzip noto-emoji.zip &&\
    mkdir -p /usr/share/fonts/truetype/noto-emoji &&\
    cp noto-emoji/*.ttf /usr/share/fonts/truetype/noto-emoji &&\
    wget https://software.sil.org/downloads/r/gentium/Gentium-7.000.zip &&\
    unzip Gentium-7.000.zip &&\
    mkdir -p /usr/share/fonts/truetype/gentium &&\
    cp Gentium-7.000/*.ttf /usr/share/fonts/truetype/gentium &&\
    wget https://raw.githubusercontent.com/Linguistx/fonts/master/NotoSerif-unhinted.zip &&\
    unzip NotoSerif-unhinted.zip &&\
    mkdir -p /usr/share/fonts/truetype/noto-serief &&\
    cp NotoSerif-unhinted/*.ttf /usr/share/fonts/truetype/noto-serief &&\
    fc-cache -fv
