FROM java:8
ARG base_dir
COPY . /app/
WORKDIR /app/${base_dir}

RUN ln -sf /dev/stdout /var/log/helloworld \
 && ln -sf /dev/stderr /var/log/helloworld
EXPOSE 8000

ENTRYPOINT ["./gradlew", "run"]