## 自定义颜色

### 使用参考：
库导入：
```c
ohpm install @wxqos/wxqcolor
```
pages引用：
```c
import { WXQColor, firstPublicFuncColor } from '@wxqos/wxqcolor'
```
代码使用参考：
```c
this.CustomText('主题-红色 firstColor', WXQColor.firstColor)
this.CustomText('文字-重要 textMajorColor', WXQColor.textMajorColor)
this.CustomText('激励、价格等高亮 textLightColor', WXQColor.textLightColor)
this.CustomText('文字-不可用 textUnableColor', WXQColor.textUnableColor)
this.CustomText('-------------------------', WXQColor.lineColor)
this.CustomText('自定义内部主颜色 firstInternalFuncColor', WXQColor.firstInternalFuncColor())
this.CustomText('自定义外部主颜色 firstPublicFuncColor', firstPublicFuncColor())
```

使用效果截图：
![11、使用效果截图.png](..%2F..%2F..%2FDesktop%2Fhar%E5%8C%85%E7%9A%84%E5%88%9B%E5%BB%BA%E5%92%8C%E5%8F%91%E5%B8%83-%E6%88%AA%E5%9B%BE%2F11%E3%80%81%E4%BD%BF%E7%94%A8%E6%95%88%E6%9E%9C%E6%88%AA%E5%9B%BE.png)