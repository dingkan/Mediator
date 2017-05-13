# Mediator

本人工作与上海朗信传媒,项目中用到了Target-Action runtime调用组件方案,参考了Casa大神的http://casatwy.com/iOS-Modulization.html组件化方案.此demo是简化版的,方便理解

#####Mediator模式和Target-Action模式

    * Target-Action实质上是通过runtime来获取响应对象&方法来调用
    * Mediator将远程调用和本地调用做了区分,但是都是通过runtime来实现,本地调用为远程调用提供了服务

######注意点
    * 远程通过openURL方式打开,这里需要在info.plist中配置scheme获取应用
    * Mediator通过解析url来获取响应的Target,action,参数. 所以这里注意1:对字符串有严格要求,不然无法获取响应的对象及方法. 2.服务端推送是需要对接口接口进行统一
    * 利用runtime获取响应对象需要对无响应进行处理
