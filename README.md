
<img width="593" alt="HAR包的构建和发布" src="https://github.com/user-attachments/assets/ccbe4107-b4bb-4449-ab47-9137a7d66c54">

### 目录
##### 一、HAR的介绍
##### 二、构建HAR包
##### 三、发布HAR包
##### 四、发布成功HAR包的导入和使用
##### 五、问题记录
-----------------------------------
## 一、HAR的介绍
#### 1、什么是HAR？
> HAR（Harmony Archive）是静态共享包，可以包含代码、C++库、资源和配置文件。通过HAR可以实现多个模块或多个工程共享ArkUI组件、资源等相关代码。
#### 2、HAR使用场景
*   作为二方库，发布到[OHPM](https://ohpm.openharmony.cn/)私仓，供公司内部其他应用使用。
*   作为三方库，发布到[OHPM](https://ohpm.openharmony.cn/)中心仓，供其他应用使用。
#### 3、HAR约束限制
*   HAR不支持在设备上单独安装/运行，只能作为应用模块的依赖项被引用。
*   HAR不支持在配置文件中声明[UIAbility](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/uiability-overview-V5)组件与[ExtensionAbility](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/extensionability-overview-V5)组件。
*   HAR不支持在配置文件中声明[pages](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/module-configuration-file-V5#pages%E6%A0%87%E7%AD%BE)页面，但是可以包含pages页面，并通过[命名路由](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-routing-V5#%E5%91%BD%E5%90%8D%E8%B7%AF%E7%94%B1)的方式进行跳转。
*   HAR不支持引用AppScope目录中的资源。在编译构建时，AppScope中的内容不会打包到HAR中，因此会导致HAR资源引用失败。
*   HAR可以依赖其他HAR，但不支持循环依赖，也不支持依赖传递。

## 二、构建HAR包
#### 1、创建库模块
######  1）新建一个鸿蒙项目（或者使用原有项目也可以），以新建的鸿蒙项目 WXQHMProject 为例，鼠标移到工程目录顶部，单击右键，选择New > Module，在工程中添加模块：
<img width="600" alt="1、创建Module_副本" src="https://github.com/user-attachments/assets/7a45e6df-b300-4a0d-9cb6-d059fb50bdab">


######  2）在Choose Your Ability Template界面中，选择Static Library，并单击Next：
<img width="600" alt="2、选择Static Library" src="https://github.com/user-attachments/assets/7fc3ed96-83a2-4abb-983b-0082faeef38e">


###### 3）在Configure New Module界面中，设置新添加的模块信息（以新增模块 wxqcolor 为例），设置完成后，单击Finish完成创建。
* Module name：新增模块的名称。比如：wxqcolor。
* Device type：支持的设备类型。
* Enable native：是否创建一个用于调用C++代码的模块。
<img width="600" alt="3、设置Module名称" src="https://github.com/user-attachments/assets/7bafde49-3fe6-4698-ba47-7127679c1ff3">


###### 4）以下就是新建的Module展示：
<img width="600" alt="4、新建的Module展示" src="https://github.com/user-attachments/assets/29fdaa3f-21ff-4bea-b00b-3229821e076a">


#### 2、HAR包的构建
###### 1）将要发布使用的代码放在 src/main/ets/components 目录下，比如新增一个ets文件 WXQColor.ets。
<img width="600" alt="5、新增module类" src="https://github.com/user-attachments/assets/8c485c96-9581-4b5c-afde-82cb5784ce58">

###### 2）开发完库模块后，选中模块名，然后通过DevEco Studio菜单栏的**Build > Make Module 'wxqcolor'**进行编译构建，生成HAR。HAR可用于工程其它模块的引用，或将HAR上传至ohpm仓库，供其他开发者下载使用。若部分源码文件不需要打包至HAR中，可通过[创建.ohpmignore文件](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-hvigor-build-har-V5#li18114177202814)，配置打包时要忽略的文件/文件夹。
<img width="600" alt="6、Make Module 'wxqcolor'" src="https://github.com/user-attachments/assets/39b6b91d-3e0d-49fe-b3e0-faa72d6ade2f">

###### 构建成功后，会生成一个包 wxqcolor.har，在build/default/outputs/default/wxqcolor.har 路径下。
<img width="600" alt="7、har构建成功" src="https://github.com/user-attachments/assets/eb5e8bae-bf4a-437d-b3ac-c121d6b680ee">

#### 3、HAR包的导入和使用
###### 1）验证下本地构建好的HAR包是否可以在项目中导入和使用，首先新建一个测试项目 WXQHarTest，工程目录下新建文件夹libs，并将 wxqcolor.har 包拷贝到该目录下（图中1），打开项目的oh-package.json5 添加har包的依赖（图中2和3），最后执行同步操作 Sync Now（图中4）。
<img width="600" alt="8、har包的导入" src="https://github.com/user-attachments/assets/85a4d250-c222-40d6-a2e5-2d666f8546b9">

###### 2）导入成功后，会生成一个文件 oh-package-lock.json5，里面详细记录导入的包的信息（图中1），以及导入成功后打印的提示信息（图中2）。
<img width="600" alt="9、har包导入成功" src="https://github.com/user-attachments/assets/7e026e8a-01b9-42d5-8dbb-1424e814c327">

###### 3）在Index.ets 中导入包的头文件（图中1和2），调用har包中的相关代码（图中3）。
<img width="600" alt="10、har包的引用和代码使用" src="https://github.com/user-attachments/assets/d943b944-99e2-4b4b-aab5-d2bf7faf4a7a">

###### 4）模拟器运行后效果截图
<img width="250" alt="11、使用效果截图" src="https://github.com/user-attachments/assets/9d45f370-e47b-49f5-b20d-8412a1e8bbe9">


## 三、发布HAR包
#### 1、在库模块wxqcolor中（与src文件夹同一级目录下），修改oh-package.json5文件内容，如下：
```
{
  "name": "@wxqos/wxqcolor",
  "version": "1.0.0",
  "description": "自定义一套颜色，直接引用即可",
  "main": "Index.ets",
  "author": "wxq24",
  "license": "Apache-2.0",
  "dependencies": {},
  "compatibleSdkType": "HarmonyOS"
}
```
* name：HAR包名。在 ohpm 中包的命名格式为@<group>/<package_name>或者<package_name>。其中 group 是组织，package_name 是包名。当想要上传一个含有组织（例如@wxqos/wxqcolor）的包时，在ohpm-repo中需要先创建出该组织（例如wxqos）才能进行上传。该组织名称需要审核，只有审核通过后，才能在该组织下发布包，所以要提前申请。具体的申请，请参考官方文档：[组织管理](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/ide-ohpm-organization-V5)。
* version：包的版本号，一般从1.0.0开始。
* description：包的描述。
* main: 定义包的主入口文件。
* author：开发者名称。
* license: 包的许可证类型。
* dependencies: 列出项目运行时必需的依赖包及其版本。

###### 注意：在后面的 README.md 文件或者 CHANGELOG.md 中如果介绍包信息，其中包名一定要和name中设置的包名（@wxqos/wxqcolor）一致，否则有审核失败的风险！！！
<img width="600" alt="12、README" src="https://github.com/user-attachments/assets/590075f3-806c-4dc5-8ff6-faa3e2d8011b">

###### 以上信息中的name、author、description，会在[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/#/cn/home)中展示。
<img width="300" alt="上传成功的包信息" src="https://github.com/user-attachments/assets/f418f472-4f41-4a33-8125-4ff8ef90958a">

#### 2、在库模块wxqcolor中（与src文件夹同一级目录下），添加如下文件：
* 新建README.md文件：在README.md文件中必须包含包的介绍和引用方式，还可以根据包的内容添加更详细介绍。
<img width="600" alt="13、CHANGELOG" src="https://github.com/user-attachments/assets/f6b7cd21-9865-4845-8be5-f79c4e86afb7">

* 新建CHANGELOG.md文件：填写HAR的版本更新记录。
<img width="600" alt="14、LICENSE" src="https://github.com/user-attachments/assets/9fef1d52-fe0e-4817-92ac-6df093c84922">

* 添加LICENSE文件：LICENSE许可文件。
<img width="600" alt="15、oh-package-json5" src="https://github.com/user-attachments/assets/de661dc0-79fa-46aa-9cd0-d4753f55fa65">

###### 注意：以上内容要保证文件不缺失、内容正确且真实，不然之后的审核有可能会通不过！

#### 3、修改完以上信息后，需要重新执行下 Make Module 'wxqcolor' 编译构建一个新的 wxqcolor.har 包。

#### 4、利用工具ssh-keygen生成公、私钥，可通过执行以下命令来生成公钥和私钥：
```
ssh-keygen -m PEM -t RSA -b 4096 -f ~/.ssh_ohpm/mykey 
```
在命令执行过程中，会让你输入一个密码，这个密码是后面用来上传包用的，一定要记住！！！
```
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
```
如果本地 ~/ 路径下没有隐藏文件夹.ssh_ohpm，需要先手动创建一个：cd到 ~/ 下，执行 mkdir .ssh_ohpm。
执行成功后会生成以下私钥和公钥文件：

<img width="600" alt="16、公钥和私钥路径" src="https://github.com/user-attachments/assets/84f3b763-5afa-4c7b-812a-0a0d9b97426f">

###### 官方说明：
* ~/.ssh_ohpm/mykey 为私钥文件 mykey 的文件路径，按照实际情况指定。指定的私钥存储目录必须存在。【解释：生成的mykey为私钥，存储到本地】
* 追加了.pub后缀的相应公钥文件会存放在和私钥相同的目录下。【解释：生成的mykey.pub为公钥，后面会将公钥内容复制到[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/#/cn/home)官网中个人信息下，参考步骤5】
* OHPM包管理器只支持加密密钥认证，请在生成公私钥时输入密码。【解释：就是上面说的密码，后面上传包的时候会用】

#### 5、登录[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/#/cn/home)官网，单击主页右上角的个人中心，新增OHPM公钥，将公钥文件（mykey.pub）的内容粘贴到公钥输入框中。
![17、公钥添加](https://github.com/user-attachments/assets/d28edd75-f0dd-430b-8bc2-a12c267262ec)

公钥添加成功后显示：
![18、公钥添加成功后](https://github.com/user-attachments/assets/6859423e-864c-40ec-9868-afad90cf37b3)

#### 6、打开命令行工具，将对应私钥文件路径配置到 .ohpmrc 文件中 key_path 字段上。
执行以下命令进行配置：
```
ohpm config set key_path  ~/.ssh_ohpm/mykey
```
在ohpmrc文件中会填充一条内容，表示命令执行成功：
 ```
key_path=/Users/xxx/.ssh_ohpm/mykey
```
<img width="600" alt="19、ohpmrc文件路径" src="https://github.com/user-attachments/assets/fab2a658-cfb8-402b-9bf3-0d197f3ff77d">

#### 7、登录[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/)官网，单击主页右上角的**个人中心**，复制发布码，获取发布码并配置到 .ohpmrc 文件中，可执行如下命令：
 ```
ohpm config set publish_id your_publish_id
 ```
执行完成后，会在步骤6中的 ohpmrc文件中会新增一条内容：
 ```
publish_id=your_publish_id
 ```
将其中的 your_publish_id 替换成你在官网复制的发布码（比如：5UABCDEFGH）即可。
也可以直接执行以下命令即可：
 ```
ohpm config set publish_id 5UABCDEFGH
 ```
![20、官网复制发布码](https://github.com/user-attachments/assets/0a462236-3bc1-46a9-b91b-63d243a42041)


#### 8、执行如下命令发布HAR，<HAR路径>需指定为.har文件的具体路径。
 ```
ohpm publish /Users/xxx/WXQHMProject/wxqcolor/build/default/outputs/default/wxqcolor.har

 ```
###### 注意：其中会让你输入一个密码，就是上面说的的上传包的密码。

终端打印以下信息就表示发布提交完成了，发布的包是需要审核的，只有审核通过后才会在[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/)展示：
```
>  ohpm publish /Users/xxx/WXQHMProject/wxqcolor/build/default/outputs/default/wxqcolor.har
registry:https://ohpm.openharmony.cn/ohpm/

package:@wxqos/wxqcolor@1.0.0

=== Harball Contents ===
519B    BuildProfile.ets
66B     CHANGELOG.md
198B    Index.ets
587B    LICENSE
1004B   README.md
27B     ResourceTable.txt
500B    build-profile.json5
0B      consumer-rules.txt
234B    hvigorfile.ts
93.3kB  img.png
1008B   obfuscation-rules.txt
300B    oh-package.json5
593B    src/main/module.json
274B    src/main/ets/components/MainPage.ets
1.1kB   src/main/ets/components/WXQColor.ets
96B     src/main/resources/base/element/string.json
96B     src/main/resources/en_US/element/string.json
96B     src/main/resources/zh_CN/element/string.json

=== Harball Details ===
name:           @wxqos/wxqcolor
version:        1.0.0
filename:       @wxqos/wxqcolor-1.0.0.har
package size:   95.7 kB
unpacked size:  99.8 kB
shasum:         TKIo4iIPMFmZMfG2MVlUPqH0O4U=
integrity:      sha512-yEZi/38AayT9zGjJxJWJxviuB9F4F7W6O9se2Ok49CYxVGiPDRSP+1qSWjRdj9WN9N9sv3++t6pOCRJl4foqYw==
total files:    18


ohpm WARN: The HAR package to be uploaded contains source code, which may cause code asset leakage. Please abort if you do not want to procceed.
what is your passphrase of the private key: *******
+@wxqos/wxqcolor 1.0.0 
Thanks for your contribution, the submitted OHPM library is under review, you can check the package status from https://ohpm.openharmony.cn/#/cn/personalCenter/package

```
在[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/)的消息中能查看到你提交的信息，以及审核结果的信息：

![21、发布消息](https://github.com/user-attachments/assets/92b40d16-e53f-4d1f-bcd3-7183d54d2300)

审核通过后，就可以在[OpenHarmony三方库中心仓](https://ohpm.openharmony.cn/)中搜索到了：

<img width="800" alt="22、搜索结果" src="https://github.com/user-attachments/assets/0a06076f-e701-4c07-9498-8e3f44d9accf">

## 四、发布成功HAR包的导入和使用

#### 1、在项目的Terminal 执行导入命令：
```
 ohpm install @wxqos/wxqcolor  
```
输出以下信息，即导入成功：
```
 > ohpm install @wxqos/wxqcolor                 
ohpm INFO: MetaDataFetcher fetching meta info of package '@wxqos/wxqcolor' from https://ohpm.openharmony.cn/ohpm/
ohpm INFO: fetch meta info of package '@wxqos/wxqcolor' success https://ohpm.openharmony.cn/ohpm/@wxqos/wxqcolor
ohpm INFO: fetch package done 1 @wxqos/wxqcolor from https://ohpm.openharmony.cn/ohpm/@wxqos/wxqcolor/-/wxqcolor-1.0.0.har
ohpm INFO: remove useless folder succeed: "/Users/wxq/Desktop/HMApp_ArkTS/oh_modules/.ohpm/@abner+net@1.1.1/oh_modules/@abner/.DS_Store"
install completed in 0s 431ms
```
项目中导入成功截图：

![23、远程导入成功](https://github.com/user-attachments/assets/e0ae064c-a609-4ef6-82e7-1c78875d2db6)

#### 2、具体的使用和上面本地har包使用一样：
pages引用：
```
import { WXQColor, firstPublicFuncColor } from '@wxqos/wxqcolor'
```
代码使用参考：
```
this.CustomText('主题-红色 firstColor', WXQColor.firstColor)
this.CustomText('文字-重要 textMajorColor', WXQColor.textMajorColor)
this.CustomText('激励、价格等高亮 textLightColor', WXQColor.textLightColor)
this.CustomText('文字-不可用 textUnableColor', WXQColor.textUnableColor)
this.CustomText('-------------------------', WXQColor.lineColor)
this.CustomText('自定义内部主颜色 firstInternalFuncColor', WXQColor.firstInternalFuncColor())
this.CustomText('自定义外部主颜色 firstPublicFuncColor', firstPublicFuncColor())
```

## 五、问题记录
#### 1、ohpm ERROR: Publish failed, detail: You have to specify a correct har_file or tgz_file path.
解决方案：使用命令 ohpm publish  发布HAR包的路径不对。
#### 2、ohpm ERROR: HttpCode 400 The OHPM package author information is empty or the format is invalid.
解决方案：发布的HAR包oh-package.json5中的信息不对，比如name。
#### 3、ohpm ERROR: The content of private key in the key_path error.
解决方案：发布时填写的密码不对，就是生成私钥和公钥时候填写的密码。
#### 4、ohpm ERROR: Publish failed, detail: The "main" or "types" field declare file "Index.d.ets" does not exist in package.
解决方案：发布的HAR包oh-package.json5中填写的"main": "Index.ets"不对
 #### 5、ohpm ERROR: HttpCode 400 The description of the OHPM packet contains 6 to 512 characters.
解决方案：发布的HAR包oh-package.json5中填写的description的长度在 6 到 512字符，重新修改即可。
#### 6、ohpm ERROR: HttpCode 400 Failed to verify the OHPM package group. Ensure that you are a developer of the organization and the organization has been authenticated.
解决方案：发布的HAR包oh-package.json5中填写的name中所使用的group组织名（wxqos）还没有审核通过，等审核通过后再提交即可。
```
 "name": "@wxqos/wxqcolor",
```
----------------------------------

OpenHarmony三方库中心仓地址：[@wxqos/wxqcolor(V1.0.0)](https://ohpm.openharmony.cn/#/cn/detail/@wxqos%2Fwxqcolor)




