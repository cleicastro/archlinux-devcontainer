FROM archlinux:latest AS builder

RUN pacman -Syu --noconfirm base-devel

RUN	pacman -Syu --noconfirm git \
	&& mkdir -p /tmp/yay \
	&& useradd -mG wheel builder && passwd -d builder \
	&& chown -R builder:builder /tmp/yay \
	&& echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER builder

RUN	git clone https://aur.archlinux.org/yay.git /tmp/yay \
	&& cd /tmp/yay \
	&& makepkg -si --noconfirm \
	&& which yay

FROM archlinux:latest

ARG	REPO_OWNER
ARG	REPO_NAME
ARG	VERSION
ARG	GIT_COMMIT_SHA
ARG	BUILD_DATE

LABEL org.opencontainers.image.title="Arch Linux Development Container"
LABEL org.opencontainers.image.description="Archlinux Dev Container with AUR Support"
LABEL org.opencontainers.image.authors="Clei Castro <github.com/cleicastro>"
LABEL org.opencontainers.image.url="https://github.com/${REPO_OWNER}/${REPO_NAME}"
LABEL org.opencontainers.image.documentation="https://github.com/${REPO_OWNER}/${REPO_NAME}#readme"
LABEL org.opencontainers.image.source="https://github.com/${REPO_OWNER}/${REPO_NAME}"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.revision="${GIT_COMMIT_SHA}"
LABEL org.opencontainers.image.created="${BUILD_DATE}"

COPY --from=builder /usr/sbin/yay /usr/sbin/yay

RUN	yay -Syu --noconfirm sudo yq which unzip \
	&& curl -s https://raw.githubusercontent.com/cleicastro/dotfiles/main/vars/main.yml | yq '.yay_packages[]' | xargs yay -S --noconfirm \
	&& pacman -Sc --noconfirm \
	&& pacman -Syu --noconfirm aws-cli \
	&& pacman -Syu --noconfirm openssh \
	&& rm -rf /var/cache/pacman/pkg/* /tmp/*

RUN	sh -c "echo $(which zsh) >> /etc/shells" \
	&& chsh -s $(which zsh)

