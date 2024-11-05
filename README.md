# 1. 项目背景  
本项目是厦门大学2022级软件工程使用操作系统大作业，基于Open Harmony的arkts声明式组件开发和arkUi编写一个原生鸿蒙App，提交材料包括源码，文档和演示视频。  


# 2. 项目简介  
此项目是一个简单的记账本，包含基础的记账数据本地持久化，查询，筛选，展示，统计和清除功能。遵循松耦合的设计原则，具有良好的可拓展性。  
项目地址: https://github.com/nanyan2333/NnkBook  

# 3. 开发环境  
- Windows 11  
  - DevEco Studio Windows V5.0.3.900
  - Git
- DevEco Studio自带的模拟手机设备  
# 4. 需求说明  
用户能够通过软件统计最近一个月(30天)的收入支出情况，列出每一次记账的数额，详细时间，类型（收入还是支出），标签，并且能够查看到一个最近30天的支出总额，收入总额，记账次数  
功能如下： 

- 查询30天内的记账记录，列出明细
- 查询特定日期的记账记录
- 对查询结果的收入总额支出总额进行统计
- 新增记账记录并本地持久化
- 清空本地记录
# 5. 项目结构说明  
核心源码目录在src/main
```  
│  module.json5
│
├─ets
│  ├─entryability
│  │      EntryAbility.ets
│  │
│  ├─entrybackupability
│  │      EntryBackupAbility.ets
│  │
│  ├─pages
│  │  │  Index.ets //程序入口
│  │  │
│  │  ├─Layout
│  │  │      tab.ets // 导航栏布局，挂载到程序入口
│  │  │
│  │  └─view // 视图层，其中的index挂载到Layout布局中，其他文件各自挂载到各自的index文件下
│  │      ├─add
│  │      │      index.ets // 新增记账入口
│  │      │      tagMenu.ets
│  │      │
│  │      ├─book
│  │      │      index.ets // 查询记账入口
│  │      │      listItemBuilder.ets
│  │      │
│  │      └─setting
│  │              index.ets // 清除数据入口
│  │
│  └─utils
│          confirmDialog.ets // 通用确认对话框组件
│          dataInterface.ets // 通用数据接口和枚举映射
│          file.ets // 通用文件读写
│          time.ets // 时间字符串操作
│
└─resources
    ├─base
    │  ├─element
    │  │      color.json
    │  │      string.json
    │  │
    │  ├─media
    │  │      background.png
    │  │      foreground.png
    │  │      layered_image.json
    │  │      startIcon.png
    │  │      TwemojiClownFace.png
    │  │
    │  └─profile
    │          backup_config.json
    │          main_pages.json
    │
    ├─en_US
    │  └─element
    │          string.json
    │
    ├─rawfile
    │      add.svg
    │      add_select.svg
    │      book.svg
    │      book_select.svg
    │      clear.svg
    │      description.svg
    │      recordPoint.svg
    │      setting.svg
    │      setting_select.svg
    │      sum.svg
    │      tag.svg
    │      time.svg
    │
    └─zh_CN
        └─element
                string.json
```
- `src/main/ets`: 包含项目的核心代码。
    - `entryability` 和 `entrybackupability`: 各自包含不同功能的 `EntryAbility.ets` 文件。
    - `pages`: 页面结构，包含多个子页面和布局。
        - `Layout`: 包含布局文件， `tab.ets`构建了底部导航栏，映射视图层各个视图的index文件，包含一个渲染前的钩子和所有的组件通信全局变量（@Provide注解）和一个导航栏控制器构建函数。
        - `view`: 包含不同视图的文件，选择性的消费父组件提供的变量渲染对应视图。
            - `add`: 是新增记账表单组件，包含 `index.ets` 和 `tagMenu.ets` 文件，其中index是入口，tagMenu是选择表单的组件。
            - `book`: 是主界面组件包含 `index.ets` 和 `listItemBuilder.ets` 文件，包含一个搜索栏，三个文本组件和一个表单组件，listItemBuilder是列表项的Builder函数。
            - `setting`: 包含设置页面的 `index.ets` 文件，目前只有清空应用数据功能。
    - `utils`: 包含通用工具文件，如 `confirmDialog.ets`、`dataInterface.ets`、`file.ets` 和 `time.ets`。
        - `confirmDialog.ets`: 是确认弹窗组件函数
        - `dataInterface.ets`: 是通用数据接口bookItem和枚举映射函数的模块导出
        - `file.ets`: 操作json文件的封装，包含初始化文件路径，删除扩展名，创建文件，读文件，重写文件，追加文件（往字典里添加一项），删除文件，清空内存几个函数。
        - `time.ets`: 获取当前日期和当前时间并初始化格式的函数
    - `index.ets`: app根组件入口文件

- `resources`: 项目资源文件。
    - `base/element`: 包含颜色和字符串定义的 JSON 文件。
    - `base/media`: 包含图片和图标资源文件。
    - `profile`, `en_US`, `rawfile`, `zh_CN`: 各种配置和语言文件夹，其中项目图标都在rawfile中引用。

- `module.json5`: 项目的模块配置文件。

---  

# 6. 可拓展方向以及不足
- Ui设计较为简陋，后续可以往Ui美化方向进行优化
- 已对标签枚举，后续可以通过华为第三方仓库的echarts进行对不同标签不同类型的数据可视化展示
- 数据耦合度较高，查询的数据全部挂载在Layout层进行Provide


# 7. 项目演示  
- 应用图标  
![Alt text](https://github.com/nanyan2333/image/blob/main/icon.png?raw=true) 
- 主界面  
![Alt text](https://github.com/nanyan2333/image/blob/main/main.png?raw=true) 
![Alt text](https://github.com/nanyan2333/image/blob/main/search.png?raw=true)
![Alt text](https://github.com/nanyan2333/image/blob/main/reset.png?raw=true)
- 提交新的记录  
![Alt text](https://github.com/nanyan2333/image/blob/main/new1.png?raw=true)
![Alt text](https://github.com/nanyan2333/image/blob/main/new2.png?raw=true) 
![Alt text](https://github.com/nanyan2333/image/blob/main/new3.png?raw=true)
- 设置  
![Alt text](https://github.com/nanyan2333/image/blob/main/setting.png?raw=true) 