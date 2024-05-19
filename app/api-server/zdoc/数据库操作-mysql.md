<!--
 * @Date           : 2022-03-11 09:23:22
 * @FilePath       : /client-api-doc-server/zdoc/数据库表.md
 * @Description    : 
-->
## 数据库表

数据库表必须通过 egg 的 sequelize  实现 ，方便维护  
https://www.eggjs.org/zh-CN/tutorials/sequelize
https://sequelize.org/v6/

npm install --save egg-sequelize mysql2
npm install --save-dev sequelize-cli
npx sequelize init:config
npx sequelize init:migrations
npx sequelize migration:generate --name=init-users
升级数据库
npx sequelize db:migrate
如果有问题需要回滚，可以通过 `db:migrate:undo` 回退一个变更
npx sequelize db:migrate:undo
可以通过 `db:migrate:undo:all` 回退到初始状态
npx sequelize db:migrate:undo:all


npx sequelize seed:generate  --name init-user
npx sequelize  model:generate --name User --attributes firstName:string,lastName:string,email:string
npx sequelize  db:seed --seed 20220311040210-init-users.js

Sequelize CLI [Node: 10.21.0, CLI: 6.0.0, ORM: 6.1.0]

sequelize <command>

Commands:
  sequelize db:migrate                        Run pending migrations
  sequelize db:migrate:schema:timestamps:add  Update migration table to have timestamps
  sequelize db:migrate:status                 List the status of all migrations
  sequelize db:migrate:undo                   Reverts a migration
  sequelize db:migrate:undo:all               Revert all migrations ran
  sequelize db:seed                           Run specified seeder
  sequelize db:seed:undo                      Deletes data from the database
  sequelize db:seed:all                       Run every seeder
  sequelize db:seed:undo:all                  Deletes data from the database
  sequelize db:create                         Create database specified by configuration
  sequelize db:drop                           Drop database specified by configuration
  sequelize init                              Initializes project
  sequelize init:config                       Initializes configuration
  sequelize init:migrations                   Initializes migrations
  sequelize init:models                       Initializes models
  sequelize init:seeders                      Initializes seeders
  sequelize migration:generate                Generates a new migration file      [aliases: migration:create]
  sequelize model:generate                    Generates a model and its migration [aliases: model:create]
  sequelize seed:generate                     Generates a new seed file           [aliases: seed:create]


Options:
  --version  Show version number                                                  [boolean]
  --help     Show help                                                            [boolean]

