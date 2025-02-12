FROM rust:latest AS dev

WORKDIR /workspace

RUN rustup component add clippy rustfmt \
    && cargo install cargo-watch

COPY Cargo.toml ./
COPY src ./src

RUN cargo fetch

COPY make make

CMD ["cargo", "run"]
