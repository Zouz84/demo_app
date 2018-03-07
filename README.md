# 1 Demo_App
Nous commençons donc par le modèle de données pour les utilisateurs de l'application, et nous ajouterons ensuite un modèle de données pour les micro-messages (microposts).:<br/>

## 1.1 Modéliser les utilisateurs
Les utilisateurs de notre application Démo possèderont un identifiant unique appelé **id**, un **nom** affiché publiquement (de type chaine de caractères, string) et une **adresse mail** (de type également string) qui servira de double au nom d'utilisateur (username). <br/>
<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/demo_user_model.png "User")

## 1.2 Modéliser les micro-messages
un micro-message possède seulement un champ **id** (identifiant) et un champ **content** (contenu) pour le texte du micro-message (de type string).<br/> Demeure cependant quelques complications : nous voulons associer chaque micro-message à un utilisateur particulier ; nous accomplirons cela en enregistrant le **user_id** (identifiant d'utilisateur) de l'auteur du message.<br/>




