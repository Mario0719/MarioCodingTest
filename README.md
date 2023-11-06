# MarioCodingTest
Coding Test for Native Mobile Developer

Demo 使用纯 Swift 语言开发。
使用Xcode 15.0.1 , 兼容版本 iOS 12 + 
主要 采用 rxswift + mvvm 架构开发

## 页面介绍
1: tabbar 首页，主要是用于条件筛选，选择 媒体类型、国家地区。
2: tabbar 收藏夹， 主要展示收藏的内容，可对内容滑动删除，移除收藏。
## 其他页面
1: 搜索页面： 主要功能在此页面，可以根据条件、内容，进行搜索。具备分页功能
2: 语言设置： 提供 简体、繁体、英语 三种语言切换


## 使用说明：

github 地址： https://github.com/Mario0719/MarioCodingTest
下载之后如果没有Pods, 则需要在终端cd 到 项目路径； 使用pod install 安装第三方库。

##代码实现说明：
项目集成多个优秀的开源第三方库在实现需求，如：
1. ObjectMapper 用于解决数据返回的 Json 转换 成 Model, 使数据更清晰
2. 收藏功能使用了 Realm 数据库实现，让收藏的媒体资源缓存到本地，在收藏夹可以直接取出来展示
3. Kingfisher 用于展示 搜索到的媒体数据 封面图 等等

JJHomeViewController 是程序的首页
JJSearchViewController 是搜索页面，是所有功能集中的页面，包含搜索、展示、分页
上述两个页面持有 SearchViewModel， 所有的逻辑处理、网络请求、数据 都在这个ViewModel 上

采用rxswift 来实现数据的绑定， 简化tableView 的胶水代码。让 Viewcontroller 的代码十分简洁，同时也可以让ViewModel 摆脱UI 实现数据测试。

##遇到的问题
在对 JJSearchViewController 的搜索栏的操作上，如何更有效的响应数据的获取有疑问。
在用户操作搜索栏的时候，如果采取实时监听并且获取数据，那么会发起多次没有必要的请求，浪费资源。 比如：用户想要搜索迈克尔杰克逊， 如果每输入一个字都去获取数据，那么将会有多次的请求，列表始终有数据，只不过不是自己想要的。
因此在这个问题上，我采取了 当用户输入完需要搜索的文本，监听点击键盘上的【搜索】按钮，才去触发条件搜索获取数据。
两者之间各有利弊，我选择了后者。


##效果图 
![Simulator Screenshot - iPhone 15 Pro Max - 2023-11-07 at 02 24 20](https://github.com/Mario0719/MarioCodingTest/assets/10015147/3ed58fa1-494d-4108-88ee-f8ed0fc52cd3)
![Simulator Screenshot - iPhone 15 Pro Max - 2023-11-07 at 02 27 36](https://github.com/Mario0719/MarioCodingTest/assets/10015147/acfd7230-bb95-44b0-be64-c253dfbbf406)
![Simulator Screenshot - iPhone 15 Pro Max - 2023-11-07 at 02 28 04](https://github.com/Mario0719/MarioCodingTest/assets/10015147/02f9ed69-9676-40a5-8cbc-3b7734ec1a00)
