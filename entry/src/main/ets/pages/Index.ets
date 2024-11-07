import { WXQColor, firstPublicFuncColor } from 'wxqcolor'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  @Builder
  CustomText(text:string, color:string) {
    Text(text)
      .width('100%')
      .height(50)
      .fontSize(20)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
      .fontColor(color)
  }

  build() {
    RelativeContainer() {
      Column({space:20}) {
        this.CustomText('主题-红色 firstColor', WXQColor.firstColor)
        this.CustomText('文字-重要 textMajorColor', WXQColor.textMajorColor)
        this.CustomText('激励、价格等高亮 textLightColor', WXQColor.textLightColor)
        this.CustomText('文字-不可用 textUnableColor', WXQColor.textUnableColor)
        this.CustomText('-------------------------', WXQColor.lineColor)
        this.CustomText('自定义内部主颜色 firstInternalFuncColor', WXQColor.firstInternalFuncColor())
        this.CustomText('自定义外部主颜色 firstPublicFuncColor', firstPublicFuncColor())
      }
      // 设置页面背景色
      .backgroundColor(WXQColor.backgroundColor)
    }
    .height('100%')
    .width('100%')
  }
}