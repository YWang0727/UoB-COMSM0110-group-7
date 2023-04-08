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

o Teamwork. How did you work together, what tools did you use? Did you have team roles? Reflection on how you worked together.

How did we work together?

We adopted a quite flexible and collaborative approach for game development. Generally, we have a weekly meeting in lab and on teams during holiday, to go through every aspect of the game development, we have one team member jotted down meeting notes each week and assign tasks to team member who is in charge for that in Jira. We posted our questions on teams to get instant feedback or to get support, or to fix bugs, and we committed our work to GitHub so everyone in team could see the changes and monitor our process to ensure our work hit the weekly schedule.

Here are some screenshots for how we collaborated as a team.
- Shared meeting notes
- Shared good ideas
- Shared public methods so others can make full use of the codes and avoid repetition
- Shared good software
- Helped to fix bugs
- Shared the change that might affect everyone’s development to keep everyone stay up to date

![Screenshot of proposing games to develops](./ReportMaterials/reportprocess/gamepropose.png)

![Screenshot of proposing games to develops](./ReportMaterials/reportprocess/meeting1.png)

Screenshot of meeting notes example -1

Screenshot of meeting notes example 2

Screenshot of sharing good software

Screenshot of sharing good ideas for generating maps for game

Screenshot of sharing changes

Screenshot of helping to fix bug

What software did we use?

Yes, we used various software introduced from the lecture.
• Teams: communication and meeting
• Jira: Assigned tasks and monitored our progress
• UML: Illustrated class diagrams
• Git & GitHub: for version control and committed staged work
• Photoshop: designed certain character in game
• Processing: wrote codes to build the game

Screenshot of how we assign tasks and monitored progress
Also please follow below link if you want to check how we collaborate in Jira.
https://uob-group7.atlassian.net/jira/software/projects/GP/boards/1

Did you have team roles?

Yes, we divided the game into 5 parts at beginning of the project, so everyone can focus on his or her own part. Please find below table as how we assign the team role.

| Task                                | To do by |
| ----------------------------------- | -------- |
| Rooms & Room Factory                | Ed       |
| Menu & Setting & BGM                | Arlo     |
| Player, Basic props, Collision etc… | Xiao     |
| Items & Items Factory               | Yue      |
| Enemy & Enemy Factory               | Cedric   |

Meanwhile, there are some works that we did not list above. We had different team member to do below:
• kept tracking and pushing the progress to ensure delivery of the game
• jotted down meeting note and shared recap
• Assigned tasks regarding meeting
• Acted as user or found new user to play game and asked for feedback
• Reached out to internet for game design (player, enemies, items, gems & rocks etc..), as we wanted it our game in an extraterrestrial world setting

## 8. Conclusion (10% ~500 words)

o Reflect on project as a whole. Lessons learned. Reflect on challenges. Future work.
