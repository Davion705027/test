# 安装egg

我们推荐直接使用脚手架，只需几条简单指令，即可快速生成项目（`npm >=6.1.0`）:

```
mkdir egg-example && cd egg-example
npm init egg --type=simple
npm i
```

启动项目:

```
npm run dev
open http://localhost:7001
```





# 目录结构

```
egg-project
├── package.json
├── app.js (可选)
├── agent.js (可选)
├── app（-----------核心------------）
|   ├── router.js（路由）
│   ├── controller（控制器）
│   |   └── home.js
│   ├── service (模型)
│   |   └── user.js
│   ├── middleware (中间件)
│   |   └── response_time.js
│   ├── schedule (可选)
│   |   └── my_task.js
│   ├── public (静态资源)
│   |   └── reset.css
│   ├── view (模板视图)
│   |   └── home.tpl
│   └── extend (扩展)
│       ├── helper.js (可选)
│       ├── request.js (可选)
│       ├── response.js (可选)
│       ├── context.js (可选)
│       ├── application.js (可选)
│       └── agent.js (可选)
├── config
|   ├── plugin.js
|   ├── config.default.js
│   ├── config.prod.js
|   ├── config.test.js (可选)
|   ├── config.local.js (可选)
|   └── config.unittest.js (可选)
└── test
    ├── middleware
    |   └── response_time.test.js
    └── controller
        └── home.test.js
```



# 路由相关

## 1. get传值

```js
// router.js
router.get('/admin/:id', controller.admin.index);

// controller
async index(ctx) {
    // 获取路由get传值参数（路由:id）
    ctx.params;
    // 获取url的问号get传值参数
    ctx.query;
}
```

## 2. 4种配置方法

```js
router.verb('path-match', app.controller.action);
router.verb('router-name', 'path-match', app.controller.action);// 第一个参数可以给name
router.verb('path-match', middleware1, ..., middlewareN, app.controller.action);
router.verb('router-name', 'path-match', middleware1, ..., middlewareN, app.controller.action);
```



# 重定向

## 1. ctx

```js
async index() {
    this.ctx.status = 301; // 把重定向改为301
    this.ctx.redirect('/admin/add'); // 默认临时重定向 302
}
```

## 2. 路由重定向

```js
app.router.redirect('/', '/home/index', 302);
```

## 3.路由分组

```js
// app/router.js
module.exports = app => {
  require('./router/news')(app);
  require('./router/admin')(app);
};

// app/router/news.js
module.exports = app => {
  app.router.get('/news/list', app.controller.news.list);
  app.router.get('/news/detail', app.controller.news.detail);
};

// app/router/admin.js
module.exports = app => {
  app.router.get('/admin/user', app.controller.admin.user);
  app.router.get('/admin/log', app.controller.admin.log);
};
```



# 控制器

## 自定义 Controller 基类

```js
// app/core/base_controller.js
const { Controller } = require('egg');
class BaseController extends Controller {
  get user() {
    return this.ctx.session.user;
  }

  success(data) {
    this.ctx.body = {
      success: true,
      data,
    };
  }

  notFound(msg) {
    msg = msg || 'not found';
    this.ctx.throw(404, msg);
  }
}
module.exports = BaseController;
```



此时在编写应用的 Controller 时，可以继承 BaseController，直接使用基类上的方法：

```js
//app/controller/post.js
const Controller = require('../core/base_controller');
class PostController extends Controller {
  async list() {
    const posts = await this.service.listByUser(this.user);
    this.success(posts);
  }
}
```





# 模板引擎

## 1. 安装和使用ejs

### （1）安装：

```
npm i egg-view-ejs --save
```

### （2）配置：/config

config/config.default.js

```js
module.exports = appInfo => {
    ...
    
    config.view = {
        mapping: {
            '.html': 'ejs',
        },
    };
    
	...
};
```
config/plugin.js

```js
module.exports = {
	// 配置ejs
    ejs: {
        enable: true,
        package: 'egg-view-ejs',
    }

};
```

### （3）使用

app/controller

```js
 async index() {
     const { ctx } = this;
     // 渲染变量
     let msg = "测试内容";
     let list = [1, 2, 3, 4, 5, 6];
     // 渲染模板（render需要加await）
     await ctx.render('index', {
         msg,
         list
     });
 }
```

app/view/index.html

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>

<body>
    <!--渲染变量-->
    <%=msg%>
        <ul>
            <% for(var i=0; i < list.length; i++){ %>
                <li>
                    <%=list[i]%>
                </li>
                <% } %>
        </ul>
		<!--加载 app/public 下的资源文件-->
        <img src="/public/images/find.png">
</body>

</html>
```



# 服务（模型）

控制器调用 `home` 模型的 `ceshi` 方法

```js
await this.service.home.ceshi();
```

模型之间相互调用（同上）



# 模型和数据库

## 配置和创建迁移文件

### 配置



1. 安装并配置[egg-sequelize](https://github.com/eggjs/egg-sequelize)插件（它会辅助我们将定义好的 Model 对象加载到 app 和 ctx 上）和[mysql2](https://github.com/sidorares/node-mysql2)模块：

```js
npm install --save egg-sequelize mysql2
```

2. 在`config/plugin.js`中引入 egg-sequelize 插件

```
exports.sequelize = {
  enable: true,
  package: 'egg-sequelize',
};
```

3. 在`config/config.default.js`

```js
config.sequelize = {
    dialect:  'mysql',
    host:  '127.0.0.1',
    username: 'root',
    password:  'root',
    port:  3306,
    database:  'friends',
    // 中国时区
    timezone:  '+08:00',
    define: {
        // 取消数据表名复数
        freezeTableName: true,
        // 自动写入时间戳 created_at updated_at
        timestamps: true,
        // 字段生成软删除时间戳 deleted_at
        paranoid: true,
        createdAt: 'created_at',
        updatedAt: 'updated_at',
        deletedAt: 'deleted_at',
        // 所有驼峰命名格式化
        underscored: true
    }
};
```

4. sequelize 提供了[sequelize-cli](https://github.com/sequelize/cli)工具来实现[Migrations](http://docs.sequelizejs.com/manual/tutorial/migrations.html)，我们也可以在 egg 项目中引入 sequelize-cli。

```js
npm install --save-dev sequelize-cli
```

5.  egg 项目中，我们希望将所有数据库 Migrations 相关的内容都放在`database`目录下，所以我们在项目根目录下新建一个`.sequelizerc`配置文件：

```js
'use strict';

const path = require('path');

module.exports = {
  config: path.join(__dirname, 'database/config.json'),
  'migrations-path': path.join(__dirname, 'database/migrations'),
  'seeders-path': path.join(__dirname, 'database/seeders'),
  'models-path': path.join(__dirname, 'app/model'),
};
```

6. 初始化 Migrations 配置文件和目录

```js
npx sequelize init:config
npx sequelize init:migrations
// npx sequelize init:models
```

7. 行完后会生成`database/config.json`文件和`database/migrations`目录，我们修改一下`database/config.json`中的内容，将其改成我们项目中使用的数据库配置：

```json
{
  "development": {
    "username": "root",
    "password": null,
    "database": "test",
    "host": "127.0.0.1",
    "dialect": "mysql",
    "timezone": "+08:00"
  }
}
```

8. 创建数据库

```js
npx sequelize db:create
```

### 创建数据迁移表

```js
npx sequelize migration:generate --name=init-users
```

1.执行完命令后，会在database / migrations / 目录下生成数据表迁移文件，然后定义

```js
'use strict';

module.exports = {
    up: async (queryInterface, Sequelize) => {
        const { INTEGER, STRING, DATE, ENUM } = Sequelize;
        // 创建表
        await queryInterface.createTable('users', {
            id: { type: INTEGER(20).UNSIGNED, primaryKey: true, autoIncrement: true },
            username: { type: STRING(30), allowNull: false, defaultValue: '', comment: '用户名称', unique: true},
            email: { type: STRING(160), allowNull: false,  defaultValue: '', comment: '用户邮箱', unique: true },
            password: { type: STRING(200), allowNull: false, defaultValue: '' },
            avatar_url: { type: STRING(200), allowNull: true, defaultValue: '' },
            mobile: { type: STRING(20), allowNull: false, defaultValue: '', comment: '用户手机', unique: true },
            prifix: { type: STRING(32), allowNull: false, defaultValue: '' },
            abstract: { type: STRING(255), allowNull: true, defaultValue: '' },
            role_id:{
                type: INTEGER,
                //  定义外键（重要）
                references: {
                    model: 'users', // 对应表名称（数据表名称）
                    key: 'id' // 对应表的主键
                },
                onUpdate: 'restrict', // 更新时操作
                onDelete: 'cascade'  // 删除时操作
            },
            gender: { type: ENUM, values: ['男','女','保密'], allowNull: true, defaultValue: '男', comment: '用户性别'},
            created_at: DATE,
            updated_at: DATE
        }, { engine: 'MYISAM' });
        // 添加索引
        queryInterface.addIndex('users', ['gender']);
        // 添加唯一索引
        queryInterface.addIndex('users', {
            name: "name", // 索引名称
            unique: true, // 唯一索引
            fields: ['name'] // 索引对应字段
        });
    },

    down: async queryInterface => {
        await queryInterface.dropTable('users')
    }
};
```

- 执行 migrate 进行数据库变更

```php
# 升级数据库
npx sequelize db:migrate
# 如果有问题需要回滚，可以通过 `db:migrate:undo` 回退一个变更
# npx sequelize db:migrate:undo
# 可以通过 `db:migrate:undo:all` 回退到初始状态
# npx sequelize db:migrate:undo:all
```



### 已创建新增字段

1.创建迁移文件：

```
npx sequelize migration:generate --name=user-addcolumn
```

2.执行完命令后，会在database / migrations / 目录下生成数据表迁移文件，然后定义

```js
'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
          queryInterface.addColumn('user', 'role_id', {
              type: Sequelize.INTEGER
          }, { transaction: t }),
          queryInterface.addColumn('user', 'ceshi', {
              type: Sequelize.STRING,
          }, { transaction: t })
      ])
    })
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
          queryInterface.removeColumn('user', 'role_id', { transaction: t }),
          queryInterface.removeColumn('user', 'ceshi', { transaction: t })
      ])
    })
  }
};

```



3.执行 migrate 进行数据库变更

```
npx sequelize db:migrate
```



### 创建模型

```js
// app / model / user.js

'use strict';
module.exports = app => {
  const { STRING, INTEGER, DATE } = app.Sequelize;
  // 配置（重要：一定要配置详细，一定要！！！）
  const User = app.model.define('user', {
    id: { type: INTEGER, primaryKey: true, autoIncrement: true },
    name: STRING(30),
    age: INTEGER,
    created_at: DATE,
    updated_at: DATE,
  },{
    timestamps: true, // 是否自动写入时间戳
    tableName: 'users', // 自定义数据表名称
 });

  return User;
};
```

这个 Model 就可以在 Controller 和 Service 中通过 `app.model.User` 或者 `ctx.model.User` 访问到了，例如我们编写 `app/controller/users.js`：

```js
// app/controller/users.js
const Controller = require('egg').Controller;

function toInt(str) {
  if (typeof str === 'number') return str;
  if (!str) return str;
  return parseInt(str, 10) || 0;
}

class UserController extends Controller {
  async index() {
    const ctx = this.ctx;
    const query = { limit: toInt(ctx.query.limit), offset: toInt(ctx.query.offset) };
    ctx.body = await ctx.model.User.findAll(query);
  }

  async show() {
    const ctx = this.ctx;
    ctx.body = await ctx.model.User.findByPk(toInt(ctx.params.id));
  }

  async create() {
    const ctx = this.ctx;
    const { name, age } = ctx.request.body;
    const user = await ctx.model.User.create({ name, age });
    ctx.status = 201;
    ctx.body = user;
  }

  async update() {
    const ctx = this.ctx;
    const id = toInt(ctx.params.id);
    const user = await ctx.model.User.findByPk(id);
    if (!user) {
      ctx.status = 404;
      return;
    }

    const { name, age } = ctx.request.body;
    await user.update({ name, age });
    ctx.body = user;
  }

  async destroy() {
    const ctx = this.ctx;
    const id = toInt(ctx.params.id);
    const user = await ctx.model.User.findByPk(id);
    if (!user) {
      ctx.status = 404;
      return;
    }

    await user.destroy();
    ctx.status = 200;
  }
}

module.exports = UserController;
```

最后我们将这个 controller 挂载到路由上：

```js
// app/router.js
module.exports = app => {
  const { router, controller } = app;
  router.resources('users', '/users', controller.users);
};
```

针对 `users` 表的 CURD 操作的接口就开发完了

### 模型其他参数

```js
// 配置（重要）
  const User = app.model.define('user', {
    id: { type: INTEGER, primaryKey: true, autoIncrement: true },
    name: STRING(30),
    age: INTEGER,
    created_at: DATE,
    updated_at: DATE,
  },{
    // 自定义表名
      'freezeTableName': true,
      'tableName': 'xyz_users',

      // 是否需要增加createdAt、updatedAt、deletedAt字段
      'timestamps': true,

      // 不需要createdAt字段
      'createdAt': false,

      // 将updatedAt字段改个名
      'updatedAt': 'utime',

      // 将deletedAt字段改名
      // 同时需要设置paranoid为true（此种模式下，删除数据时不会进行物理删除，而是设置deletedAt为当前时间
      'deletedAt': 'dtime',
      'paranoid': true,
      
 });
```



### sequelize 命令

| 命令                          | 含义                   |
| :---------------------------- | :--------------------- |
| sequelize db:migrate          | 运行迁移文件           |
| sequelize db:migrate:status   | 列出所有迁移的状态     |
| sequelize db:migrate:undo     | 隔离数据库：迁移：撤消 |
| sequelize db:migrate:undo:all | 还原所有运行的迁移     |
| sequelize db:create           | 创建由配置指定的数据库 |
| sequelize db:drop             | 删除由配置指定的数据库 |

### 外键约束（重要）

```js
// 迁移文件
queryInterface.addConstraint('tableName', ['user_id'], {
    type: 'foreign key',
    name: 'user_id',
    references: { //Required field
        table: 'users',
        field: 'id'
    },
    onDelete: 'cascade',
    onUpdate: 'cascade'
});
```



### 创建第一个种子

假设我们希望在默认情况下将一些数据插入到几个表中. 如果我们跟进前面的例子,我们可以考虑为 `User` 表创建演示用户.

要管理所有数据迁移,你可以使用 `seeders`. 种子文件是数据的一些变化,可用于使用样本数据或测试数据填充数据库表.

让我们创建一个种子文件,它会将一个演示用户添加到我们的 `User` 表中.

```
npx sequelize seed:generate --name demo-user
```

这个命令将会在 `seeders` 文件夹中创建一个种子文件.文件名看起来像是 `XXXXXXXXXXXXXX-demo-user.js`,它遵循相同的 `up/down` 语义,如迁移文件.

现在我们应该编辑这个文件,将演示用户插入`User`表.

```js
'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.bulkInsert('Users', [{
        firstName: 'John',
        lastName: 'Doe',
        email: 'demo@demo.com',
        createdAt: new Date(),
        updatedAt: new Date()
      }], {});
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('Users', null, {});
  }
};
```

### 运行种子

在上一步中,你创建了一个种子文件. 但它还没有保存到数据库. 为此,我们需要运行一个简单的命令.

```
npx sequelize db:seed:all
```

这将执行该种子文件,你将有一个演示用户插入 `User` 表.

**注意:** _ `seeders` 执行不会存储在任何使用 `SequelizeMeta` 表的迁移的地方. 如果你想覆盖这个,请阅读 `存储` 部分_

### 撤销种子

Seeders 如果使用了任何存储那么就可以被撤消. 有两个可用的命令

如果你想撤消最近的种子

```
npx sequelize db:seed:undo
```

如果你想撤消特定的种子

```
npx sequelize db:seed:undo --seed name-of-seed-as-in-data
```

如果你想撤消所有的种子

```
npx sequelize db:seed:undo:all
```



## 关联操作

### 一对一

模型层：

```js
// 一个用户对应一个用户资料

// app/model/user.js
module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;

    const User = app.model.define('user', {
        id: { type: INTEGER, primaryKey: true, autoIncrement: true },
        name: STRING(30),
        age: INTEGER,
        created_at: DATE,
        updated_at: DATE,
    });
    // 关联关系
    User.associate = function(models) {
        // 关联用户资料 一对一
        User.hasOne(app.model.Userinfo);
    }
    return User;
};


// app/model/userinfo.js
module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;
    const userinfo = app.model.define('userinfo', {
        nickname: STRING,
        user_id: INTEGER
    }, {});
    // 关联用户表
    userinfo.associate = function(models) {
        app.model.Userinfo.belongsTo(app.model.User);
    };
    return userinfo;
};
```

控制器调用：

```js
// app/controller/users.js
// 显示单条
async show() {
    // 根据主键查询 查询一条用findOne
    this.ctx.body = await this.ctx.model.User.findOne({
        // 主表查询字段限制
        attributes:['name'],
        // 关联查询
        include: [{
            // 需要查询的模型
            model: this.app.model.Userinfo,
            // 副表查询的字段
            attributes: ['nickname']
        }],
        // 主表条件
        where: {
            id: 3
        }
    });
}
```

### 一对多

```js
class City extends Model {}
City.init({ countryCode: Sequelize.STRING }, { sequelize, modelName: 'city' });
class Country extends Model {}
Country.init({ isoCode: Sequelize.STRING }, { sequelize, modelName: 'country' });

// 在这里,我们可以根据国家代码连接国家和城市
Country.hasMany(City, {foreignKey: 'countryCode', sourceKey: 'isoCode'});
City.belongsTo(Country, {foreignKey: 'countryCode', targetKey: 'isoCode'});
```

### 多对多

```js
User.belongsToMany(Project, { as: 'Tasks', through: 'worker_tasks', foreignKey: 'userId' })
Project.belongsToMany(User, { as: 'Workers', through: 'worker_tasks', foreignKey: 'projectId' })
```



### 关联常用操作

```js
// 获取关联模型对象，n对一不需要加s
let userinfo = await user.getUserinfo();
// n对多需要加s
await user.getPosts({
    attributes: ['title'],
    where: {
        id: 3
    }
});
// 关联操作
// 1：用户创建文章（一对多）
await this.ctx.model.Post.create({
    title: "第一篇文章",
    user_id: user.id
});

// 2.获取当前用户所有文章
await user.getPosts();
await user.getPosts({
    attributes: ['id'],
    where:{
        title:"测试"
    }
});

// 3：用户删除文章（一对多）
// (1) 获取当前用户的所有文章
let posts = await user.getPosts({
    attributes: ['id']
});
posts = posts.map(v => v.id);
await this.ctx.model.Post.destroy({
    where: {
        id: posts
    }
});

// 场景三：用户关注话题（多对多）
await this.ctx.model.TopicUser.bulkCreate([{
    user_id: user.id,
    topic_id: 1
},{
    user_id: user.id,
    topic_id: 2
}]);

// 用户关注话题（多对多）
await this.ctx.model.TopicUser.destroy({
    where: {
        user_id: user.id,
        topic_id: [1, 2]
    }
});
```





## 获取器和修改器

模型层

```js
// app/model/user.js

module.exports = app => {
    const { STRING, INTEGER, DATE } = app.Sequelize;

    const User = app.model.define('user', {
        id: { type: INTEGER, primaryKey: true, autoIncrement: true },
        name: {
            type: STRING(30),
            // 单独字段的getter，查询时都会调用
            // this.getDataValue('name') 获取原始值
            get() {
                const age = this.getDataValue('age');
                return this.getDataValue('name') + '年龄：' + age;
            }
        },
        age: {
            type: INTEGER,
            // 单独字段的setter，新增和更新时调用
            // this.setDataValue('name') 设置原始值
            set(val) {
                this.setDataValue('age', val * 10);
            }
        },
        created_at: DATE,
        updated_at: DATE,
    });

    // 关联用户资料
    User.associate = function(models) {
        app.model.User.hasOne(app.model.Userinfo);
    }
    return User;
};
```

控制器层

```js
async show() {
    // 根据主键查询
    let user = await this.ctx.model.User.findOne({
        where: {
            id: 3
        }
    });
    // 获取原始值 user.getDataValue('name')
    this.ctx.body = user.getDataValue('name')
}
```



## 模型钩子

模型层

```js
module.exports = app => {
   
    ...

    // 钩子
    // 查询前
    User.beforeFind((user, option) => {
        console.log('查询前');
    });
    // 查询后
    User.afterFind((user, option) => {
        console.log('查询后');
    });
    // 新增前
    User.beforeCreate((user, option) => {
        console.log('新增前');
    });
    // 新增后
    User.afterCreate((user, option) => {
        console.log('新增后');
    });
    // 修改前
    User.beforeUpdate((user, option) => {
        console.log('修改前');
    });
    // 修改后
    User.afterUpdate((user, option) => {
        console.log('修改后'); // 真正修改才会触发，数据相同不会触发
    });
    // 删除前
    User.beforeDestroy((user, option) => {
        console.log('删除前');
    });
    // 删除后
    User.afterDestroy((user, option) => {
        console.log('删除后');
    });

    return User;
};
```



## 查询

### 主键查询

```js
Model.findByPk(1)
```

### 查找不存在则创建

方法 `findOrCreate` 可用于检查数据库中是否已存在某个元素. 如果是这种情况,则该方法将生成相应的实例. 如果元素不存在,将会被创建.

如果是这种情况,则该方法将导致相应的实例. 如果元素不存在,将会被创建.

假设我们有一个空的数据库,一个 `User` 模型有一个 `username` 和 `job`.

```js
User
  .findOrCreate({
        where: {
            username: 'sdepold'
        }, 
        defaults: {
            job: 'Technical Lead JavaScript'
        }
    })
  . then(([user, created]) => {
    console.log(user.get({
      plain: true
    }))
    console.log(created)

    /*
    findOrCreate 返回一个包含已找到或创建的对象的数组,找到或创建的对象和一个布尔值,如果创建一个新对象将为true,否则为false,像这样:

    [ {
        username: 'sdepold',
        job: 'Technical Lead JavaScript',
        id: 1,
        createdAt: Fri Mar 22 2013 21: 28: 34 GMT + 0100(CET),
        updatedAt: Fri Mar 22 2013 21: 28: 34 GMT + 0100(CET)
      },
      true ]

在上面的例子中,第三行的数组将分成2部分,并将它们作为参数传递给回调函数,在这种情况下将它们视为 "user" 和 "created" .(所以“user”将是返回数组的索引0的对象,并且 "created" 将等于 "true".)
    */
  })
```

代码创建了一个新的实例. 所以当我们已经有一个实例了 ...

```js
User.create({ username: 'fnord', job: 'omnomnom' })
  .then(() => User.findOrCreate({
        where: {
            username: 'fnord'
        }, 
        defaults: {
            job: 'something else'
        }
    }))
  .then(([user, created]) => {
    console.log(user.get({
      plain: true
    }))
    console.log(created)

    /*
    在这个例子中,findOrCreate 返回一个如下的数组:
    [ {
        username: 'fnord',
        job: 'omnomnom',
        id: 2,
        createdAt: Fri Mar 22 2013 21: 28: 34 GMT + 0100(CET),
        updatedAt: Fri Mar 22 2013 21: 28: 34 GMT + 0100(CET)
      },
      false
    ]
    由findOrCreate返回的数组通过第三行的数组扩展为两部分,并且这些部分将作为2个参数传递给回调函数,在这种情况下将其视为 "user" 和 "created" .(所以“user”将是返回数组的索引0的对象,并且 "created" 将等于 "false".)
    */
  })
```

...现有条目将不会更改. 看到第二个用户的 "job",并且实际上创建操作是假的.



### 查找并计数

`findAndCountAll` - 在数据库中搜索多个元素,返回数据和总计数

这是一个方便的方法,它结合了 `findAll` 和 `count`(见下文),当处理与分页相关的查询时,这是有用的,你想用 `limit` 和 `offset` 检索数据,但也需要知道总数与查询匹配的记录数:

处理程序成功将始终接收具有两个属性的对象:

- `count` - 一个整数,总数记录匹配where语句和关联的其它过滤器
- `rows` - 一个数组对象,记录在limit和offset范围内匹配where语句和关联的其它过滤器,

```js
Project
  .findAndCountAll({
     where: {
        title: {
          [Op.like]: 'foo%'
        }
     },
     offset: 10,
     limit: 2
  })
  .then(result => {
    console.log(result.count);
    console.log(result.rows);
  });
```

它支持 include. 只有标记为 `required` 的 include 将被添加到计数部分:

假设你想查找附有个人资料的所有用户:

```js
User.findAndCountAll({
  include: [
     { model: Profile, required: true}
  ],
  limit: 3
});
```

因为 `Profile` 的 include 有 `required` 设置,这将导致内部连接,并且只有具有 profile 的用户将被计数. 如果我们从 include 中删除`required`,那么有和没有 profile 的用户都将被计数. 在include中添加一个 `where` 语句会自动使它成为 required:

```js
User.findAndCountAll({
  include: [
     { model: Profile, where: { active: true }}
  ],
  limit: 3
});
```

上面的查询只会对具有 active profile 的用户进行计数,因为在将 where 语句添加到 include 时,`required` 被隐式设置为 true.

传递给 `findAndCountAll` 的 options 对象与 `findAll` 相同(如下所述).

### 查询多个（常用）

```js
// 找到多个条目
Project.findAll().then(projects => {
  // projects 将是所有 Project 实例的数组
})

// 搜索特定属性 - 使用哈希
Project.findAll({ where: { name: 'A Project' } }).then(projects => {
  // projects将是一个具有指定 name 的 Project 实例数组
})

// 在特定范围内进行搜索
Project.findAll({ where: { id: [1,2,3] } }).then(projects => {
  // projects将是一系列具有 id 1,2 或 3 的项目
  // 这实际上是在做一个 IN 查询
})

Project.findAll({
  where: {
    id: {
      [Op.and]: {a: 5},           // 且 (a = 5)
      [Op.or]: [{a: 5}, {a: 6}],  // (a = 5 或 a = 6)
      [Op.gt]: 6,                // id > 6
      [Op.gte]: 6,               // id >= 6
      [Op.lt]: 10,               // id < 10
      [Op.lte]: 10,              // id <= 10
      [Op.ne]: 20,               // id != 20
      [Op.between]: [6, 10],     // 在 6 和 10 之间
      [Op.notBetween]: [11, 15], // 不在 11 和 15 之间
      [Op.in]: [1, 2],           // 在 [1, 2] 之中
      [Op.notIn]: [1, 2],        // 不在 [1, 2] 之中
      [Op.like]: '%hat',         // 包含 '%hat'
      [Op.notLike]: '%hat',       // 不包含 '%hat'
      [Op.iLike]: '%hat',         // 包含 '%hat' (不区分大小写)  (仅限 PG)
      [Op.notILike]: '%hat',      // 不包含 '%hat'  (仅限 PG)
      [Op.overlap]: [1, 2],       // && [1, 2] (PG数组重叠运算符)
      [Op.contains]: [1, 2],      // @> [1, 2] (PG数组包含运算符)
      [Op.contained]: [1, 2],     // <@ [1, 2] (PG数组包含于运算符)
      [Op.any]: [2,3],            // 任何数组[2, 3]::INTEGER (仅限 PG)
    },
    status: {
      [Op.not]: false,           // status 不为 FALSE
    }
  }
})
```



### 复合过滤 / OR / NOT 查询

你可以使用多层嵌套的 AND,OR 和 NOT 条件进行一个复合的 where 查询. 为了做到这一点,你可以使用 `or` , `and` 或 `not` `运算符`:

```js
Project.findOne({
  where: {
    name: 'a project',
    [Op.or]: [
      { id: [1,2,3] },
      { id: { [Op.gt]: 10 } }
    ]
  }
})

Project.findOne({
  where: {
    name: 'a project',
    id: {
      [Op.or]: [
        [1,2,3],
        { [Op.gt]: 10 }
      ]
    }
  }
})
```

这两段代码将生成以下内容:

```js
SELECT *
FROM `Projects`
WHERE (
  `Projects`.`name` = 'a project'
   AND (`Projects`.`id` IN (1,2,3) OR `Projects`.`id` > 10)
)
LIMIT 1;
```

`not` 示例:

```js
Project.findOne({
  where: {
    name: 'a project',
    [Op.not]: [
      { id: [1,2,3] },
      { array: { [Op.contains]: [3,4,5] } }
    ]
  }
});
```

将生成:

```js
SELECT *
FROM `Projects`
WHERE (
  `Projects`.`name` = 'a project'
   AND NOT (`Projects`.`id` IN (1,2,3) OR `Projects`.`array` @> ARRAY[3,4,5]::INTEGER[])
)
LIMIT 1;
```



### 用限制,偏移,顺序和分组操作数据集

要获取更多相关数据,可以使用限制,偏移,顺序和分组:

```js
// 限制查询的结果
Project.findAll({ limit: 10 })

// 跳过前10个元素
Project.findAll({ offset: 10 })

// 跳过前10个元素,并获取2个
Project.findAll({ offset: 10, limit: 2 })
```

分组和排序的语法是相同的,所以下面只用一个单独的例子来解释分组,而其余的则是排序. 你下面看到的所有内容也可以对分组进行

```js
Project.findAll({order: [['title', 'DESC']]})
// 生成 ORDER BY title DESC

Project.findAll({group: 'name'})
// 生成 GROUP BY name
```

请注意,在上述两个示例中,提供的字符串逐字插入到查询中,所以不会转义列名称. 当你向 order / group 提供字符串时,将始终如此. 如果要转义列名,你应该提供一个参数数组,即使你只想通过单个列进行 order / group

```js
something.findOne({
  order: [
    // 将返回 `name`
    ['name'],
    // 将返回 `username` DESC
    ['username', 'DESC'],
    // 将返回 max(`age`)
    sequelize.fn('max', sequelize.col('age')),
    // 将返回 max(`age`) DESC
    [sequelize.fn('max', sequelize.col('age')), 'DESC'],
    // 将返回 otherfunction(`col1`, 12, 'lalala') DESC
    [sequelize.fn('otherfunction', sequelize.col('col1'), 12, 'lalala'), 'DESC'],
    // 将返回 otherfunction(awesomefunction(`col`)) DESC,这个嵌套是可以无限的！
    [sequelize.fn('otherfunction', sequelize.fn('awesomefunction', sequelize.col('col'))), 'DESC']
  ]
})
```

回顾一下,order / group数组的元素可以是以下内容:

- String - 将被引用
- Array - 第一个元素将被引用,第二个将被逐字地追加
- Object -
  - raw 将被添加逐字引用
  - 如果未设置 raw,一切都被忽略,查询将失败
- Sequelize.fn 和 Sequelize.col 返回函数和引用的列名



### 字段过滤

想要只选择某些属性,可以使用 `attributes` 选项. 通常是传递一个数组:

```js
Model.findAll({
  attributes: ['foo', 'bar']
});
```

> SELECT foo, bar ...

属性可以使用嵌套数组来重命名:

```js
Model.findAll({
  attributes: ['foo', ['bar', 'baz']]
});
```

> SELECT foo, bar AS baz ...

也可以使用 `sequelize.fn` 来进行聚合:

```js
Model.findAll({
  attributes: [[sequelize.fn('COUNT', sequelize.col('hats')), 'no_hats']]
});
```

> SELECT COUNT(hats) AS no_hats ...

使用聚合功能时,必须给它一个别名,以便能够从模型中访问它. 在上面的例子中,你可以使用 `instance.get('no_hats')` 获得帽子数量.

有时,如果你只想添加聚合,则列出模型的所有属性可能令人厌烦:

```js
// This is a tiresome way of getting the number of hats...
Model.findAll({
  attributes: ['id', 'foo', 'bar', 'baz', 'quz', [sequelize.fn('COUNT', sequelize.col('hats')), 'no_hats']]
});

// This is shorter, and less error prone because it still works if you add / remove attributes
Model.findAll({
  attributes: { include: [[sequelize.fn('COUNT', sequelize.col('hats')), 'no_hats']] }
});
SELECT id, foo, bar, baz, quz, COUNT(hats) AS no_hats ...
```

同样,它也可以排除一些指定的表字段:

```js
Model.findAll({
  attributes: { exclude: ['baz'] }
});
SELECT id, foo, bar, quz ...
```

### Where

无论你是通过 findAll/find 或批量 updates/destroys 进行查询,都可以传递一个 `where` 对象来过滤查询.

`where` 通常用 attribute:value 键值对获取一个对象,其中 value 可以是匹配等式的数据或其他运算符的键值对象.

也可以通过嵌套 `or` 和 `and` `运算符` 的集合来生成复杂的 AND/OR 条件.



#### 基础

```js
const Op = Sequelize.Op;

Post.findAll({
  where: {
    authorId: 2
  }
});
// SELECT * FROM post WHERE authorId = 2

Post.findAll({
  where: {
    authorId: 12,
    status: 'active'
  }
});
// SELECT * FROM post WHERE authorId = 12 AND status = 'active';

Post.findAll({
  where: {
    [Op.or]: [{authorId: 12}, {authorId: 13}]
  }
});
// SELECT * FROM post WHERE authorId = 12 OR authorId = 13;

Post.findAll({
  where: {
    authorId: {
      [Op.or]: [12, 13]
    }
  }
});
// SELECT * FROM post WHERE authorId = 12 OR authorId = 13;

Post.destroy({
  where: {
    status: 'inactive'
  }
});
// DELETE FROM post WHERE status = 'inactive';

Post.update({
  updatedAt: null,
}, {
  where: {
    deletedAt: {
      [Op.ne]: null
    }
  }
});
// UPDATE post SET updatedAt = null WHERE deletedAt NOT NULL;

Post.findAll({
  where: sequelize.where(sequelize.fn('char_length', sequelize.col('status')), 6)
});
// SELECT * FROM post WHERE char_length(status) = 6;
```



#### 操作符

Sequelize 可用于创建更复杂比较的符号运算符 -

```js
const Op = Sequelize.Op

[Op.and]: {a: 5}           // 且 (a = 5)
[Op.or]: [{a: 5}, {a: 6}]  // (a = 5 或 a = 6)
[Op.gt]: 6,                // id > 6
[Op.gte]: 6,               // id >= 6
[Op.lt]: 10,               // id < 10
[Op.lte]: 10,              // id <= 10
[Op.ne]: 20,               // id != 20
[Op.eq]: 3,                // = 3
[Op.not]: true,            // 不是 TRUE
[Op.between]: [6, 10],     // 在 6 和 10 之间
[Op.notBetween]: [11, 15], // 不在 11 和 15 之间
[Op.in]: [1, 2],           // 在 [1, 2] 之中
[Op.notIn]: [1, 2],        // 不在 [1, 2] 之中
[Op.like]: '%hat',         // 包含 '%hat'
[Op.notLike]: '%hat'       // 不包含 '%hat'
[Op.iLike]: '%hat'         // 包含 '%hat' (不区分大小写)  (仅限 PG)
[Op.notILike]: '%hat'      // 不包含 '%hat'  (仅限 PG)
[Op.startsWith]: 'hat'     // 类似 'hat%'
[Op.endsWith]: 'hat'       // 类似 '%hat'
[Op.substring]: 'hat'      // 类似 '%hat%'
[Op.regexp]: '^[h|a|t]'    // 匹配正则表达式/~ '^[h|a|t]' (仅限 MySQL/PG)
[Op.notRegexp]: '^[h|a|t]' // 不匹配正则表达式/!~ '^[h|a|t]' (仅限 MySQL/PG)
[Op.iRegexp]: '^[h|a|t]'    // ~* '^[h|a|t]' (仅限 PG)
[Op.notIRegexp]: '^[h|a|t]' // !~* '^[h|a|t]' (仅限 PG)
[Op.like]: { [Op.any]: ['cat', 'hat']} // 包含任何数组['cat', 'hat'] - 同样适用于 iLike 和 notLike
[Op.overlap]: [1, 2]       // && [1, 2] (PG数组重叠运算符)
[Op.contains]: [1, 2]      // @> [1, 2] (PG数组包含运算符)
[Op.contained]: [1, 2]     // <@ [1, 2] (PG数组包含于运算符)
[Op.any]: [2,3]            // 任何数组[2, 3]::INTEGER (仅限PG)

[Op.col]: 'user.organization_id' // = 'user'.'organization_id', 使用数据库语言特定的列标识符, 本例使用 PG
```

#### 范围选项

所有操作符都支持支持的范围类型查询.

请记住,提供的范围值也可以[定义绑定的 inclusion/exclusion](https://itfun.tv/documents/266#range-types).

```js
// 所有上述相等和不相等的操作符加上以下内容:

[Op.contains]: 2           // @> '2'::integer (PG range contains element operator)
[Op.contains]: [1, 2]      // @> [1, 2) (PG range contains range operator)
[Op.contained]: [1, 2]     // <@ [1, 2) (PG range is contained by operator)
[Op.overlap]: [1, 2]       // && [1, 2) (PG range overlap (have points in common) operator)
[Op.adjacent]: [1, 2]      // -|- [1, 2) (PG range is adjacent to operator)
[Op.strictLeft]: [1, 2]    // << [1, 2) (PG range strictly left of operator)
[Op.strictRight]: [1, 2]   // >> [1, 2) (PG range strictly right of operator)
[Op.noExtendRight]: [1, 2] // &< [1, 2) (PG range does not extend to the right of operator)
[Op.noExtendLeft]: [1, 2]  // &> [1, 2) (PG range does not extend to the left of operator)
```

#### 组合

```js
{
  rank: {
    [Op.or]: {
      [Op.lt]: 1000,
      [Op.eq]: null
    }
  }
}
// rank < 1000 OR rank IS NULL

{
  createdAt: {
    [Op.lt]: new Date(),
    [Op.gt]: new Date(new Date() - 24 * 60 * 60 * 1000)
  }
}
// createdAt < [timestamp] AND createdAt > [timestamp]

{
  [Op.or]: [
    {
      title: {
        [Op.like]: 'Boat%'
      }
    },
    {
      description: {
        [Op.like]: '%boat%'
      }
    }
  ]
}
// title LIKE 'Boat%' OR description LIKE '%boat%'
```


#### 关系 / 关联

```js
// 找到所有具有至少一个 task 的  project,其中 task.state === project.state
Project.findAll({
    include: [{
        model: Task,
        where: { state: Sequelize.col('project.state') }
    }]
})
```



### 分页 / 限制

```js
// 获取10个实例/行
Project.findAll({ limit: 10 })

// 跳过8个实例/行
Project.findAll({ offset: 8 })

// 跳过5个实例,然后取5个
Project.findAll({ offset: 5, limit: 5 })
```



### 排序

`order` 需要一个条目的数组来排序查询或者一个 sequelize 方法.一般来说,你将要使用任一属性的 tuple/array,并确定排序的正反方向.

```js
Subtask.findAll({
  order: [
    // 将转义标题,并根据有效的方向参数列表验证DESC
    ['title', 'DESC'],

    // 将按最大值排序(age)
    sequelize.fn('max', sequelize.col('age')),

    // 将按最大顺序(age) DESC
    [sequelize.fn('max', sequelize.col('age')), 'DESC'],

    // 将按 otherfunction 排序(`col1`, 12, 'lalala') DESC
    [sequelize.fn('otherfunction', sequelize.col('col1'), 12, 'lalala'), 'DESC'],

    // 将使用模型名称作为关联的名称排序关联模型的 created_at.
    [Task, 'createdAt', 'DESC'],

    // Will order through an associated model's created_at using the model names as the associations' names.
    [Task, Project, 'createdAt', 'DESC'],

    // 将使用关联的名称由关联模型的created_at排序.
    ['Task', 'createdAt', 'DESC'],

    // Will order by a nested associated model's created_at using the names of the associations.
    ['Task', 'Project', 'createdAt', 'DESC'],

    // Will order by an associated model's created_at using an association object. (优选方法)
    [Subtask.associations.Task, 'createdAt', 'DESC'],

    // Will order by a nested associated model's created_at using association objects. (优选方法)
    [Subtask.associations.Task, Task.associations.Project, 'createdAt', 'DESC'],

    // Will order by an associated model's created_at using a simple association object.
    [{model: Task, as: 'Task'}, 'createdAt', 'DESC'],

    // 嵌套关联模型的 created_at 简单关联对象排序
    [{model: Task, as: 'Task'}, {model: Project, as: 'Project'}, 'createdAt', 'DESC']
  ]

  // 将按年龄最大值降序排列
  order: sequelize.literal('max(age) DESC')

  // 按最年龄大值升序排列,当省略排序条件时默认是升序排列
  order: sequelize.fn('max', sequelize.col('age'))

  // 按升序排列是省略排序条件的默认顺序
  order: sequelize.col('age')

  // 将根据方言随机排序 (而不是 fn('RAND') 或 fn('RANDOM'))
  order: sequelize.random()
})
```

### `count` - 计算数据库中元素的出现次数

还有一种数据库对象计数的方法:

```js
Project.count().then(c => {
  console.log("There are " + c + " projects!")
})

Project.count({ where: {'id': {[Op.gt]: 25}} }).then(c => {
  console.log("There are " + c + " projects with an id greater than 25.")
})
```



### `max` - 获取特定表中特定属性的最大值

这里是获取属性的最大值的方法:

```js
/*
   我们假设3个具有属性年龄的对象.
   第一个是10岁,
   第二个是5岁,
   第三个是40岁.
*/
Project.max('age').then(max => {
  // 将返回 40
})

Project.max('age', { where: { age: { [Op.lt]: 20 } } }).then(max => {
  // 将会是 10
})
```



### `min` - 获取特定表中特定属性的最小值

这里是获取属性的最小值的方法:

```js
/*
   我们假设3个具有属性年龄的对象.
   第一个是10岁,
   第二个是5岁,
   第三个是40岁.
*/
Project.min('age').then(min => {
  // 将返回 5
})

Project.min('age', { where: { age: { [Op.gt]: 5 } } }).then(min => {
  // 将会是 10
})
```



### `sum` - 特定属性的值求和

为了计算表的特定列的总和,可以使用“sum”方法.

```js
/*
   我们假设3个具有属性年龄的对象.
   第一个是10岁,
   第二个是5岁,
   第三个是40岁.
*/
Project.sum('age').then(sum => {
  // 将返回 55
})

Project.sum('age', { where: { age: { [Op.gt]: 5 } } }).then(sum => {
  // 将会是 50
})
```



## 预加载

当你从数据库检索数据时,也想同时获得与之相关联的查询,这被称为预加载.这个基本思路就是当你调用 `find` 或 `findAll` 时使用 `include` 属性.让我们假设以下设置:

```js
class User extends Model {}
User.init({ name: Sequelize.STRING }, { sequelize, modelName: 'user' })
class Task extends Model {}
Task.init({ name: Sequelize.STRING }, { sequelize, modelName: 'task' })
class Tool extends Model {}
Tool.init({ name: Sequelize.STRING }, { sequelize, modelName: 'tool' })

Task.belongsTo(User)
User.hasMany(Task)
User.hasMany(Tool, { as: 'Instruments' })

sequelize.sync().then(() => {
  // 这是我们继续的地方 ...
})
```

首先,让我们用它们的关联 user 加载所有的 task.

```js
Task.findAll({ include: [ User ] }).then(tasks => {
  console.log(JSON.stringify(tasks))

  /*
    [{
      "name": "A Task",
      "id": 1,
      "createdAt": "2013-03-20T20:31:40.000Z",
      "updatedAt": "2013-03-20T20:31:40.000Z",
      "userId": 1,
      "user": {
        "name": "John Doe",
        "id": 1,
        "createdAt": "2013-03-20T20:31:45.000Z",
        "updatedAt": "2013-03-20T20:31:45.000Z"
      }
    }]
  */
})
```

请注意,访问者(结果实例中的 `User` 属性)是单数形式,因为关联是一对一的.

接下来的事情:用多对一的关联加载数据！

```js
User.findAll({ include: [ Task ] }).then(users => {
  console.log(JSON.stringify(users))

  /*
    [{
      "name": "John Doe",
      "id": 1,
      "createdAt": "2013-03-20T20:31:45.000Z",
      "updatedAt": "2013-03-20T20:31:45.000Z",
      "tasks": [{
        "name": "A Task",
        "id": 1,
        "createdAt": "2013-03-20T20:31:40.000Z",
        "updatedAt": "2013-03-20T20:31:40.000Z",
        "userId": 1
      }]
    }]
  */
})
```

请注意,访问者(结果实例中的 `Tasks` 属性)是复数形式,因为关联是多对一的.

如果关联是别名的(使用 `as` 参数),则在包含模型时必须指定此别名. 注意用户的 `Tool` 如何被别名为 `Instruments`. 为了获得正确的权限,你必须指定要加载的模型以及别名:

```js
User.findAll({ include: [{ model: Tool, as: 'Instruments' }] }).then(users => {
  console.log(JSON.stringify(users))

  /*
    [{
      "name": "John Doe",
      "id": 1,
      "createdAt": "2013-03-20T20:31:45.000Z",
      "updatedAt": "2013-03-20T20:31:45.000Z",
      "Instruments": [{
        "name": "Toothpick",
        "id": 1,
        "createdAt": null,
        "updatedAt": null,
        "userId": 1
      }]
    }]
  */
})
```

你还可以通过指定与关联别名匹配的字符串来包含别名:

```js
User.findAll({ include: ['Instruments'] }).then(users => {
  console.log(JSON.stringify(users))

  /*
    [{
      "name": "John Doe",
      "id": 1,
      "createdAt": "2013-03-20T20:31:45.000Z",
      "updatedAt": "2013-03-20T20:31:45.000Z",
      "Instruments": [{
        "name": "Toothpick",
        "id": 1,
        "createdAt": null,
        "updatedAt": null,
        "userId": 1
      }]
    }]
  */
})

User.findAll({ include: [{ association: 'Instruments' }] }).then(users => {
  console.log(JSON.stringify(users))

  /*
    [{
      "name": "John Doe",
      "id": 1,
      "createdAt": "2013-03-20T20:31:45.000Z",
      "updatedAt": "2013-03-20T20:31:45.000Z",
      "Instruments": [{
        "name": "Toothpick",
        "id": 1,
        "createdAt": null,
        "updatedAt": null,
        "userId": 1
      }]
    }]
  */
})
```

当预加载时,我们也可以使用 `where` 过滤关联的模型. 这将返回 `Tool` 模型中所有与 `where` 语句匹配的行的`User`.

```js
User.findAll({
    include: [{
        model: Tool,
        as: 'Instruments',
        where: { name: { [Op.like]: '%ooth%' } }
    }]
}).then(users => {
    console.log(JSON.stringify(users))

    /*
      [{
        "name": "John Doe",
        "id": 1,
        "createdAt": "2013-03-20T20:31:45.000Z",
        "updatedAt": "2013-03-20T20:31:45.000Z",
        "Instruments": [{
          "name": "Toothpick",
          "id": 1,
          "createdAt": null,
          "updatedAt": null,
          "userId": 1
        }]
      }],

      [{
        "name": "John Smith",
        "id": 2,
        "createdAt": "2013-03-20T20:31:45.000Z",
        "updatedAt": "2013-03-20T20:31:45.000Z",
        "Instruments": [{
          "name": "Toothpick",
          "id": 1,
          "createdAt": null,
          "updatedAt": null,
          "userId": 1
        }]
      }],
    */
  })
```

当使用 `include.where` 过滤一个预加载的模型时,`include.required` 被隐式设置为 `true`. 这意味着内部联接完成返回具有任何匹配子项的父模型.



### 使用预加载模型的顶层 WHERE

将模型的 `WHERE` 条件从 `ON` 条件的 include 模式移动到顶层,你可以使用 `'$nested.column$'` 语法:

```js
User.findAll({
    where: {
        '$Instruments.name$': { [Op.iLike]: '%ooth%' }
    },
    include: [{
        model: Tool,
        as: 'Instruments'
    }]
}).then(users => {
    console.log(JSON.stringify(users));

    /*
      [{
        "name": "John Doe",
        "id": 1,
        "createdAt": "2013-03-20T20:31:45.000Z",
        "updatedAt": "2013-03-20T20:31:45.000Z",
        "Instruments": [{
          "name": "Toothpick",
          "id": 1,
          "createdAt": null,
          "updatedAt": null,
          "userId": 1
        }]
      }],

      [{
        "name": "John Smith",
        "id": 2,
        "createdAt": "2013-03-20T20:31:45.000Z",
        "updatedAt": "2013-03-20T20:31:45.000Z",
        "Instruments": [{
          "name": "Toothpick",
          "id": 1,
          "createdAt": null,
          "updatedAt": null,
          "userId": 1
        }]
      }],
    */
```



### 包括所有

要包含所有属性,你可以使用 `all:true` 传递单个对象:

```js
User.findAll({ include: [{ all: true }]});
```



### 包括软删除的记录

如果想要加载软删除的记录,可以通过将 `include.paranoid` 设置为 `false` 来实现

```js
User.findAll({
    include: [{
        model: Tool,
        where: { name: { [Op.like]: '%ooth%' } },
        paranoid: false // query and loads the soft deleted records
    }]
});
```



### 排序预加载关联

在一对多关系的情况下.

```js
Company.findAll({ include: [ Division ], order: [ [ Division, 'name' ] ] });
Company.findAll({ include: [ Division ], order: [ [ Division, 'name', 'DESC' ] ] });
Company.findAll({
  include: [ { model: Division, as: 'Div' } ],
  order: [ [ { model: Division, as: 'Div' }, 'name' ] ]
});
Company.findAll({
  include: [ { model: Division, as: 'Div' } ],
  order: [ [ { model: Division, as: 'Div' }, 'name', 'DESC' ] ]
});
Company.findAll({
  include: [ { model: Division, include: [ Department ] } ],
  order: [ [ Division, Department, 'name' ] ]
});
```

在多对多关系的情况下,你还可以通过表中的属性进行排序.

```js
Company.findAll({
  include: [ { model: Division, include: [ Department ] } ],
  order: [ [ Division, DepartmentDivision, 'name' ] ]
});
```



### 嵌套预加载

你可以使用嵌套的预加载来加载相关模型的所有相关模型:

```js
User.findAll({
  include: [
    {model: Tool, as: 'Instruments', include: [
      {model: Teacher, include: [ /* etc */]}
    ]}
  ]
}).then(users => {
  console.log(JSON.stringify(users))

  /*
    [{
      "name": "John Doe",
      "id": 1,
      "createdAt": "2013-03-20T20:31:45.000Z",
      "updatedAt": "2013-03-20T20:31:45.000Z",
      "Instruments": [{ // 1:M and N:M association
        "name": "Toothpick",
        "id": 1,
        "createdAt": null,
        "updatedAt": null,
        "userId": 1,
        "Teacher": { // 1:1 association
          "name": "Jimi Hendrix"
        }
      }]
    }]
  */
})
```

这将产生一个外连接. 但是,相关模型上的 `where` 语句将创建一个内部连接,并仅返回具有匹配子模型的实例. 要返回所有父实例,你应该添加 `required: false`.

```js
User.findAll({
  include: [{
    model: Tool,
    as: 'Instruments',
    include: [{
      model: Teacher,
      where: {
        school: "Woodstock Music School"
      },
      required: false
    }]
  }]
}).then(users => {
  /* ... */
})
```

以上查询将返回所有用户及其所有乐器,但只会返回与 `Woodstock Music School` 相关的老师.

包括所有也支持嵌套加载:

```js
User.findAll({ include: [{ all: true, nested: true }]});
```





## 新增

### 字段限制

```js
await User.create({ username: 'barfooz', isAdmin: true }, { fields: [ 'username' ] });
// 只有username有效

User.bulkCreate([
  { username: 'foo' },
  { username: 'bar', admin: true}
], { fields: ['username'] }).then(() => {
  // admin 将不会被构建
})
```

### 新增单个

```js
// create
this.ctx.body = await this.ctx.model.User.create({
    name: "哈哈哈",
    age: 12
});
```

### 批量新增

```js
// 批量新增 bulkCreate
this.ctx.body = await this.ctx.model.User.bulkCreate([
    {
        name: "第一个",
        age: 15
    },
    {
        name: "第二个",
        age: 15
    },
    {
        name: "第三个",
        age: 15
    },
]);
```



## 修改

### 字段限制

```js
task.title = 'foooo'
task.description = 'baaaaaar'
await task.save({fields: ['title']});
// title 现在将是 “foooo”,而 description 与以前一样

// 使用等效的 update 调用如下所示:
await task.update({ title: 'foooo', description: 'baaaaaar'}, {fields: ['title']});
//  title 现在将是 “foooo”,而 description 与以前一样
```

### 单个修改

```js
// 找出当前记录
const user = await this.ctx.model.User.findByPk(1);
await user.update({
    name: "我被修改了",
    age: 30
});
```



### 批量修改

```js
// 批量修改
await this.ctx.model.User.update({
    name: "批量修改"
}, {
    // 条件
    where: {
        name: "第一个"
    }
});
```

### 递增

```js
 // 找出当前记录 increment
const user = await this.ctx.model.User.findByPk(2);
this.ctx.body = await user.increment({
    age: 3, // age每次递增3
    other:2 // other每次递增2
});
```



### 递减

```js
 // 找出当前记录 decrement
const user = await this.ctx.model.User.findByPk(2);
this.ctx.body = await user.decrement({
    age: 3, // age每次递减3
    other:2 // other每次递减2
});
```





## 删除

### 软删除

模型中配置

```js
// 配置（重要）
  const User = app.model.define('user', { /* bla */},{
      // 同时需要设置paranoid为true（此种模式下，删除数据时不会进行物理删除，而是设置deletedAt为当前时间
      'paranoid': true
 });
```



### 查询包括软删除内容

```js
let user = await ctx.model.User.findOne({
    include:{
      model:ctx.model.Video,
      // 包括软删除
      paranoid: false
    },
    where: {
        id: 33
    },
    // 包括软删除
    paranoid: false
});
```





### 彻底删除

如果 `paranoid` 选项为 true,则不会删除该对象,而将 `deletedAt` 列设置为当前时间戳. 要强制删除,可以将 `force: true` 传递给 destroy 调用:

```js
task.destroy({ force: true })
```

在 `paranoid` 模式下对象被软删除后,在强制删除旧实例之前,你将无法使用相同的主键创建新实例.

### 恢复软删除的实例

如果你使用 `paranoid:true` 软删除了模型的实例,之后想要撤消删除,请使用 `restore` 方法:

```js
// 进行软删除...
task.destroy();
// 恢复软删除...
task.restore();
```

### 条件删除

```js
await this.ctx.model.User.destroy({
   where: {
       name: "批量修改"
    }
});
```



### 批量删除

```js
await this.ctx.model.Post.destroy({
    where: {
        id: posts
    }
});
```





## 重载实例

如果你需要让你的实例同步,你可以使用 `reload` 方法. 它将从数据库中获取当前数据,并覆盖调用该方法的模型的属性.

```js
Person.findOne({ where: { name: 'john' } }).then(person => {
  person.name = 'jane'
  console.log(person.name) // 'jane'

  person.reload().then(() => {
    console.log(person.name) // 'john'
  })
})
```



## 模型自定义方法

```js
// 模型
// 模型自定义方法
topic_user.ceshi = (param) => {
    console.log('模型自定义方法');
    console.log(param);
    return param;
}

// 控制器
await this.ctx.model.TopicUser.ceshi(123);
```



## Scopes - 作用域（重点）

作用域允许你定义常用查询,以便以后轻松使用. 作用域可以包括与常规查找器 `where`, `include`, `limit` 等所有相同的属性.



### 定义

作用域在模型定义中定义,可以是finder对象或返回finder对象的函数,除了默认作用域,该作用域只能是一个对象:

```js
class Project extends Model {}
Project.init({
  // 属性
}, {
  defaultScope: {
    where: {
      active: true
    }
  },
  scopes: {
    deleted: {
      where: {
        deleted: true
      }
    },
    activeUsers: {
      include: [
        { model: User, where: { active: true }}
      ]
    },
    random () {
      return {
        where: {
          someNumber: Math.random()
        }
      }
    },
    accessLevel (value) {
      return {
        where: {
          accessLevel: {
            [Op.gte]: value
          }
        }
      }
    }
    sequelize,
    modelName: 'project'
  }
});
```

通过调用 `addScope` 定义模型后,还可以添加作用域. 这对于具有包含的作用域特别有用,其中在定义其他模型时可能不会定义 include 中的模型.

始终应用默认作用域. 这意味着,通过上面的模型定义,`Project.findAll()` 将创建以下查询:

```js
SELECT * FROM projects WHERE active = true
```

可以通过调用 `.unscoped()`, `.scope(null)` 或通过调用另一个作用域来删除默认作用域:

```js
Project.scope('deleted').findAll(); // 删除默认作用域
SELECT * FROM projects WHERE deleted = true
```

还可以在作用域定义中包含作用域模型. 这让你避免重复 `include`,`attributes` 或 `where` 定义.

使用上面的例子,并在包含的用户模型中调用 `active` 作用域(而不是直接在该 include 对象中指定条件):

```js
activeUsers: {
  include: [
    { model: User.scope('active')}
  ]
}
```



### 使用

通过在模型定义上调用 `.scope` 来应用作用域,传递一个或多个作用域的名称. `.scope` 返回一个全功能的模型实例,它具有所有常规的方法:`.findAll`,`.update`,`.count`,`.destroy`等等.你可以保存这个模型实例并稍后再次使用:

```js
const DeletedProjects = Project.scope('deleted');

DeletedProjects.findAll();
// 过一段时间

// 让我们再次寻找被删除的项目！
DeletedProjects.findAll();
```

作用域适用于 `.find`, `.findAll`, `.count`, `.update`, `.increment` 和 `.destroy`.

可以通过两种方式调用作为函数的作用域. 如果作用域没有任何参数,它可以正常调用. 如果作用域采用参数,则传递一个对象:

```js
Project.scope('random', { method: ['accessLevel', 19]}).findAll();
SELECT * FROM projects WHERE someNumber = 42 AND accessLevel >= 19
```



### 合并

通过将作用域数组传递到 `.scope` 或通过将作用域作为连续参数传递,可以同时应用多个作用域.

```js
// 这两个是等价的
Project.scope('deleted', 'activeUsers').findAll();
Project.scope(['deleted', 'activeUsers']).findAll();
SELECT * FROM projects
INNER JOIN users ON projects.userId = users.id
WHERE projects.deleted = true
AND users.active = true
```

如果要将其他作用域与默认作用域一起应用,请将键 `defaultScope` 传递给 `.scope`:

```js
Project.scope('defaultScope', 'deleted').findAll();
SELECT * FROM projects WHERE active = true AND deleted = true
```

当调用多个作用域时,后续作用域的键将覆盖以前的作用域(类似于 [Object.assign](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign)),除了`where`和`include`,它们将被合并. 考虑两个作用域:

```js
{
  scope1: {
    where: {
      firstName: 'bob',
      age: {
        [Op.gt]: 20
      }
    },
    limit: 2
  },
  scope2: {
    where: {
      age: {
        [Op.gt]: 30
      }
    },
    limit: 10
  }
}
```

调用 `.scope('scope1', 'scope2')` 将产生以下查询

```js
WHERE firstName = 'bob' AND age > 30 LIMIT 10
```

注意 `scope2` 将覆盖 `limit` 和 `age`,而 `firstName` 被保留. `limit`,`offset`,`order`,`paranoid`,`lock`和`raw`字段被覆盖,而`where`被浅层合并(意味着相同的键将被覆盖). `include` 的合并策略将在后面讨论.

请注意,多个应用作用域的 `attributes` 键以这样的方式合并,即始终保留 `attributes.exclude`. 这允许合并多个作用域,并且永远不会泄漏最终作用域内的敏感字段.

将查找对象直接传递给作用域模型上的`findAll`(和类似的查找程序)时,适用相同的合并逻辑:

```js
Project.scope('deleted').findAll({
  where: {
    firstName: 'john'
  }
})
WHERE deleted = true AND firstName = 'john'
```

这里的 `deleted` 作用域与 finder 合并. 如果我们要将 `where: { firstName: 'john', deleted: false }` 传递给 finder,那么 `deleted` 作用域将被覆盖.



#### 合并 include

Include 是根据包含的模型递归合并的. 这是一个非常强大的合并,在 v5 上添加,并通过示例更好地理解.

考虑四种模型:Foo,Bar,Baz和Qux,具有如下多种关联:

```js
class Foo extends Model {}
class Bar extends Model {}
class Baz extends Model {}
class Qux extends Model {}
Foo.init({ name: Sequelize.STRING }, { sequelize });
Bar.init({ name: Sequelize.STRING }, { sequelize });
Baz.init({ name: Sequelize.STRING }, { sequelize });
Qux.init({ name: Sequelize.STRING }, { sequelize });
Foo.hasMany(Bar, { foreignKey: 'fooId' });
Bar.hasMany(Baz, { foreignKey: 'barId' });
Baz.hasMany(Qux, { foreignKey: 'bazId' });
```

现在,考虑Foo上定义的以下四个作用域:

```js
{
  includeEverything: {
    include: {
      model: this.Bar,
      include: [{
        model: this.Baz,
        include: this.Qux
      }]
    }
  },
  limitedBars: {
    include: [{
      model: this.Bar,
      limit: 2
    }]
  },
  limitedBazs: {
    include: [{
      model: this.Bar,
      include: [{
        model: this.Baz,
        limit: 2
      }]
    }]
  },
  excludeBazName: {
    include: [{
      model: this.Bar,
      include: [{
        model: this.Baz,
        attributes: {
          exclude: ['name']
        }
      }]
    }]
  }
}
```

这四个作用域可以很容易地深度合并,例如通过调用 `Foo.scope('includeEverything', 'limitedBars', 'limitedBazs', 'excludeBazName').findAll()`,这完全等同于调用以下内容:

```js
Foo.findAll({
  include: {
    model: this.Bar,
    limit: 2,
    include: [{
      model: this.Baz,
      limit: 2,
      attributes: {
        exclude: ['name']
      },
      include: this.Qux
    }]
  }
});
```

观察四个作用域如何合并为一个. 根据所包含的模型合并作用域的include. 如果一个作用域包括模型A而另一个作用域包括模型B,则合并结果将包括模型A和B.另一方面,如果两个作用域包括相同的模型A,但具有不同的参数(例如嵌套include或其他属性) ,这些将以递归方式合并,如上所示.

无论应用于作用域的顺序如何,上面说明的合并都以完全相同的方式工作. 如果某个参数由两个不同的作用域设置,那么只会该顺序产生差异 - 这不是上述示例的情况,因为每个作用域都做了不同的事情.

这种合并策略的工作方式与传递给`.findAll`,`.findOne`等的参数完全相同.



### 关联

Sequelize 与关联有两个不同但相关的作用域概念. 差异是微妙但重要的:

- **关联作用域** 允许你在获取和设置关联时指定默认属性 - 在实现多态关联时很有用. 当使用`get`,`set`,`add`和`create`相关联的模型函数时,这个作用域仅在两个模型之间的关联上被调用
- **关联模型上的作用域** 允许你在获取关联时应用默认和其他作用域,并允许你在创建关联时传递作用域模型. 这些作用域都适用于模型上的常规查找和通过关联查找.

举个例子,思考模型Post和Comment. Comment与其他几个模型(图像,视频等)相关联,Comment和其他模型之间的关联是多态的,这意味着除了外键 `commentable_id` 之外,注释还存储一个`commentable`列.

可以使用 association scope 来实现多态关联:

```js
this.Post.hasMany(this.Comment, {
  foreignKey: 'commentable_id',
  scope: {
    commentable: 'post'
  }
});
```

当调用 `post.getComments()` 时,这将自动添加 `WHERE commentable = 'post'`. 类似地,当向帖子添加新的注释时,`commentable` 会自动设置为 `'post'`. 关联作用域是为了存活于后台,没有程序员不必担心 - 它不能被禁用. 有关更完整的多态性示例,请参阅 [关联作用域](https://itfun.tv/documents/272#scopes)

那么考虑那个Post的默认作用域只显示活动的帖子:`where: { active: true }`. 该作用域存在于相关联的模型(Post)上,而不是像`commentable` 作用域那样在关联上. 就像在调用`Post.findAll()` 时一样应用默认作用域,当调用 `User.getPosts()` 时,它也会被应用 - 这只会返回该用户的活动帖子.

要禁用默认作用域,将 `scope: null` 传递给 getter: `User.getPosts({ scope: null })`. 同样,如果要应用其他作用域,请像这样:

```js
User.getPosts({ scope: ['scope1', 'scope2']});
```

如果要为关联模型上的作用域创建快捷方式,可以将作用域模型传递给关联. 考虑一个快捷方式来获取用户所有已删除的帖子:

```js
class Post extends Model {}
Post.init(attributes, {
  defaultScope: {
    where: {
      active: true
    }
  },
  scopes: {
    deleted: {
      where: {
        deleted: true
      }
    }
  },
  sequelize,
});

User.hasMany(Post); // 常规 getPosts 关联
User.hasMany(Post.scope('deleted'), { as: 'deletedPosts' });
User.getPosts(); // WHERE active = true
User.getDeletedPosts(); // WHERE deleted = true
```



# 扩展

extend/helper.js

```js
// app/extend/helper.js
module.exports = {
    // 扩展一个格式日期的方法
    formatTime(val) {
        let d = new Date(val * 1000);
        return d.getFullYear();
    },
};
```

模板中调用

```html
 <%=helper.formatTime(dateline)%>
```

其他地方调用

```js
this.ctx.helper.formatTime(dateline)
```





# 中间件

## 1. 定义

app/middleware/getIp.js

```js
/*
options: 中间件的配置项，框架会将 app.config[${middlewareName}] 传递进来。
app: 当前应用 Application 的实例。
*/
module.exports = (option, app) => {
    // 返回一个异步的方法
    return async function(ctx, next) {
        // 通过option传入额外参数
        console.log(option);
        console.log(ctx.request.ip);
        await next();
    }
};
```



## 2. 配置

config/config.default.js（配置全局中间件，所有路由都会调用）

```js
module.exports = appInfo => {
    ...
    
    // 配置全局中间件
    config.middleware = ['getIp']; // 注意驼峰式写法，如果中间件是a_bc.js，则要写成aBc

    // 配置中间件参数
    config.getIp = {
        ceshi: 123,
        // 通用配置（以下是重点）
        enable:true, // 控制中间件是否开启。
        match:'/news', // 设置只有符合某些规则的请求才会经过这个中间件（匹配路由）
        ignore:'/shop' // 设置符合某些规则的请求不经过这个中间件。
        
        /**
        注意：
        1. match 和 ignore 不允许同时配置
        2. 例如：match:'/news'，只要包含/news的任何页面都生效
        **/
        
        // match 和 ignore 支持多种类型的配置方式：字符串、正则、函数（推荐）
        match(ctx) {
          // 只有 ios 设备才开启
          const reg = /iphone|ipad|ipod/i;
          return reg.test(ctx.get('user-agent'));
        },
    };

    ...
};

    


```



## 3. 使用

### 路由中使用

app/router.js

```js
module.exports = app => {
    // 局部中间件（如果只需要局部调用，则不需要在config.default.js中配置）
    router.get('/admin/:id', app.middleware.getIp({ 
        ceshi: "我是admin" 
    }), controller.admin.index);
    
};
```



### 使用 Koa 的中间件（gzip压缩）

大大提高网站的访问速度（非常有效）

以 [koa-compress](https://github.com/koajs/compress) 为例，在 Koa 中使用时：

```js
const koa = require('koa');
const compress = require('koa-compress');

const app = koa();

const options = { threshold: 2048 };
app.use(compress(options));
```

我们按照框架的规范来在应用中加载这个 Koa 的中间件：

```js
// app/middleware/compress.js
// koa-compress 暴露的接口(`(options) => middleware`)和框架对中间件要求一致
module.exports = require('koa-compress');


// config/config.default.js
module.exports = {
  middleware: [ 'compress' ],
  compress: {
    threshold: 2048,
  },
};
```





# 表单提交

## post

app/controller/home.js

```js
async addInput(ctx) {
    await ctx.render('post');
}

async add(ctx) {
    // 通过ctx.request.body获取post提交数据
    console.log(ctx.request.body);
}
```

app/view/post.html

```html
<!--
需要定义：?_csrf=<%=ctx.csrf%>
-->
<form action="/add?_csrf=<%=ctx.csrf%>" method="post">
    <input type="text" name="username" id="username">
    <input type="password" name="password" id="password">
    <input type="submit" value="提交">
</form>
```

app/router.js

```js
router.get('/post', controller.home.addInput);
router.post('/add', controller.home.add);
```









# cookie

```js
// 1.设置
ctx.cookies.set('username', 'ceshi');
// 2.获取
ctx.cookies.get('username');

// 3.设置中文(加密操作 encrypt: true)

// 4.设置（其他参数配置）
ctx.cookies.set('username', 'ceshi', {
    maxAge: 1000 * 3600 * 24, // 存储24小时，单位毫秒，关闭浏览器cookie还存在
    httpOnly: true, // 设置键值对是否可以被 js 访问，默认为 true，不允许被 js 访问。
    signed: true, // 签名，防止用户前台修改
    encrypt: true // 加密，注意：get获取时需要解密
});
// 5.获取时解密
ctx.cookies.get('username',{
    encrypt: true
});

// 6.清除cookie
ctx.cookies.set('username', null);
```



# session

```js
// 1.设置
ctx.session.username = '测试';
// 2.获取
ctx.session.username
// 3.默认配置（全局配置，config/config.default.js）
exports.session = {
  key: 'EGG_SESS', // 设置cookies的key值
  maxAge: 24 * 3600 * 1000, // 1 天，过期时间
  httpOnly: true, // 设置键值对是否可以被 js 访问，默认为 true，不允许被 js 访问。
  encrypt: true,// 加密
  renew:true    // 每次刷新页面都会被延期
};
// 4.动态配置
ctx.session.maxAge = 5000; // 5秒的过期时间
ctx.session.username = '测试';
// 5.清空session
ctx.session.username = null;
```



# 定时任务

```js
// app/schedule/ceshi.js
var i = 1;
module.exports = {
    // 设置定时任务的执行间隔等配置
    schedule: {
        interval: '5s', // 每5秒执行一次
        type: 'all' // 指定所有的 worker 都需要执行
    },
    // 任务
    async task(ctx) {
        ++i;
        console.log(i);
    }
};
```



# API

## 1. context

### curl

```js
async ceshi() {
    // 通过ctx中的curl方法获取数据
    let r = await this.ctx.curl('http://www.phonegap100.com/appapi.php?a=getPortalList&catid=20&page=1');
    // 将buffer类型数据转为json类型
    let { result } = JSON.parse(r.data)
    return result;
}
```





# 常用插件
## 缓存
https://www.npmjs.com/package/egg-cache
https://www.npmjs.com/package/egg-redis
## 验证
https://github.com/temool/egg-validate-plus

## 加密

<https://www.npmjs.com/package/egg-jwt>

前端访问：header头添加：

```js
// Authorization:"Bearer token值"
Authorization:"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6MTIzLCJpYXQiOjE1NzkxOTQxNTN9.Ml5B02ZPfYo78QwJic-Jdp2LUi2_AU0RGNgPhhJH--o"
```













