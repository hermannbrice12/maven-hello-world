# Utiliser une image Maven officielle pour construire le projet
FROM maven:3.8.4-openjdk-11 AS build

# Créer un répertoire pour l'application
WORKDIR /app

# Copier le fichier pom.xml et télécharger les dépendances Maven
COPY pom.xml /app/
RUN mvn dependency:go-offline

# Copier le reste des fichiers du projet
COPY src /app/src

# Construire le projet
RUN mvn package

# Utiliser une image Java pour exécuter l'application
FROM openjdk:11-jre-slim

# Créer un répertoire pour l'application
WORKDIR /app

# Copier l'artefact JAR généré depuis l'étape de build Maven
COPY --from=build /app/target/*.jar /app/app.jar

# Exposer le port sur lequel l'application va s'exécuter
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
