# Appliation Demo_App, By Michael Hartl

## 1. Demo_App
Nous commençons donc par le modèle de données pour les utilisateurs de l'application, et nous ajouterons ensuite un modèle de données pour les micro-messages (microposts).:<br/>

### <a name="1.1" >1.1 Modéliser les utilisateurs</a>
Les utilisateurs de notre application Démo possèderont un identifiant unique appelé **id**, un **nom** affiché publiquement (de type chaine de caractères, string) et une **adresse mail** (de type également string) qui servira de double au nom d'utilisateur (username). <br/>
<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/demo_user_model.png "User")

### 1.2 Modéliser les micro-messages
un micro-message possède seulement un champ **id** (identifiant) et un champ **content** (contenu) pour le texte du micro-message (de type string).<br/> Demeure cependant quelques complications : nous voulons associer chaque micro-message à un utilisateur particulier ; nous accomplirons cela en enregistrant le **user_id** (identifiant d'utilisateur) de l'auteur du message.<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/micropost.png "microposts")

## 2. La ressource Utilisateur
Nous allons implémenter le **modèle de données** utilisateurs de la section [1.1](#1.1), en même temps qu'une interface web pour ce modèle. La combinaison des deux constituera une ressource utilisateurs (Users resource) qui nous permettra de penser les utilisateurs comme des objets (objects) qui peuvent être créés, consultés, actualisés et supprimés sur le web via le protocole HTTP (le traducteur tient à préciser qu'il s'inscrit en faux contre le fait de « penser les utilisateurs comme des objets » :-).NdT).

Comme promis dans l'introduction, notre ressource utilisateurs sera créée par un programme de génération d'échaffaudage, présent de façon standard dans chaque projet Rails. L'argument de la commande scaffold (échaffaudage) est la version singulier du nom de la ressource (dans ce cas : User), auquel on peut ajouter en paramètres optionnels les attributs du modèle de données :4




