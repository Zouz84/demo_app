# Appliation Demo_App, By Michael Hartl

## 1. Demo_App
Nous commençons donc par le modèle de données pour les utilisateurs de l'application, et nous ajouterons ensuite un modèle de données pour les micro-messages (microposts).:<br/>

### <a name="1.1" >1.1 Modéliser les utilisateurs</a>
Les utilisateurs de notre application Démo possèderont un identifiant unique appelé **id**, un **nom** affiché publiquement (de type chaine de caractères, string) et une **adresse mail** (de type également string) qui servira de double au nom d'utilisateur (username). <br/>
<br/>
<a name="users">![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/demo_user_model.png "User")</a>

### 1.2 Modéliser les micro-messages
un micro-message possède seulement un champ **id** (identifiant) et un champ **content** (contenu) pour le texte du micro-message (de type string).<br/> Demeure cependant quelques complications : nous voulons associer chaque micro-message à un utilisateur particulier ; nous accomplirons cela en enregistrant le **user_id** (identifiant d'utilisateur) de l'auteur du message.<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/micropost.png "microposts")

## 2. La ressource Utilisateur
Nous allons implémenter le **modèle de données** utilisateurs de la section [1.1](#1.1), en même temps qu'une interface web pour ce modèle. La combinaison des deux constituera une ressource utilisateurs (Users resource) qui nous permettra de penser les utilisateurs comme des objets (objects) qui peuvent être créés, consultés, actualisés et supprimés sur le web via le protocole HTTP (le traducteur tient à préciser qu'il s'inscrit en faux contre le fait de « penser les utilisateurs comme des objets »).

Comme promis dans l'introduction, notre ressource utilisateurs sera créée par un programme de génération d'échaffaudage, présent de façon standard dans chaque projet Rails. L'argument de la commande scaffold (échaffaudage) est la version singulier du nom de la ressource (dans ce cas : User), auquel on peut ajouter en paramètres optionnels les attributs du modèle de données :<br/>
`rails generate scaffold User nom:string email:string`
<br/>
En ajoutant **nom:string** et **email:string**, nous nous sommes arrangés pour que le **modèle de données _User_** prenne la forme définie dans [l'illustration Users](#users) (notez qu'il n'y a nul besoin d'inclure un paramètre pour l'attribut **id** : il est créé automatiquement par Rails.5)<br/>

Pour pouvoir utiliser l'*application Démo*, nous avons d'abord besoin de **migrer** (migrate) la base de données en utilisant Rake (Box 2.1):<br/>
```
rake db:migrate
==  CreateUsers: migrating ====================================================
-- create_table(:users)
   -> 0.0017s
==  CreateUsers: migrated (0.0018s) ===========================================
```
Cette procédure actualise simplement la base de données avec notre nouveau **modèle de données** utilisateurs (*users*).
On envoie un **rails s** et on se dirige sur **Localhost:3000**: "*Yay ! You're on Rails*"<br/>
### 2.1 Un tour de l'utilisateur
Le *scaffold* créé aussi déjà des *routes*. Si on tape ces URL après notre Localhost:3000, nous tomberons sur les pages présentées ci-dessous.<br/>

URL   |	Action   |	Page
---   |  ---   |  ---
/users   |	index |	Page listant les utilisateurs
/users/1 |	show  |	Page de l'utilisateur d'id 1
/users/new  |	new   |	Page pour créer un nouvel utilisateur
/users/1/edit  |	edit  |	Page d'édition de l'utilisateur d'id 1
<br/>

Nous commençons avec la page listant tous les utilisateurs de notre application, appelée **index** ; comme nous pouvons nous y attendre, il n'y a pour le moment aucun utilisateur. : [localhost:3000/users](http://localhost:3000/users)(ahah).
<br/>
De là, nous allons cliquer sur "**_New User_**".<br/>
Cela nous mène sur http://localhost:3000/users/new<br/>
<br/>
Nous pouvons y créer un nouvel utilisateur en entrant les *valeurs* du **nom** et de l'**email** dans les champs de texte correspondants et en cliquant ensuite sur le bouton de création (**_Create User_**).
Le résultat est la page d'utilisateur **show** (afficher). Le message vert de bienvenue est obtenu en utilisant la messagerie flash (qui sera abordée plus tard). Notez que l'URL est à présent **/users/1** ; comme vous pouvez vous en douter, le nombre **1** est l'identifiant de l'utilisateur (**l'attribut id**). Plus loin, cette page deviendra la page du profil de l'utilisateur.<br/>







