FROM node:8

# Create app directory
WORKDIR /usr/src/app

# Bundle app source
COPY . .


# Instala Aplicativo Base de ReactJs
RUN npm install

EXPOSE 4000

CMD [ "npm", "start" ]

