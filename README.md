# COMSM0110 - Group 7 (2023)

## 1. Team

Team photo to be added

| Name             | Email                 |
| ---------------- | --------------------- |
| Xiao Yuan        | lq22159@bristol.ac.uk |
| Yue Wang         | pe22209@bristol.ac.uk |
| Arlo SUN         | xa22653@bristol.ac.uk |
| Ed Satterthwaite | es16268@bristol.ac.uk |
| Cedric Chen      | ud22762@bristol.ac.uk |

## 2. Introduction (5% ~250 words)

o Describe your game, what is based on, what makes it novel?

Game Background: The Earth's resources have been exhausted and the protagonist arrives on an alien planet to collect energy minerals. This planet is rich in mineral resources but is also full of danger. Our protagonist needs to survive under the pursuit of alien monsters and obtain as many resources as possible!
Game Type: Roguelike + Dungeon + Cave Exploration + Side-scrolling Shooter
Every map and its elements, including monsters, are randomly generated! Item drops are also completely random!

## 3. Requirements (15% ~750 words)

o Use case diagrams, user stories. Early stages design. Ideation process. How did you decide as a team what to develop?

Use case diagrams and user stories are kept in folder 'ReportMaterials' in gitub mainpage for your reference.

https://github.com/UoB-COMSM0110/2023-group-7/tree/main/ReportMaterials

For early stages, each member in the team brought up at least 2 desired games to develop . We discussed about a wide range of factors that which game we are going to build, for example, the possibilities of twists for each game, potential game users, a more original game , how it works (interactions between enermies and player) etc.

Finally we reached consencus of which game to develop as we have a rough ideas but more clear picture of our game . Initially we have a general aim for our game, for example, game background setting, space mission and exploring , various lanscapes (rooms), various enermies ,score system, items system etc .

## 4. Design (15% ~750 words)

o System architecture. Class diagrams, behavioural diagrams.

The game is based on MVC model to build. We worked and discussed as a team to decide what are the game mechanics , how the player might behave ( things that player does : exploring unknown areas , mining, using items to deal with various creatures etc.) , what should be displayed on the interface ( the way player communicate with game , HP system, score system , creatures AI etc.).

We illustrated them in class diagrams. Generally, we needed several basic classes to validate the game. Class for view & model & controller, class for random room , class for player, class for various creatures, class for items etc.

## 5. Implementation (15% ~750 words)

o Describe implementation of your game, in particular highlighting the three areas of challenge in developing your game.

We follow the general game developement process to implement our game : planning -- pre-production -- production -- testing -- pre-launch -- release.

We have weekly meeting to summarize what we have done for the project, discussed current difficulties during development for own part, clarified ambiguities, brought up possible new features for games and added them in our process.

During the implementation of our game, we found below 3 main challenges :

    1. Randomly generated map and elements:
        Loads of things (enemies , spikes ,items , player ) required to be generated randomly in the map, they should be arranged logically ( enemies or player can not be stuck in rocks, items can be mined by player , a possible entrace for player to escape , spikes damage player, spring allows player to jump high etc.)

    2. A lot of items and enemies to be design:
        A varieties of items and enermies had to be designed to make the game much more fun.
        different enemy has diffrent behaviors:Gunners shoot gun , ghost floats around, spiders move up and down while worms move left and right.
        different item has diffrent effect: Jetpack allows player to fly, potions allow player to boost its speed ,heart restore health, ropes allow player to climb down to escape , various weapons allow player to deal with various enemies .

    3. Enemies AI
        Different enemy has its own AI, when / how they move, how they interact with player, how they display when they are knocked back or killed , what damage they might have on player etc.

## 6. Evaluation (15% ~750 words)

o One qualitative evaluation (your choice)

o One quantitative evaluation (of your choice)

o Description of how code was tested.

## 7. Process (15% ~750 words)

o Teamwork. How did you work together, what tools did you use. Did you have team roles? Reflection on how you worked together.

We had our weekly meeting in lab and communicated in teams daily. we had our meeting note shared in teams.
We use UML to illustate our class diagrams , we update our progress in github . we use Jira to assign our tasks and track our progress. We use agile software development method to develop our game.

https://uob-group7.atlassian.net/jira/software/projects/GP/boards/1

Since we have a more clearer picture of our goal and we divided the game to 5 parts and allocate them to exactly 5 team members. Here you have an overview of our initial task allocation.

    Room & Room Factory - Ed

    Player, basic properties , collision Detection etc.. - Xiao

    Item & Item Factory - Yue

    Menu - Arlo

    Enemy & Enemy Factory - Cedric

## 8. Conclusion (10% ~500 words)

o Reflect on project as a whole. Lessons learned. Reflect on challenges. Future work.
