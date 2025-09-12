# Dockerfile

# 1. Usa una imagen oficial de Ruby como base.
FROM ruby:3.4.5-slim

# 2. Define variables de entorno
ENV RAILS_LOG_TO_STDOUT=true \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_ENV=development \
    BUNDLE_FROZEN=1

# 3. Instala las dependencias del sistema operativo que Rails necesita
RUN apt-get update -qq && \
    apt-get install -y build-essential libsqlite3-dev nodejs curl gnupg libyaml-dev

# 4. Instala Yarn (método moderno)
RUN mkdir -p /etc/apt/keyrings
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/yarn.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# 5. Define el directorio de trabajo dentro del contenedor
WORKDIR /rails

# 6. Copia solo los archivos de gemas primero y las instala.
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 7. Copia el resto del código de la aplicación
COPY . .

# 8. Copia el script de entrada y dale permisos de ejecución
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# 9. Expone el puerto 3000
EXPOSE 3000

# 10. El comando por defecto
CMD ["rails", "server", "-b", "0.0.0.0"]