# We just want archlinux with an aur helper already included
# Bump for rebuild on 10/04/2025 18:17 UTC +3
FROM archlinux:latest
RUN pacman -Syu --noconfirm
RUN pacman -S --needed git wget base-devel --noconfirm
RUN wget https://github.com/Jguer/yay/releases/download/v12.4.2/yay_12.4.2_x86_64.tar.gz
RUN tar -xf ./yay_12.4.2_x86_64.tar.gz
RUN mv ./yay_12.4.2_x86_64/yay /usr/bin/build-yay
# Root DANGEROUS BLAH BLAH BLAH xD
RUN useradd builduser -m
RUN passwd -d builduser
RUN printf 'builduser ALL=(ALL) ALL\n' | tee -a /etc/sudoers
RUN sudo -u builduser bash -c 'cd ~ && build-yay -S yay --noconfirm'
RUN rm -rfv /usr/bin/build-yay
RUN pacman-key --init
RUN pacman-key --populate
