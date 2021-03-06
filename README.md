# 2. Application Demo_App, By Michael Hartl

## 2.1 Demo_App
Nous commençons donc par le modèle de données pour les utilisateurs de l'application, et nous ajouterons ensuite un modèle de données pour les micro-messages (microposts).:<br/>

### <a name="2.1.1" >2.1.1 Modéliser les utilisateurs</a>
Les utilisateurs de notre application Démo possèderont un identifiant unique appelé **id**, un **nom** affiché publiquement (de type chaine de caractères, string) et une **adresse mail** (de type également string) qui servira de double au nom d'utilisateur (username). <br/>
<br/>
<a name="users">![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/demo_user_model.png "User")</a>

### 2.1.2 Modéliser les micro-messages
un micro-message possède seulement un champ **id** (identifiant) et un champ **content** (contenu) pour le texte du micro-message (de type string).<br/> Demeure cependant quelques complications : nous voulons associer chaque micro-message à un utilisateur particulier ; nous accomplirons cela en enregistrant le **user_id** (identifiant d'utilisateur) de l'auteur du message.<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/micropost.png "microposts")

***

## <a name="2.2"> 2.2 La ressource Utilisateur</a>
Nous allons implémenter le **modèle de données** utilisateurs de la section [2.1.1](#2.1.1), en même temps qu'une interface web pour ce modèle. La combinaison des deux constituera une ressource utilisateurs (Users resource) qui nous permettra de penser les utilisateurs comme des objets (objects) qui peuvent être créés, consultés, actualisés et supprimés sur le web via le protocole HTTP (le traducteur tient à préciser qu'il s'inscrit en faux contre le fait de « penser les utilisateurs comme des objets »).

Comme promis dans l'introduction, notre ressource utilisateurs sera créée par un programme de génération d'échaffaudage, présent de façon standard dans chaque projet Rails. L'argument de la commande scaffold (échaffaudage) est la version singulier du nom de la ressource (dans ce cas : User), auquel on peut ajouter en paramètres optionnels les attributs du modèle de données :<br/>
`rails generate scaffold User nom:string email:string`
<br/>
En ajoutant **nom:string** et **email:string**, nous nous sommes arrangés pour que le **modèle de données _User_** prenne la forme définie dans [l'illustration Users](#users) (notez qu'il n'y a nul besoin d'inclure un paramètre pour l'attribut **id** : il est créé automatiquement par Rails.5)<br/>

Pour pouvoir utiliser l'*application Démo*, nous avons d'abord besoin de **migrer** (migrate) la base de données en utilisant Rake:<br/>
```
rake db:migrate
==  CreateUsers: migrating ====================================================
-- create_table(:users)
   -> 0.0017s
==  CreateUsers: migrated (0.0018s) ===========================================
```
Cette procédure actualise simplement la base de données avec notre nouveau **modèle de données** utilisateurs (*users*).
On envoie un **rails s** et on se dirige sur **Localhost:3000**: "*Yay ! You're on Rails*"<br/>
### 2.2.1 Un tour de l'utilisateur
Le *scaffold* créé aussi déjà des *routes*. Si on tape ces URL après notre Localhost:3000, nous tomberons sur les pages présentées ci-dessous.<br/>

URL   |	<a name="action">Action</a>   |	Page
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
### 2.2.2 MVC en action
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/mvc.png "MVC")
1. Le navigateur reçoit une requête pour l'URL **/users**
2. Rails route **/users** vers une [action index](#action) dans le contrôleur Users
3. L'[action index](#action) demande au *modèle User* de récupérer tous les utilisateurs (**User.all**)
4. Le modèle **User** tire *tous les utilisateurs* de la **base de données**
5. Le modèle **User** retourne au contrôleur la liste des utilisateurs
6. Le contrôleur place les utilisateurs dans la variable **@users**, variable qui est passée à la **vue index**
7. La vue utilise le code Ruby embarqué pour rendre la page au format HTML
8. Le contrôleur renvoie le code HTML au navigateur, qui affiche enfin la page.

* Controller User:

``` Ruby
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end
  ```
* Routes 
``` Ruby
Rails.application.routes.draw do
  resources :users
  end
 ```
### 2.2.3 Faiblesses de la ressource utilisateur
En gros le **Scaffold** c'est bien, mais: 

* __Pas de validation de données.__ Notre modèle utilisateur accepte aussi bien et sans broncher les noms vides ou les adresses mail invalides ;
* __Pas d'authentification.__ Nous n'avons aucune notion d'identification ou de déconnexion, et aucun moyen de prévenir un utilisateur quelconque d'exécuter une opération quelconque ;
* __Pas de tests.__ Techniquement, ça n'est pas tout à fait juste — l'échaffaudage inclut des tests rudimentaires — mais les test générés automatiquement son laids et rigides, et ils ne testent pas la validation des données, l'authentification ou autres besoins personnalisés ;
* __Pas de mise en page.__ Il n'y a pas de charte graphique, no css, no bootstrap. Rien.
* __Pas de compréhension réelle.__ Rien n'a été fait à la main, tout est automatisé alors on ne peut pas vraiment comprendre le fonctionnement de la machine.

***

## 2.3 La ressource micro message (Micropost)
Juste prendre conscience des similitudes entre cette ressource Micropost, et la ressource [utilisateurs](#2.2).
### 2.3.1 Un petit tour du micro message
``` Rails
$ rails generate scaffold Micropost content:string user_id:integer
      invoke  active_record
      create    db/migrate/20100615004429_create_microposts.rb
      create    app/models/micropost.rb
      invoke    test_unit
      create      test/unit/micropost_test.rb
      create      test/fixtures/microposts.yml
       route  resources :microposts
      invoke  scaffold_controller
      create    app/controllers/microposts_controller.rb
      invoke    erb
      create      app/views/microposts
      create      app/views/microposts/index.html.erb
      create      app/views/microposts/edit.html.erb
      create      app/views/microposts/show.html.erb
      create      app/views/microposts/new.html.erb
      create      app/views/microposts/_form.html.erb
      invoke    test_unit
      create      test/functional/microposts_controller_test.rb
      invoke    helper
      create      app/helpers/microposts_helper.rb
      invoke      test_unit
      create        test/unit/helpers/microposts_helper_test.rb
      invoke  stylesheets
   identical    public/stylesheets/scaffold.css
   ```
 Et on migre `rake db:migrate`
 <br/>
 Comme pour les utilisateurs, la règle des routages **resources :microposts** dirige les URLs des micro-messages vers les actions correspondantes dans le contrôleur Microposts, comme selon la table qui suit:
<br/>

Requête HTTP   |	URL   |	Action   |	Page ou Opération
---   |  ---   |  ---   |  ---
GET   |	/microposts |	index |	Page listant tous les micro-messages
GET   |	/microposts/1  |	show  |	Page affichant le micro-message d'id 1
GET   |	/microposts/new   |	new   |	Page créant une nouveau micro-message
POST  |	/microposts	create   |	Crée  | le nouveau micro-message
GET   |	/microposts/1/edit   |	edit  |	Page pour éditer le micro-message d'id 1
PUT   |	/microposts/1  |	update   |	Actualiser le micro-message d'id 1
DELETE   |	/microposts/1  |	destroy  |	Détruire le micro-message d'id 1
<br/>
Remarque: "Resources :microposts" s'inscrit directement dans le fichier `config/routes` grâce au scaffoldeur.
<br/> 
On remarque aussi que l'URL **www.localhost:3000/microposts** nous emmene bien vers l'Index des microposts.<br/>

### 2.3.2 Appliquer le micro aux micros messages
On va la jouer "à la twitter" (old school) en instaurant une limite max de 140 charactères...<br/>
On va ouvrir le fichier **`app/models/micropost.rb`** <br/>
Dans ce **model** ,on va ajouter une **validation**. Le model devra donc ressembler à ça:
```Ruby
class Micropost < ActiveRecord::Base
  validates :content, :length => { :maximum => 140 }
end
```
### 2.3.3 Un Utilisateur has_many micro messages
Autrement dit: **Les Associations**.<br/>
Dans le cas de notre modèle utilisateur, chaque utilisateur produit potentiellement plusieurs messages:<br/>
Notre **model** incluera donc cette ligne:<br/>
```Ruby
class User < ActiveRecord::Base
  has_many :microposts
end
```
Notre **model** microposts on ajoutera:<br/>
` belongs_to :user`
<br/>
<br/>
Voilà un schéma qui résume assez bien notre situation:<br/>
![alt text](https://github.com/Zouz84/demo_app/blob/master/app/assets/images/micro.png "relations")
<br/>
### 2.3.4 Testons (optionnel)
Nous pouvons examiner les implications de cette association en utilisant la *console*, qui est un outil utile pour interagir avec les applications Rails. Nous invoquons tout d'abord la console avec **rails console** en ligne de commande, puis récupérons le premier utilisateur dans la base de données en tapant **User.first** (en plaçant le résultat dans la variable **first_user**:
```ruby
~/demo_app $ rails c
Running via Spring preloader in process 8261
Loading development environment (Rails 5.1.5)
[1] pry(main)> first_user = User.first
  User Load (0.3ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<User:0x00000003b939a0
 id: 1,
 nom: "Nom",
 email: "email",
 created_at: Wed, 07 Mar 2018 10:17:43 UTC +00:00,
 updated_at: Wed, 07 Mar 2018 10:17:43 UTC +00:00>
[2] pry(main)> 
```
Maintenant on va essayer d'obtenir tous les **microposts** postés par l'user 1:
```ruby
[2] pry(main)> first_user.microposts
  Micropost Load (0.3ms)  SELECT "microposts".* FROM "microposts" WHERE "microposts"."user_id" = ?  [["user_id", 1]]
=> [#<Micropost:0x000000011e3c90
  id: 1,
  content: "Wesh alors, wesh alors !",
  user_id: 1,
  created_at: Sun, 11 Mar 2018 12:42:51 UTC +00:00,
  updated_at: Sun, 11 Mar 2018 12:42:51 UTC +00:00>]
[3] pry(main)> 

```
**INTERESSANT:** Si l'on n'avait pas ces associations, lorsque nous appelions User.first.microposts, la console nous aurait retourné:
```ruby
NoMethodError: undefined method `microposts' for #<User:0x00000003b939a0>
from /home/seize/.rvm/gems/ruby-2.3.4/gems/activemodel-5.1.5/lib/active_model/attribute_methods.rb:432:in `method_missing'
```

### 2.3.5 Hiérarchie des héritages
PArmi les détails qui ont leur importance, concentrons nous quelques instants sur les héritages. On aura remarqué que dans nos **model**, il y a déjà une ligne de code: `class User < ActiveRecord::Base` qui est inscrite lorsqu'on ouvre le fichier pour la premiere fois. Il s'agit en fait d'une hiérarchie, qui veut dire que ce **model** appartient (**<**) à **ActiveRecord::Base**. En gros, nos modèles vont hériter des méthodes, actions, etc, qui sont placés dans la **Base**.<br/>
De même pour tous les controlleurs, qui héritent de l'**ApplicationController**. En allant regarder de plus près notre *application_controller.rb*, on remarque que la première ligne de celui-ci est: `class ApplicationController < ActionController::Base` <br/>
Cela signifie donc que nos controlleurs héritent de l'**ApplicationController**, qui lui même hérite de l'**ActionController::Base**. Intéressant non? ;).<br/>
**Hiérarchie:** Puisque tous les contrôleurs Rails héritent de ApplicationController, les règles définies dans le contrôleur de l'application sont automatiquement appliquées à toutes les actions à l'intérieur de l'application. <br/>

### 2.3.6 Déployer l'app Démo
On y va, on est chaud, on publie tout sur le web:<br/>
```
$ git add .
$ git commit -a -m "Fin de l'application demo"
$ git push
```
Puisque on est chaud, qu'on a 100 app free sur heroku...:<br/>
```ruby
$ heroku create
$ git push heroku master
$ heroku rake db:migrate
```
Et bam, ça a fait des chocapics.<br/>
https://quiet-spire-25471.herokuapp.com/microposts
<br/>
<br/>
<br/>
<br/>
Tu veux le [Chapitre 3](https://github.com/Zouz84/Chapter3)? C'est par ici.
<br/>
<br/>
<br/>
**Force & Honneur**






