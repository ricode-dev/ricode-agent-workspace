ARG BASE_IMAGE=azka2606/ricode-workspace:latest
FROM ${BASE_IMAGE}

ARG CODEX_VERSION=latest
ARG CLAUDE_VERSION=latest

# Install outside NVM so the CLIs remain on PATH when switching Node versions.
RUN npm install --global --prefix /usr/local "@openai/codex@${CODEX_VERSION}" \
    && npm cache clean --force \
    && codex --version

# Use Claude Code's native installer; expose it on the inherited system PATH.
RUN curl -fsSL https://claude.ai/install.sh -o /tmp/claude-install.sh \
    && bash /tmp/claude-install.sh "${CLAUDE_VERSION}" \
    && ln -s /root/.local/bin/claude /usr/local/bin/claude \
    && rm /tmp/claude-install.sh \
    && claude --version

RUN curl -fsSL https://herdr.dev/install.sh -o /tmp/herdr-install.sh \
    && HERDR_INSTALL_DIR=/usr/local/bin sh /tmp/herdr-install.sh \
    && rm /tmp/herdr-install.sh \
    && herdr --version

# Inherit /workspace, SSH, Tini, ENTRYPOINT, and CMD from ricode-workspace.
