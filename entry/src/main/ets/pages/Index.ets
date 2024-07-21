/**
 * app的主页
 */
import CommonConstants from './CommonConstants'
import Home from './Home'
import MySetting from './MySetting'
import router from '@ohos.router'
import buyPage from './BuyPage'


@Entry
@Component
struct Index {
  @State
  currentIndex: number = CommonConstants.HOME_TAB_INDEX
  @State
  phone: number = 0
  private tabsController: TabsController = new TabsController()

  onPageShow(): void {
    let acc = router.getParams() as Record<string, number>
    if (acc) {
      this.phone = acc['sendMsg']
    }
  }

  @Builder
  TabBuilder(title: string, index: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex == index ? selectedImg : normalImg)
        .width($r('app.float.mainPage_baseTab_size'))
        .height($r('app.float.mainPage_baseTab_size'))
      Text(title)
        .margin({ top: $r('app.float.mainPage_baseTab_top') })
        .fontSize($r('app.float.main_tab_fontSize'))
        .fontColor(this.currentIndex === index ? $r('app.color.mainPage_selected') : $r('app.color.mainPage_normal'))
    }
    .justifyContent(FlexAlign.Center)
    .height($r('app.float.mainPage_barHeight'))
    .width(CommonConstants.FULL_PARENT)
    .onClick(() => {
      this.currentIndex = index
      this.tabsController.changeIndex(this.currentIndex) // 修改页签的索引，从而造成页面的切换
    })
  }

  build() {

    Tabs({
      barPosition: BarPosition.End,
      // 页签容器的控制器
      controller: this.tabsController
    }) {
      // 标签容器
      // 第一个页签:首页
      TabContent() {
        Home()
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.HOME_TITLE, CommonConstants.HOME_TAB_INDEX,
        $r('app.media.home_selected'), $r('app.media.home_normal')))

      // 第二个页签:精选页面
      TabContent() {
        buyPage()
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.Good_CHOICE, CommonConstants.GOOD_CHOICE_INDEX,
        $r('app.media.good_choice_blue'), $r('app.media.good_choice')))

      // 第三个页签: 我的设置页面
      TabContent() {
        MySetting({ phone: this.phone })
      }
      .padding({ left: $r('app.float.mainPage_padding'), right: $r('app.float.mainPage_padding') })
      .backgroundColor($r('app.color.mainPage_backgroundColor'))
      .tabBar(this.TabBuilder(CommonConstants.MINE_TITLE, CommonConstants.MINE_TAB_INDEX,
        $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }
    .width(CommonConstants.FULL_PARENT)
    .backgroundColor(Color.White)
    .barHeight($r('app.float.mainPage_barHeight'))
    .barMode(BarMode.Fixed)
  }
}