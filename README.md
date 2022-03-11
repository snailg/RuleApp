# RuleApp

RuleApp，一款功能全面，用户交互良好的程序，兼容安卓苹果端，H5网页，微信小程序等。同时是集成数据本地缓存，邮箱验证，在线投稿，（内置Mardown编辑器），社会化登录，点赞打赏，积分商城，付费阅读，在线充值等一系列功能的自媒体博客资讯APP。

UI框架使用ColorUI，感谢社区有如此优秀的开源框架！

本程序不包含任何按收费项目，功能全部开放且完全开源免费（包括后端接口）。开源不易，需要赞助提供动力【手动狗头】。


[赞助地址](https://www.ruletree.club/sponsor.html)

## 后端接口

基于Typoche程序数据库开发，后端接口采用springboot框架，已经集成了COS和OSS对象存储，token登录验证，邮箱验证，redis数据缓存，微信支付宝充值，社会化登陆接口等，当然也可以自行对接其它的接口。

后端接口下载地址（首先需要安装Typecho程序）：

[接口下载及安装](https://www.ruletree.club/archives/2661/)

测试对接用接口地址：

[http://43.128.72.21:8081/](http://43.128.72.21:8081/)

（无法上传图片，具体效果可参考演示APP，服务器经常被攻击，可能不稳定）

## 安装步骤

1.编辑utils/api.js，设置接口地址，网站地址，群地址。同时设置各种数据调用的id和mid。

2.编辑manifest.json设置社会化登录。

3.对象存储上传和本地上传的切换，请修改utils/api.js中的upload方法

详细安装打包教程可参考：[uniapp从基本配置到打包发布，详细流程](https://www.ruletree.club/archives/2894/)


## 基础功能

1.基于标签，分类，搜索词，文章字段，随机为一体的数据查询调用

2.集成了基于邮箱验证的登录注册，邮箱修改

3.集成了在线评论，在线投稿，编辑文章等用户操作模块

4.集成了用户签到，打赏，收藏，点赞等基本交互模块

5.整合积分商城，付费阅读，在线充值（微信和支付宝），提现审核，简易后台

6.本地列表数据缓存，更优秀的加载体验。

7.兼容安卓苹果APP，H5网页，微信小程序等所有小程序平台，更多支持正在开发...

## 演示地址

[点击此处下载演示](https://www.pgyer.com/J9bd)

在安装使用过程遇到的一切问题，BUG的反馈，以及演示版本的下载，都可以加QQ群讨论：675025692。

IOS免签约打包教程：[点击进入](https://www.ruletree.club/archives/2845/)

或者访问我的网站浏览更多信息：[规则之树](https://www.ruletree.club/archives/2649/)