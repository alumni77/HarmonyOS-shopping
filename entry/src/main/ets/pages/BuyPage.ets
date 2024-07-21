import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import barList from '../component/Arr/barList'
import { productStore } from '../component/Store/productStore'
import barItem from '../component/interface/TabItemInterface'
import set from '../component/interface/setInterface'


class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 60
  endMargin: Length = 10
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
}

@Entry
@Component
struct BuyPage {
  @State BarList: barItem[] = barList;
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  @State $$cartItems: set[] = productStore;

  addCar(product: set) {
    this.$$cartItems.push(product)
  }

  build() {
    Row() {
      Column() {
        Row() {
          Image($r('app.media.Back'))
            .margin({ right: 20 })
            .width(20)
            .height(20)
            .onClick(() => {
              router.replaceUrl({
                url: "pages/Index"
              })
            })
          Text("商城").fontSize(18).fontWeight(FontWeight.Bolder)
        }
        .border({
          width: { bottom: 1 },
          color: "#ffbcbaba"
        })
        .padding(20)
        .width('100%')
        .height(60)


        Tabs({ barPosition: BarPosition.Start }) {
          ForEach(this.BarList, (item: barItem) => {
            TabContent() {
              List() {
                ForEach(item.bar, (barContent: set) => {
                  ListItem() {
                    Row() {
                      Image(barContent.img)
                        .width(120)
                        .height(120)
                        .onClick(() => {
                          promptAction.showToast({
                            message: barContent.title
                          })
                        })
                      Column() {
                        Text(barContent.title)
                          .onClick(() => {
                            promptAction.showToast({
                              message: barContent.title
                            })
                          })
                        Row() {
                          Text(barContent.profile).fontSize(12).margin({ left: 5 })
                            .onClick(() => {
                              promptAction.showToast({
                                message: barContent.title
                              })
                            })
                          Text(barContent.price).fontColor("#ffba3333").fontSize(15).margin({ left: 40 })
                            .onClick(() => {
                              promptAction.showToast({
                                message: barContent.title
                              })
                            })
                        }
                        .justifyContent(FlexAlign.SpaceBetween)
                      }
                      .width(225)
                      .height(120)
                      .alignItems(HorizontalAlign.Start)
                      .justifyContent(FlexAlign.SpaceBetween)
                    }
                    .justifyContent(FlexAlign.Start)
                    .padding(
                      {
                        bottom: 5
                      }
                    )
                    .width('100%')
                  }
                })
              }
              .divider(this.egDivider)
            }.tabBar(item.title)
          })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

export default BuyPage;