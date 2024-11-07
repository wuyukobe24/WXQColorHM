
export class WXQColor {

  //主题-红色 / #FF4B4B
  static firstColor = '#FF4B4B'

  //文字-重要 / #0F1114
  static textMajorColor = '#0F1114'

  //文字-次要 / #565D66
  static textMinorColor = '#565D66'

  //文字-弱提示 / #969CA3
  static textHintColor = '#969CA3'

  //文字-不可用 / #C3C7CC
  static textUnableColor = '#C3C7CC'

  //文字-高亮品牌色 / #F09000
  static textBrandColor = '#F09000'

  //激励、价格等高亮 / #F45D00
  static textLightColor = '#F45D00'

  //文字-可操作或链接提示色 / #2E8AE5
  static textLinkColor = '#2E8AE5'

  //分割线色 / #F0F0F0
  static lineColor = '#F0F0F0'

  //页面背景色、灰底色等 / #F5f6f7
  static backgroundColor = '#F5F6F7'

  // 自定义内部主颜色
  static firstInternalFuncColor(): string {
    return '#FF4B4B'
  }

  // 单例声明
  private static color: WXQColor;
  static instance() {
    if (!WXQColor.color) {
      WXQColor.color = new WXQColor();
    }
    return WXQColor.color;
  }
}

// 自定义外部主颜色
export function  firstPublicFuncColor(): string {
  return '#FF4B4B'
}