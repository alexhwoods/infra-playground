FROM node:lts
WORKDIR /usr
COPY package.json ./
COPY tsconfig.json ./
COPY src ./src
RUN npm install
RUN npm run build

# stage 2
FROM node:lts
WORKDIR /usr
COPY package.json ./
RUN npm install --only=production

# copy dist folder from first stage
COPY --from=0 /usr/dist ./dist
EXPOSE 3003
# CMD ["ls", "-a"]
CMD ["npm", "run", "start:prod"]
