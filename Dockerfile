# Utilise une image Maven officielle pour construire le projet
FROM maven:3.8.7-openjdk-17-slim AS build


# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier pom.xml et les sources
COPY pom.xml .
COPY src ./src

# Construire le projet avec Maven
RUN mvn clean package -DskipTests

# Utiliser une image légère Java pour exécuter l'application
FROM openjdk:17-jdk-slim

# Créer un répertoire pour l'application
WORKDIR /app

# Copier l'artefact du projet Maven depuis l'étape précédente
COPY --from=build /app/target/*.jar /app/app.jar

# Exposer le port sur lequel l'application écoute
EXPOSE 8080

# Commande pour exécuter l'application
CMD ["java", "-jar", "/app/app.jar"]
