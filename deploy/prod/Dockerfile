FROM java:8
ARG base_dir
COPY . /app/
WORKDIR /app/${base_dir}

RUN ./gradlew build  


EXPOSE 8000

RUN ln -sf /dev/stdout /var/log/helloworld \
 && ln -sf /dev/stderr /var/log/helloworld

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-Dspring.profiles.active=pro","-jar","/app/devops-test-helloworld-app/build/libs/helloworld-0.0.1-SNAPSHOT.jar"]
