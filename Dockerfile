FROM hexpm/elixir:1.13.3-erlang-24.1.2-alpine-3.14.2 AS builder

# install build dependencies
RUN apk add --no-cache build-base

# set build env
ARG BUILD_DOCS=false
ENV MIX_ENV=prod

# install required packages
RUN mix local.rebar --force && \
    mix local.hex --force && \
    apk add git

# create build directory
RUN mkdir /app
WORKDIR /app

# install project dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# build the project
COPY . /app
RUN   mix release --overwrite

FROM alpine:3.13.3

# install runtime dependencies
RUN apk add --no-cache libstdc++ openssl ncurses-libs

# get project binarie from builder
WORKDIR /app
COPY --from=builder /app/_build/prod/rel/kosu .

# start the project
ENV MIX_ENV=prod
ENTRYPOINT ["/app/bin/kosu", "start"]