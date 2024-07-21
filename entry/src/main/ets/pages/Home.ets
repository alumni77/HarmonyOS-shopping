/**
 *  APP首页
 */
import CommonConstants from './CommonConstants'
import DataModel from './DataModel'
import ItemData from './ItemData'
import promptAction from '@ohos.promptAction'


// @Entry
@Component
export default struct Home {
  // 轮播控制器
  private swiperController: SwiperController = new SwiperController()

  build() {
    Scroll() {
      Column({ space: CommonConstants.COMMON_SPACE }) {
        // 第一部分： 标题
        Column() {
          Text($r('app.string.mainPage_tabTitles_home'))
            .fontWeight(FontWeight.Medium)
            .fontSize($r('app.float.page_title_text_size'))
            .margin({ top: $r('app.float.mainPage_tabTitles_margin') })
            .padding({ left: $r('app.float.mainPage_tabTitles_padding') })
        }
        .width(CommonConstants.FULL_PARENT)
        .alignItems(HorizontalAlign.Start)

        // 第二部分： 轮播图片
        Swiper(this.swiperController) {
          ForEach(DataModel.getSwiperImages(), (item: Resource) => {
            // 构建每一张图片组件
            Image(item)
              .borderRadius($r('app.float.home_swiper_borderRadius'))
          })
        }
        .autoPlay(true) // 轮播组件自动播放
        .margin({ top: $r('app.float.home_swiper_margin') })

        // 第三部分： 菜单列表
        // 网格布局
        Grid() {
          ForEach(DataModel.getFirstGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Image(item.img)
                  .width($r('app.float.home_homeCell_size'))
                  .height($r('app.float.home_homeCell_size'))
                  .onClick(() => {
                    promptAction.showToast({
                      message: item.title
                    })
                  })
                Text(item.title)
                  .fontSize($r('app.float.little_text_size'))
                  .margin({ top: $r('app.float.home_homeCell_margin') })
                  .onClick(() => {
                    promptAction.showToast({
                      message: item.title
                    })
                  })
              }
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap($r('app.float.home_grid_columnsGap'))
        .rowsGap($r('app.float.home_grid_rowGap'))
        .padding({ top: $r('app.float.home_grid_padding'), bottom: $r('app.float.home_grid_padding') })
        .height($r('app.float.home_grid_height'))
        .backgroundColor(Color.White)
        .borderRadius($r('app.float.home_grid_borderRadius'))

        // 第四部分:频道列表
        Text($r('app.string.home_list'))
          .fontSize($r('app.float.normal_text_size'))
          .fontWeight(FontWeight.Medium)
          .width(CommonConstants.FULL_PARENT)
          .margin({ top: $r('app.float.home_text_margin') })

        Grid() {
          ForEach(DataModel.getSecondGridData(), (item: ItemData) => {
            GridItem() {
              Column() {
                Text(item.title)
                  .fontSize($r('app.float.normal_text_size'))
                  .fontWeight(FontWeight.Medium)
                  .onClick(() => {
                    promptAction.showToast({
                      message: item.title
                    })
                  })
                Text(item.others)
                  .margin({ top: $r('app.float.home_list_margin') })
                  .fontSize($r('app.float.little_text_size'))
                  .fontColor($r('app.color.home_grid_fontColor'))
                  .onClick(() => {
                    promptAction.showToast({
                      message: item.title
                    })
                  })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .padding({ top: $r('app.float.home_list_padding'), left: $r('app.float.home_list_padding') })
            .borderRadius($r('app.float.home_backgroundImage_borderRadius'))
            .align(Alignment.TopStart)
            .backgroundImage(item.img)
            .backgroundImageSize(ImageSize.Cover)
            .width(CommonConstants.FULL_PARENT)
            .height(CommonConstants.FULL_PARENT)
          })
        }
        .width(CommonConstants.FULL_PARENT)
        .height($r('app.float.home_secondGrid_height'))
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap($r('app.float.home_grid_columnsGap'))
        .rowsGap($r('app.float.home_grid_rowGap'))
        .margin({ bottom: $r('app.float.setting_button_bottom') })
      }
    }
    .height(CommonConstants.FULL_PARENT)
  }
}