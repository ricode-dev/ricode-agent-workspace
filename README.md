# ricode-agent-workspace

Workspace berbasis `azka2606/ricode-workspace:latest` dengan Codex CLI,
Claude Code (native), dan Herdr. Semua tool dan konfigurasi SSH dari image dasar
tetap tersedia.

Build dari root repository ini:

```sh
docker build -t ricode-agent-workspace:latest .
```

Untuk menggunakan image dasar hasil build lokal, jalankan dari direktori induk
yang berisi kedua repository:

```sh
docker build -t ricode-workspace:local ./ricode-workspace
docker build --build-arg BASE_IMAGE=ricode-workspace:local -t ricode-agent-workspace:latest ./ricode-agent-workspace
```

`CODEX_VERSION` dan `CLAUDE_VERSION` dapat diberikan melalui `--build-arg`;
default keduanya `latest`. Herdr dipasang menggunakan installer resmi dengan
rilis terbaru saat build. Gunakan `--no-cache` untuk memperbarui ketiga CLI
ketika membangun ulang image.

Jalankan dengan SSH dan folder proyek:

```sh
docker run --rm -d --name ricode-agent-workspace \
  -p 2222:22 \
  -v "$(pwd):/workspace" \
  -v "$HOME/.ssh/authorized_keys:/root/.ssh/authorized_keys:ro" \
  ricode-agent-workspace:latest
```

Mount `authorized_keys` wajib karena entrypoint image dasar menjalankan SSH.
Hubungkan dengan `ssh -p 2222 root@localhost`, lalu jalankan `codex`, `claude`,
atau `herdr`. Lakukan login Codex dan Claude saat runtime.

Referensi instalasi: [Codex](https://github.com/openai/codex),
[Claude Code](https://code.claude.com/docs/en/setup),
[Herdr](https://github.com/herdrdev/herdr).
